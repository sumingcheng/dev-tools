#!/bin/bash

# 检查 wget 是否已安装
if ! command -v wget &> /dev/null
then
    echo "wget 未安装，正在退出..."
    exit 1
fi

# 设置 Anaconda 安装器的 URL
INSTALLER_URL="https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh"

# 下载 Anaconda 安装器
echo "正在下载 Anaconda 安装器..."
wget "$INSTALLER_URL" -O anaconda_installer.sh

if [ $? -ne 0 ]; then
    echo "下载失败，正在退出..."
    exit 1
fi

# 为安装器添加执行权限
chmod +x anaconda_installer.sh

# 检查 Anaconda 是否已安装
if [ -d "$HOME/anaconda3" ]; then
    read -p "Anaconda 已安装，是否重新安装? [y/n]: " answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        rm -rf "$HOME/anaconda3"
    else
        echo "取消安装"
        exit 0
    fi
fi

# 安装 Anaconda
echo "正在安装 Anaconda..."
./anaconda_installer.sh -b -p $HOME/anaconda3

# 清理安装器文件
rm anaconda_installer.sh

# 更新 .bashrc 文件，添加 Anaconda 初始化
echo "正在更新 .bashrc ..."
echo "source $HOME/anaconda3/etc/profile.d/conda.sh" >> $HOME/.bashrc
echo "conda activate" >> $HOME/.bashrc

echo "Anaconda 安装完成，终端重启后将自动激活 Anaconda 环境。"
