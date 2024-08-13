#!/bin/bash

set -e

PROXY_HOST="127.0.0.1"
PROXY_PORT="7890"
DOCKER_SERVICE_DIR="/etc/systemd/system/docker.service.d"
PROXY_CONF_FILE="$DOCKER_SERVICE_DIR/http-proxy.conf"

setup_proxy() {
    if [ ! -d "$DOCKER_SERVICE_DIR" ]; then
        mkdir -p $DOCKER_SERVICE_DIR
    fi
    
    if [ -f "$PROXY_CONF_FILE" ]; then
        rm -f $PROXY_CONF_FILE
    fi
    
    cat > $PROXY_CONF_FILE <<EOF
[Service]
Environment="HTTP_PROXY=http://$PROXY_HOST:$PROXY_PORT"
Environment="HTTPS_PROXY=http://$PROXY_HOST:$PROXY_PORT"
Environment="NO_PROXY=localhost,127.0.0.1"
EOF
    systemctl daemon-reload
    systemctl restart docker
    echo "Docker proxy set up successfully."
}

unset_proxy() {
    if [ -f "$PROXY_CONF_FILE" ]; then
        rm -f $PROXY_CONF_FILE
        systemctl daemon-reload
        systemctl restart docker
        echo "Docker proxy unset successfully."
    else
        echo "Docker proxy configuration file not found."
    fi
}

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." 
    exit 1
fi

case "$1" in
    set)
        setup_proxy
        ;;
    unset)
        unset_proxy
        ;;
    *)
        echo "Usage: $0 {set|unset}"
        exit 1
esac