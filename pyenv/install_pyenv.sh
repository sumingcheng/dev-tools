#!/bin/bash
#
# Usage: curl https://pyenv.run | bash
#
# For more info, visit: https://github.com/pyenv/pyenv-installer

echo "正在安装 pyenv..."
index_main() {
    set -e  # 启用错误检查：遇到错误时脚本将停止执行。
    # 使用 -v 参数增加详细输出，以便能看到所有步骤的执行详情
    curl -v -S -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
}

index_main

echo "pyenv 安装完成。"
echo "正在配置环境变量..."

# 配置环境变量
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

echo "环境变量配置完成。"
echo "正在使环境变量更改生效..."

# 使更改生效
source ~/.bashrc

echo "环境变量已生效。"
echo "正在检查 pyenv 版本..."

# 显示 pyenv 版本
pyenv --version

echo "pyenv 版本检查完成。"
