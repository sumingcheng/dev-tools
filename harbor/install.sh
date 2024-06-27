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
HARBOR_VERSION="v2.5.0"
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
    cp harbor.yml.tmpl harbor.yml
    # 将所有配置项设置为 HTTP
    sed -i "s/hostname: reg.mydomain.com/hostname: 127.0.0.1/" harbor.yml
    sed -i "s/http:\s*$/http:\n  port: 80/" harbor.yml
    sed -i "/https:/,/certificate:/d" harbor.yml
    sed -i "/private_key:/d" harbor.yml
    # 删除内部 TLS 启用
    sed -i '/internal_tls:/,+6 d' harbor.yml
    # 确保协议设置为 HTTP
    sed -i "s/external_url: https:\/\/reg.mydomain.com:8433/#external_url: http:\/\/127.0.0.1:80/" harbor.yml
    
    # 设置管理员用户名和密码
    sed -i "s/^# harbor_admin_password:.*/harbor_admin_password: 123456/" harbor.yml
    
    # 调试输出当前 harbor.yml 文件状态
    echo "当前 harbor.yml 配置:"
    cat harbor.yml
}

# 主执行流程
download_and_unpack
configure_harbor

echo "Harbor 已下载并解压。请查看 'harbor' 目录中的 docker-compose.yml 文件，并使用以下命令来启动 Harbor："
echo "cd harbor"
echo "docker-compose up -d"

echo "默认管理员用户名: admin"
echo "默认管理员密码: 123456"
