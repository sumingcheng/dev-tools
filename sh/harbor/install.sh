#!/bin/bash

# 检查 root 用户权限
if [[ $(id -u) -ne 0 ]]; then
    echo "此脚本需要以 root 用户权限运行"
    exit 1
fi

# 显示代理设置
echo "HTTP Proxy: $HTTP_PROXY"
echo "HTTPS Proxy: $HTTPS_PROXY"

# 默认参数设置
HARBOR_VERSION="v2.11.1"
HARBOR_INSTALLER="harbor-offline-installer-${HARBOR_VERSION}.tgz"
HARBOR_URL="https://github.com/goharbor/harbor/releases/download/${HARBOR_VERSION}/${HARBOR_INSTALLER}"

# 显示使用方法
usage() {
    echo "用法: $0 [--version <harbor-version>]"
    echo "默认下载 Harbor v${HARBOR_VERSION} 安装包。"
}

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --version) HARBOR_VERSION="$2"; HARBOR_INSTALLER="harbor-offline-installer-${HARBOR_VERSION}.tgz"; HARBOR_URL="https://github.com/goharbor/harbor/releases/download/${HARBOR_VERSION}/${HARBOR_INSTALLER}"; shift ;;
        *) echo "未知参数: $1"; usage; exit 1 ;;
    esac
    shift
done

# 下载并解压 Harbor
download_and_unpack() {
    echo "正在下载 Harbor 安装包..."
    wget --no-check-certificate -c ${HARBOR_URL} -O ${HARBOR_INSTALLER} || { echo "下载失败"; exit 1; }
    
    echo "正在解压安装包..."
    tar xvf ${HARBOR_INSTALLER} || { echo "解压失败"; exit 1; }
}

# 配置 Harbor
configure_harbor() {
    echo "正在配置 Harbor..."
    cd harbor || { echo "进入目录失败"; exit 1; }
    # 使用当前目录下的 config.yml 覆盖原来的 harbor.yml
    cp ../config.yml harbor.yml
}

# 主执行流程
download_and_unpack
configure_harbor

echo "Harbor 已下载并解压。请查看 'harbor' 目录中的 docker-compose.yml 文件，并使用以下命令来启动 Harbor："
echo "cd harbor"
echo "docker-compose up -d"

echo "默认管理员用户名: admin"
echo "默认管理员密码: Harbor12345"
