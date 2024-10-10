#!/bin/bash

# 启用严格模式：
set -e

# 代理和Docker配置设置
PROXY_HOST="127.0.0.1"
PROXY_PORT="7890"
DOCKER_SERVICE_DIR="/etc/systemd/system/docker.service.d"
PROXY_CONF_FILE="$DOCKER_SERVICE_DIR/http-proxy.conf"

# 设置Docker代理配置的函数
setup_proxy() {
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

    # 重新加载systemd以应用更改，并重启Docker服务
    systemctl daemon-reload
    systemctl restart docker
    echo "Docker代理配置成功设置。"
}

# 移除Docker代理配置的函数
unset_proxy() {
    # 如果配置文件存在，则移除
    if [ -f "$PROXY_CONF_FILE" ]; then
        rm -f "$PROXY_CONF_FILE"
        systemctl daemon-reload
        systemctl restart docker
        echo "Docker代理配置成功移除。"
    else
        echo "未找到Docker代理配置文件。"
    fi
}

# 检查脚本是否以root身份运行，如果不是，则退出
if [[ $EUID -ne 0 ]]; then
    echo "此脚本必须以root身份运行。"
    exit 1
fi

# 主逻辑，用于设置或取消设置代理
case "$1" in
    set)
        setup_proxy
        ;;
    unset)
        unset_proxy
        ;;
    *)
        echo "用法：$0 {set|unset}"
        exit 1
        ;;
esac
