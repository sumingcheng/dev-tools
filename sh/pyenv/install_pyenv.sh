#!/bin/bash

# 使用说明: 通过bash执行此脚本以安装pyenv
# 更多信息参见: https://github.com/pyenv/pyenv

set -e  # 启用错误检查：遇到错误时脚本将停止执行

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 日志函数
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# 检查是否为root用户执行
check_root() {
    if [ "$(id -u)" != "0" ]; then
        log_error "此脚本需要root权限执行"
        log_info "请使用: sudo bash $0"
        exit 1
    fi
}

# 安装依赖
install_dependencies() {
    log_info "正在安装必要的依赖..."
    apt update
    apt install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
    liblzma-dev python3-openssl git
    
    if [ $? -ne 0 ]; then
        log_error "依赖安装失败"
        exit 1
    fi
    log_info "依赖安装完成"
}

# 安装pyenv
install_pyenv() {
    log_info "开始安装 pyenv..."
    
    # 检查是否已安装pyenv
    if command -v pyenv &> /dev/null; then
        log_warn "检测到pyenv已安装，将进行更新..."
        pyenv update
        return
    fi
    
    # 使用官方推荐的安装方式
    curl https://pyenv.run | bash
    
    if [ $? -ne 0 ]; then
        log_error "pyenv 安装失败"
        exit 1
    fi
    log_info "pyenv 安装成功"
}

# 配置环境变量
configure_environment() {
    log_info "正在配置环境变量..."
    
    # 检查.bashrc文件
    if [ ! -f "$HOME/.bashrc" ]; then
        touch "$HOME/.bashrc"
        log_info "创建了新的 .bashrc 文件"
    fi
    
    # 备份.bashrc
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
    log_info "已备份原有的 .bashrc 文件"
    
    # 添加环境变量配置
    {
        echo '# pyenv configuration'
        echo 'export PYENV_ROOT="$HOME/.pyenv"'
        echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"'
        echo 'eval "$(pyenv init -)"'
    } >> "$HOME/.bashrc"
    
    log_info "环境变量配置完成"
}

# 主函数
main() {
    check_root
    install_dependencies
    install_pyenv
    configure_environment
    
    log_info "pyenv 安装和配置已完成！"
    log_info "请执行以下命令使配置生效："
    echo -e "${GREEN}    source ~/.bashrc${NC}"
    
    log_info "然后可以使用以下命令安装Python："
    echo -e "${GREEN}    pyenv install --list${NC}     # 查看可用的Python版本"
    echo -e "${GREEN}    pyenv install 3.10.0${NC}     # 安装特定版本"
    echo -e "${GREEN}    pyenv global 3.10.0${NC}      # 设置全局Python版本"
}

# 执行主函数
main
