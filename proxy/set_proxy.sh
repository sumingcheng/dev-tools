#!/bin/bash

# 检查传入的参数，根据参数设置或取消代理
if [ "$1" == "set" ]; then
    # 设置 HTTP 和 HTTPS 代理
    export HTTP_PROXY="http://127.0.0.1:7890"
    export HTTPS_PROXY="http://127.0.0.1:7890"
    
    echo "HTTP/HTTPS 代理正在设置..."
    
    # 检查代理是否设置成功
    if [ "$HTTP_PROXY" == "http://127.0.0.1:7890" ] && [ "$HTTPS_PROXY" == "http://127.0.0.1:7890" ]; then
        echo "HTTP/HTTPS 代理已成功设置。"
    else
        echo "代理设置失败，请检查脚本。"
    fi
    
    elif [ "$1" == "unset" ]; then
    # 取消 HTTP 和 HTTPS 代理
    unset HTTP_PROXY
    unset HTTPS_PROXY
    
    echo "HTTP/HTTPS 代理正在取消..."
    
    # 检查代理是否取消成功
    if [ -z "$HTTP_PROXY" ] && [ -z "$HTTPS_PROXY" ]; then
        echo "HTTP/HTTPS 代理已成功取消。"
    else
        echo "代理取消失败，请检查脚本。"
    fi
    
else
    echo "请使用 'set' 或 'unset' 参数。"
fi
