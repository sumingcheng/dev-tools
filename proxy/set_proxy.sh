#!/bin/bash

# 检查传入的参数，根据参数设置或取消代理
if [ "$1" == "set" ]; then
    # 设置 HTTP 和 HTTPS 代理
    export HTTP_PROXY="http://127.0.0.1:7890"
    export HTTPS_PROXY="http://127.0.0.1:7890"
    
    echo "HTTP/HTTPS 代理已设置。"
    
    elif [ "$1" == "unset" ]; then
    # 取消 HTTP 和 HTTPS 代理
    unset HTTP_PROXY
    unset HTTPS_PROXY
    
    echo "HTTP/HTTPS 代理已取消。"
else
    echo "请使用 'set' 或 'unset' 参数。"
fi
