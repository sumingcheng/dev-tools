#!/bin/bash

# 检查文件是否存在
if [ ! -f apt-list.txt ]; then
    echo "找不到文件 apt-list.txt，脚本终止。"
    exit 1
fi

# 更新软件包索引
if ! sudo apt-get update; then
    echo "软件包列表更新失败，脚本终止。"
    exit 1
fi

# 初始化计数器和失败包的列表
total_packages=0
success_count=0
fail_count=0
failed_packages=()

# 读取apt-list.txt文件中的软件包列表
while read -r pkg; do
    if [ -n "$pkg" ]; then  # 确保不是空行
        ((total_packages++))
        echo "准备安装 $pkg..."
        # 安装软件包并允许用户交互
        if sudo apt-get install -y $pkg; then
            ((success_count++))
        else
            ((fail_count++))
            failed_packages+=($pkg)
        fi
    fi
done < apt-list.txt

# 输出安装总结
echo "安装过程完成。"
echo "一共尝试安装 $total_packages 个包。"
echo "成功安装 $success_count 个包。"
echo "安装失败 $fail_count 个包。"

if [ $fail_count -gt 0 ]; then
    echo "以下包安装失败："
    printf '%s\n' "${failed_packages[@]}"
fi
