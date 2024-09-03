#!/bin/bash

read -p "确定要卸载 Anaconda 吗? 这将移除 /opt/anaconda3 目录和相关配置。[y/n]: " confirm
if [[ "$confirm" != [Yy] ]]; then
    echo "取消卸载"
    exit 0
fi

if [ -d "/opt/anaconda3" ]; then
    echo "正在移除 Anaconda 目录..."
    sudo rm -rf "/opt/anaconda3"
else
    echo "未找到 Anaconda 目录，可能已经被移除。"
fi

echo "清理环境变量配置..."
if [ -f "/etc/profile.d/conda.sh" ]; then
    sudo rm "/etc/profile.d/conda.sh"
    echo "已移除环境初始化文件 /etc/profile.d/conda.sh"
else
    echo "未找到环境初始化文件 /etc/profile.d/conda.sh，可能已经被移除。"
fi

for file in $HOME/.bashrc $HOME/.bash_profile $HOME/.zshrc; do
    if [ -f "$file" ]; then
        echo "正在从 $file 中移除 Conda 配置..."
        sed -i '/conda init/d' $file
        sed -i '/conda activate/d' $file
    fi
done

echo "正在移除隐藏的 Conda 目录..."
rm -rf $HOME/.conda
rm -rf $HOME/.continuum

echo "Anaconda 卸载完成。"
