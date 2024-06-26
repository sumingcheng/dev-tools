#!/bin/bash

handle_error() {
    echo "$1"  # 传入错误信息作为参数
    exit 1
}

# 检查并安装 jq
if ! command -v jq &>/dev/null; then
    echo "jq 未安装，正在安装 jq..."
    sudo apt-get update && sudo apt-get install -y jq || handle_error "jq 安装失败，脚本终止。"
fi

# 检查文件是否存在
if [ ! -f apt-list.json ]; then
    handle_error "找不到文件 apt-list.json，脚本终止。"
fi

# 更新软件包索引
sudo apt-get update || handle_error "软件包列表更新失败，脚本终止。"

# 初始化计数器和失败包的列表
total_packages=0
success_count=0
fail_count=0
failed_packages=()

# 从JSON文件中读取软件包名称并存储到数组中
mapfile -t packages < <(jq -r '.[].name' apt-list.json)

# 安装软件包
for pkg in "${packages[@]}"; do
    echo "准备安装 $pkg..."
    if sudo apt-get install -y "$pkg"; then
        ((success_count++))
    else
        ((fail_count++))
        failed_packages+=("$pkg")
    fi
done

echo "尝试安装 $total_packages 个包：成功 $success_count 个，失败 $fail_count 个。失败的包：${failed_packages[*]}"
