#!/bin/bash

# 使用说明：通过 bash 执行此脚本以卸载 pyenv
# 更多信息可参见 pyenv 的官方文档

set -e  # 启用错误检查：遇到错误时脚本将停止执行。

echo "开始卸载 pyenv..."

# 移除 pyenv 安装目录
if [ -d "$HOME/.pyenv" ]; then
    rm -rf "$HOME/.pyenv"
    echo "已删除 pyenv 安装目录。"
else
    echo "未找到 pyenv 安装目录，可能已经被移除。"
fi

echo "正在更新 shell 配置文件，移除 pyenv 相关设置..."

# 删除 .bashrc 中的 pyenv 相关环境变量设置
sed -i '/PYENV_ROOT/d' "$HOME/.bashrc"
sed -i '/pyenv init/d' "$HOME/.bashrc"
sed -i '/pyenv virtualenv-init/d' "$HOME/.bashrc"

echo "shell 配置文件更新完成。"

echo "请手动执行 'source ~/.bashrc' 以使更改生效。"

echo "pyenv 已成功卸载。"
