#!/bin/bash

# 检查是否为 root 用户运行
if [[ $(id -u) -ne 0 ]]; then
    echo "此脚本需要以 root 用户权限运行"
    exit 1
fi

# 代理检查
echo "HTTP Proxy: $HTTP_PROXY"
echo "HTTPS Proxy: $HTTPS_PROXY"

# 设置默认参数
HOSTNAME="172.22.220.64"
HTTP_PORT="9999"
DATA_VOLUME="/data/harbor"
HARBOR_VERSION="v2.5.0"
HARBOR_INSTALLER="harbor-offline-installer-${HARBOR_VERSION}.tgz"
HARBOR_URL="https://github.com/goharbor/harbor/releases/download/${HARBOR_VERSION}/${HARBOR_INSTALLER}"

# 打印用法
usage() {
    echo "用法: $0 [--hostname <hostname>] [--http-port <port>] [--data-volume <path>]"
    echo "默认安装 Harbor v${HARBOR_VERSION} 至指定主机和端口。"
}

# 解析命令行参数
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --hostname) HOSTNAME="$2"; shift ;;
        --http-port) HTTP_PORT="$2"; shift ;;
        --data-volume) DATA_VOLUME="$2"; shift ;;
        *) echo "未知参数: $1"; usage; exit 1 ;;
    esac
    shift
done

# 功能：下载并解压 Harbor
download_and_unpack() {
    echo "正在下载 Harbor 安装包..."
    wget --no-check-certificate -c ${HARBOR_URL} -O ${HARBOR_INSTALLER} || { echo "下载失败"; exit 1; }
    
    echo "正在解压安装包..."
    tar xvf ${HARBOR_INSTALLER} || { echo "解压失败"; exit 1; }
}

# 功能：配置 Harbor
configure_harbor() {
    echo "正在配置 Harbor..."
    cd harbor || { echo "进入目录失败"; exit 1; }
    cp harbor.yml.tmpl harbor.yml
    sed -i "s/hostname: reg.mydomain.com/hostname: ${HOSTNAME}/" harbor.yml
    sed -i "s/port: 80/port: ${HTTP_PORT}/" harbor.yml
    # sed -i "s|/your/certificate/path|/etc/ssl/certs|g" harbor.yml
    # sed -i "s|/your/private/key/path|/etc/ssl/private|g" harbor.yml
    sed -i "s|data_volume: /data|data_volume: ${DATA_VOLUME}|g" harbor.yml
}

# 功能：安装 Harbor
install_harbor() {
    echo "正在安装 Harbor..."
    ./install.sh || { echo "安装失败"; exit 1; }
    echo "Harbor 安装成功！请访问 http://${HOSTNAME}:${HTTP_PORT} 来验证安装。"
}

# 主执行流程
download_and_unpack
configure_harbor
install_harbor
