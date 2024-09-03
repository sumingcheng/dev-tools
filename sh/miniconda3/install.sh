#!/bin/bash

# 检查 wget 是否已安装
if ! command -v wget &> /dev/null
then
    echo "wget 未安装，正在退出..."
    exit 1
fi

# 设置 Miniconda 安装器的 URL
INSTALLER_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"

# 下载 Miniconda 安装器
echo "正在下载 Miniconda 安装器..."
wget "$INSTALLER_URL" -O miniconda_installer.sh

if [ $? -ne 0 ]; then
    echo "下载失败，正在退出..."
    exit 1
fi

# 为安装器添加执行权限
chmod +x miniconda_installer.sh

# 检查 Miniconda 是否已安装
if [ -d "$HOME/miniconda3" ]; then
    while true; do
        read -p "Miniconda 已安装，是否重新安装? [y/n]: " answer
        case $answer in
            [Yy]* ) rm -rf "$HOME/miniconda3"; break;;
            [Nn]* ) echo "取消安装"; exit 0;;
            * ) echo "请输入 Y 或 N。";;
        esac
    done
fi

# 安装 Miniconda
echo "正在安装 Miniconda..."
./miniconda_installer.sh -b -p $HOME/miniconda3

# 清理安装器文件
rm miniconda_installer.sh

echo "Miniconda 安装完成。请手动执行 'source $HOME/miniconda3/etc/profile.d/conda.sh' 或重启终端以激活 Miniconda 环境。"
