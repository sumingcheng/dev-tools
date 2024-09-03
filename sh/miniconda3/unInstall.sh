#!/bin/bash

# 检查 Miniconda 是否已安装
if [ ! -d "$HOME/miniconda3" ]; then
    echo "未找到 Miniconda 安装目录，可能已经被移除。"
    exit 1
fi

read -p "确定要卸载 Miniconda 吗? 这将移除 $HOME/miniconda3 目录和相关配置。[y/n]: " confirm
if [[ "$confirm" != [Yy] ]]; then
    echo "取消卸载"
    exit 0
fi

echo "正在移除 Miniconda 目录..."
rm -rf "$HOME/miniconda3"

# 自动从bash和zsh配置文件中删除Conda初始化代码
for rcfile in "$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.zshrc"
do
    if [ -f "$rcfile" ]; then
        echo "正在清理 $rcfile..."
        # 删除conda初始化的代码块
        sed -i '/# >>> conda initialize >>>/,/# <<< conda initialize <<</d' "$rcfile"
        # 删除单独添加到PATH的conda路径
        sed -i '/export PATH=".*miniconda3\/bin:$PATH"/d' "$rcfile"
    fi
done

echo "Miniconda 卸载完成。"
echo "如果需要，手动检查并编辑配置文件，以确保所有关于 Miniconda 的引用都被移除。"
