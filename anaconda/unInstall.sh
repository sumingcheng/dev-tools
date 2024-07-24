#!/bin/bash

# 确认卸载
read -p "确定要卸载 Anaconda 吗? 这将移除所有安装的内容和配置文件。[y/n]: " confirm
if [[ "$confirm" != [Yy] ]]; then
    echo "取消卸载"
    exit 0
fi

# 检查 Anaconda 安装目录
if [ -d "$HOME/anaconda3" ]; then
    echo "正在移除 Anaconda 目录..."
    rm -rf "$HOME/anaconda3"
else
    echo "未找到 Anaconda 目录，可能已经被移除。"
fi

# 清理环境变量配置
echo "清理环境变量配置..."
if [ -f "$HOME/.bashrc" ]; then
    # 删除 .bashrc 中与 Anaconda 相关的行
    sed -i '/anaconda3\/etc\/profile.d\/conda.sh/d' $HOME/.bashrc
    sed -i '/conda activate/d' $HOME/.bashrc
fi

# 刷新环境配置
echo "重新加载 .bashrc ..."
source $HOME/.bashrc

echo "Anaconda 卸载完成。"
