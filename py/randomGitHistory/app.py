import git
import random
from datetime import datetime

# 使用当前目录作为仓库路径
repo = git.Repo(".")

# 获取所有提交记录
commits = list(repo.iter_commits('main'))  # 如果不是 master 分支，修改成当前分支

# 设置时间范围（2016 Q4到2019 Q4）
start_date = datetime(2016, 10, 1)
end_date = datetime(2019, 12, 31)

# 修改每个提交的时间戳
for commit in commits:
    # 生成一个随机的时间戳
    random_date = start_date + (end_date - start_date) * random.random()

    # 使用 git commit --amend 修改提交的时间
    random_date_str = random_date.strftime('%a, %d %b %Y %H:%M:%S %z')

    # 修改提交时间
    repo.git.commit('--amend', '--no-edit', '--date', random_date_str)

    print(f"提交 {commit.hexsha} 的时间已修改为 {random_date}")

# 注意：修改提交历史会导致提交哈希改变，所以请小心使用。
