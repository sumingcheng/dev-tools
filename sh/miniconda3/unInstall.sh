#!/bin/bash

# 检查 /opt/miniconda3 目录是否存在
if [ ! -d "/opt/miniconda3" ]; then
    echo "未找到 Miniconda 安装目录 /opt/miniconda3，可能已经被移除。"
    exit 1
fi

# 确认用户想要卸载 Miniconda
read -p "确定要卸载 Miniconda 吗? 这将移除 /opt/miniconda3 目录和相关配置。[y/n]: " confirm
if [[ "$confirm" != [Yy] ]]; then
    echo "取消卸载"
    exit 0
fi

# 使用 sudo 权限移除 Miniconda 目录
echo "正在移除 Miniconda 目录 /opt/miniconda3..."
sudo rm -rf "/opt/miniconda3"

# 自动从全局配置文件中删除 Miniconda 的环境初始化代码
if [ -f "/etc/profile.d/miniconda3.sh" ]; then
    echo "正在移除全局环境初始化脚本 /etc/profile.d/miniconda3.sh..."
    sudo rm "/etc/profile.d/miniconda3.sh"
fi

echo "Miniconda 卸载完成。"
echo "请手动检查其他配置文件，如 ~/.bashrc 或 ~/.bash_profile，确保所有 Miniconda 相关配置已经被清除。"
