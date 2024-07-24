#!/bin/bash

# 确认卸载
read -p "确定要卸载 Anaconda 吗? 这将移除/opt/anaconda3 目录和相关配置。[y/n]: " confirm
if [[ "$confirm" != [Yy] ]]; then
    echo "取消卸载"
    exit 0
fi

# 检查 Anaconda 安装目录是否存在
if [ -d "/opt/anaconda3" ]; then
    echo "正在移除 Anaconda 目录..."
    sudo rm -rf "/opt/anaconda3"
else
    echo "未找到 Anaconda 目录，可能已经被移除。"
fi

# 清理环境变量配置
echo "清理环境变量配置..."
if [ -f "/etc/profile.d/conda.sh" ]; then
    sudo rm "/etc/profile.d/conda.sh"
    echo "已移除环境初始化文件 /etc/profile.d/conda.sh"
else
    echo "未找到环境初始化文件 /etc/profile.d/conda.sh，可能已经被移除。"
fi

echo "Anaconda 卸载完成。"
