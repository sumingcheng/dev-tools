#!/bin/bash

# 设置时间范围
start_date="2016-10-01"
end_date="2019-12-31"

# 计算时间范围内的总天数
start_seconds=$(date -d "$start_date" +%s)
end_seconds=$(date -d "$end_date" +%s)
total_days=$(( (end_seconds - start_seconds) / 86400 ))

echo "时间范围: $start_date 到 $end_date (共 $total_days 天)"

# 获取提交总数
total_commits=$(git log --pretty=format:"%H" | wc -l)
echo "仓库总提交数: $total_commits"

if [ $total_commits -eq 0 ]; then
    echo "错误: 没有找到任何提交记录"
    exit 1
fi

# 获取所有提交的哈希值（从最早到最新）
commits=($(git log --reverse --pretty=format:"%H"))

# 计算每年应该分配的提交数量
years_span=4  # 2016-10-01 到 2019-12-31，约4年
commits_per_year=$(( (total_commits + years_span - 1) / years_span ))  # 向上取整
echo "计划每年分配约 $commits_per_year 个提交"

# 生成均匀分布的日期序列
echo "正在生成均匀分布的日期序列..."
declare -a dates

# 定义年份边界（秒数）
year_2016_start=$start_seconds
year_2017_start=$(date -d "2017-01-01" +%s)
year_2018_start=$(date -d "2018-01-01" +%s)
year_2019_start=$(date -d "2019-01-01" +%s)
year_2020_start=$(date -d "2020-01-01" +%s)

# 计算每个年份的时间跨度（秒）
year_2016_span=$((year_2017_start - year_2016_start))
year_2017_span=$((year_2018_start - year_2017_start))
year_2018_span=$((year_2019_start - year_2018_start))
year_2019_span=$((year_2020_start - year_2019_start))

# 为每个提交分配年份和日期
for ((i=0; i<${#commits[@]}; i++)); do
    # 确定这个提交应该属于哪一年
    year_index=$(( i / commits_per_year ))

    # 根据年份索引确定时间范围
    case $year_index in
        0)  # 2016年
            year_start=$year_2016_start
            year_span=$year_2016_span
            ;;
        1)  # 2017年
            year_start=$year_2017_start
            year_span=$year_2017_span
            ;;
        2)  # 2018年
            year_start=$year_2018_start
            year_span=$year_2018_span
            ;;
        *)  # 2019年及以后的都放在2019年
            year_start=$year_2019_start
            year_span=$year_2019_span
            ;;
    esac

    # 在该年份内随机选择一个时间点
    # 对于同一年内的提交，确保时间是递增的
    if [ $i -eq 0 ] || [ $year_index -gt $(( (i-1) / commits_per_year )) ]; then
        # 新的一年的第一个提交，或者整个仓库的第一个提交
        random_offset=$((RANDOM % (year_span / 4)))  # 在年初的1/4时间范围内
    else
        # 获取上一个提交的时间
        prev_seconds=$(date -d "${dates[$i-1]}" +%s)

        # 确保时间递增，在上一个提交之后，但不超过当年年底
        available_span=$((year_start + year_span - prev_seconds))
        if [ $available_span -le 0 ]; then
            # 如果已经到了年底，就使用年底的时间
            random_offset=0
            current_seconds=$((year_start + year_span - 86400))  # 年底前一天
        else
            # 在剩余时间内随机选择，但确保至少间隔1-7天
            min_gap=$((86400 * (1 + RANDOM % 7)))
            if [ $available_span -lt $min_gap ]; then
                random_offset=$available_span
            else
                random_offset=$((min_gap + RANDOM % (available_span - min_gap)))
            fi
            current_seconds=$((prev_seconds + random_offset))
        fi
    fi

    if [ ! -v current_seconds ]; then
        current_seconds=$((year_start + random_offset))
    fi

    # 确保不超过结束日期
    if [ $current_seconds -gt $end_seconds ]; then
        current_seconds=$end_seconds
    fi

    # 转换为日期格式
    commit_date=$(date -d "@$current_seconds" "+%Y-%m-%d %H:%M:%S")
    dates[$i]=$commit_date
done

# 显示修改计划和年份分布统计
echo "将修改以下提交的日期:"
declare -A year_count
for ((i=0; i<${#commits[@]}; i++)); do
    year=$(date -d "${dates[$i]}" "+%Y")
    echo "提交 ${commits[$i]:0:8} -> ${dates[$i]}"

    # 统计每年的提交数量
    if [ -v year_count[$year] ]; then
        year_count[$year]=$((year_count[$year] + 1))
    else
        year_count[$year]=1
    fi
done

# 显示每年的提交数量统计
echo -e "\n每年提交数量统计:"
for year in "${!year_count[@]}"; do
    echo "$year年: ${year_count[$year]}个提交"
done

# 确认是否继续
read -p "是否继续修改提交历史? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "操作已取消"
    exit 0
fi

# 使用 git filter-branch 修改提交日期
echo "开始修改提交历史..."

# 清除之前的备份（如果存在）
echo "清除之前的备份..."
git update-ref -d refs/original/refs/heads/master 2>/dev/null
git update-ref -d refs/original/refs/heads/main 2>/dev/null
rm -rf .git/refs/original/ 2>/dev/null

# 创建临时脚本
temp_script=$(mktemp)
echo "#!/bin/bash" > $temp_script
echo "case \$GIT_COMMIT in" >> $temp_script

for ((i=0; i<${#commits[@]}; i++)); do
    commit=${commits[$i]}
    date_str=${dates[$i]}
    formatted_date=$(date -d "$date_str" "+%a, %d %b %Y %H:%M:%S %z")
    echo "  $commit)" >> $temp_script
    echo "    export GIT_AUTHOR_DATE=\"$formatted_date\"" >> $temp_script
    echo "    export GIT_COMMITTER_DATE=\"$formatted_date\"" >> $temp_script
    echo "    ;;" >> $temp_script
done

echo "esac" >> $temp_script
chmod +x $temp_script

# 执行 filter-branch，使用 -f 强制覆盖
export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --env-filter "source $temp_script" --tag-name-filter cat -- --all

# 清理
rm $temp_script
echo "提交历史修改完成!"

# 验证修改是否成功
echo "验证修改结果:"
git log --pretty=format:"%h %ad %s" --date=short | head -10

echo "注意: 这是一个强制性的历史重写操作，如果这是一个共享仓库，其他协作者需要重新克隆或进行复杂的同步。"
echo "如果需要推送到远程仓库，请使用: git push -f origin 你的分支名"