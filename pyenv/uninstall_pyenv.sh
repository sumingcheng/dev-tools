#!/bin/bash

# Step 1: 删除 pyenv 安装目录
echo "正在删除 pyenv 安装目录..."
rm -rf ~/.pyenv

# Step 2: 清除 shell 配置文件中的 pyenv 相关条目
echo "正在更新 shell 配置文件，移除 pyenv 相关设置..."
if [ -f ~/.bashrc ]; then
    sed -i '/export PYENV_ROOT="$HOME\/.pyenv"/d' ~/.bashrc
    sed -i '/export PATH="$PYENV_ROOT\/bin:$PATH"/d' ~/.bashrc
    sed -i '/eval "\$(pyenv init --path)"/d' ~/.bashrc
    sed -i '/eval "\$(pyenv virtualenv-init -)"/d' ~/.bashrc
fi

if [ -f ~/.zshrc ]; then
    sed -i '/export PYENV_ROOT="$HOME\/.pyenv"/d' ~/.zshrc
    sed -i '/export PATH="$PYENV_ROOT\/bin:$PATH"/d' ~/.zshrc
    sed -i '/eval "\$(pyenv init --path)"/d' ~/.zshrc
    sed -i '/eval "\$(pyenv virtualenv-init -)"/d' ~/.zshrc
fi

# Step 3: 重新加载配置文件
echo "重新加载 shell 配置文件..."
source ~/.bashrc || source ~/.zshrc

# Step 4: 检查 pyenv 是否已完全移除
if [ -z "$(command -v pyenv)" ]; then
    echo "pyenv 已成功移除。"
else
    echo "移除 pyenv 失败，请手动检查。"
fi
