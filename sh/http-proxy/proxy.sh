#!/bin/bash

# 启用严格模式：
set -e

# Docker配置设置
DOCKER_SERVICE_DIR="/etc/systemd/system/docker.service.d"
PROXY_CONF_FILE="$DOCKER_SERVICE_DIR/http-proxy.conf"

# 设置Docker代理配置的函数
setup_proxy() {
    local proxy_address="$1"
    # 从代理地址中分离主机和端口
    PROXY_HOST=$(echo $proxy_address | cut -d: -f1)
    PROXY_PORT=$(echo $proxy_address | cut -d: -f2)

    # 确保Docker服务目录存在
    if [ ! -d "$DOCKER_SERVICE_DIR" ]; then
        mkdir -p "$DOCKER_SERVICE_DIR"
    fi

    # 如果存在，移除现有的代理配置文件
    if [ -f "$PROXY_CONF_FILE" ]; then
        rm -f "$PROXY_CONF_FILE"
    fi

    # 创建新的代理配置文件
    cat > "$PROXY_CONF_FILE" <<EOF
[Service]
Environment="HTTP_PROXY=http://$PROXY_HOST:$PROXY_PORT"
Environment="HTTPS_PROXY=http://$PROXY_HOST:$PROXY_PORT"
Environment="NO_PROXY=localhost,127.0.0.1"
EOF

    echo "Docker代理配置已设置为 http://$PROXY_HOST:$PROXY_PORT"
    restart_docker
}

# 移除Docker代理配置的函数
unset_proxy() {
    # 如果配置文件存在，则移除
    if [ -f "$PROXY_CONF_FILE" ]; then
        rm -f "$PROXY_CONF_FILE"
        echo "Docker代理配置已移除"
        restart_docker
    else
        echo "未找到Docker代理配置文件"
    fi
}

# 重启Docker服务的函数
restart_docker() {
    echo "正在重启Docker服务..."
    systemctl daemon-reload
    systemctl restart docker
    echo "Docker服务已重启完成"
}

# 检查脚本是否以root身份运行
if [[ $EUID -ne 0 ]]; then
    echo "此脚本必须以root身份运行"
    exit 1
fi

# 交互式操作
echo "请输入代理地址 (格式为 IP:端口，例如 127.0.0.1:7890)："
read proxy_address

# 验证输入格式
if [[ ! $proxy_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+$ ]]; then
    echo "错误：代理地址格式不正确。请使用 IP:端口 格式"
    exit 1
fi

echo "请选择操作："
echo "1. 设置Docker代理"
echo "2. 移除Docker代理"
read -p "请输入选项 (1 或 2): " choice

case $choice in
    1)
        setup_proxy "$proxy_address"
        ;;
    2)
        unset_proxy
        ;;
    *)
        echo "无效的选项"
        exit 1
        ;;
esac
