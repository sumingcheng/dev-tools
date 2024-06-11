#!/bin/bash
#
# Usage: curl https://pyenv.run | bash
#
# For more info, visit: https://github.com/pyenv/pyenv-installer
echo "正在安装 pyenv..."
index_main() {
    set -e  # Enable error checking: script will stop on any error.
    curl -s -S -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
}

index_main


# 配置环境变量
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# 使更改生效
source ~/.bashrc

# 显示 pyenv 版本
pyenv --version