#!/bin/bash

# 使用说明：通过 bash 执行此脚本以卸载 pyenv
# 更多信息可参见: https://github.com/pyenv/pyenv

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

# 备份.bashrc文件
backup_bashrc() {
    if [ -f "$HOME/.bashrc" ]; then
        backup_file="$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$HOME/.bashrc" "$backup_file"
        log_info "已备份 .bashrc 文件到: $backup_file"
    fi
}

# 移除pyenv安装目录
remove_pyenv_directory() {
    log_info "正在移除 pyenv 安装目录..."
    
    if [ -d "$HOME/.pyenv" ]; then
        rm -rf "$HOME/.pyenv"
        log_info "已删除 pyenv 安装目录"
    else
        log_warn "未找到 pyenv 安装目录，可能已被移除"
    fi
}

# 清理环境变量配置
clean_environment() {
    log_info "正在清理 shell 配置文件..."
    
    if [ ! -f "$HOME/.bashrc" ]; then
        log_warn "未找到 .bashrc 文件"
        return
    fi
    
    # 备份原始文件
    backup_bashrc
    
    # 移除pyenv相关配置
    local tmp_file=$(mktemp)
    grep -v "# pyenv configuration" "$HOME/.bashrc" | \
    grep -v "PYENV_ROOT" | \
    grep -v "pyenv init" | \
    grep -v "pyenv virtualenv-init" > "$tmp_file"
    
    mv "$tmp_file" "$HOME/.bashrc"
    log_info "已清理 pyenv 相关环境变量配置"
}

# 清理pyenv相关包
clean_packages() {
    log_info "正在清理 pyenv 相关软件包..."
    
    # 获取所有已安装的Python版本
    if command -v pyenv &> /dev/null; then
        local versions=$(pyenv versions --bare)
        if [ ! -z "$versions" ]; then
            log_warn "发现以下Python版本将被删除:"
            echo "$versions"
        fi
    fi
}

# 主函数
main() {
    log_info "开始卸载 pyenv..."
    
    check_root
    clean_packages
    remove_pyenv_directory
    clean_environment
    
    log_info "pyenv 卸载完成！"
    log_info "请执行以下命令使配置生效："
    echo -e "${GREEN}    source ~/.bashrc${NC}"
    
    log_warn "注意：如果您使用的是其他shell（如zsh），请相应清理其配置文件"
    log_info "卸载过程已完成"
}

# 执行主函数
main
