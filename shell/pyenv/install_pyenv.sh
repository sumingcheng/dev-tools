#!/bin/bash

# 使用说明: 通过bash执行此脚本以安装pyenv
# 更多信息参见: https://github.com/pyenv/pyenv-installer

set -e  # 启用错误检查：遇到错误时脚本将停止执行。

echo "开始安装 pyenv..."

# 定义一个函数来安装 pyenv
install_pyenv() {
    # 检查 curl 是否已安装
    if ! command -v curl &> /dev/null; then
        echo "错误：curl 未安装，无法下载 pyenv。" >&2
        exit 1
    fi
    
    # 下载并执行安装脚本
    curl -# -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
}

# 调用安装函数
install_pyenv
echo "pyenv 安装成功。"

echo "正在配置环境变量..."

# 检查.bashrc文件是否存在
if [ ! -f "$HOME/.bashrc" ]; then
    touch "$HOME/.bashrc"
    echo "创建了新的 .bashrc 文件。"
fi

# 配置环境变量
{
    echo 'export PYENV_ROOT="$HOME/.pyenv"'
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"'
    echo 'eval "$(pyenv init --path)"'
    echo 'eval "$(pyenv virtualenv-init -)"'
} >> "$HOME/.bashrc"

echo "环境变量配置完成。"


echo "请手动执行 'source ~/.bashrc' 以使环境变量更改生效。"
