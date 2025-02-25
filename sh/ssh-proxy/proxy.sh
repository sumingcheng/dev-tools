#!/bin/bash

# 检查是否通过 source 执行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "错误：此脚本需要使用 source 命令执行"
    echo "正确用法："
    echo "设置代理：source proxy.sh set"
    echo "取消代理：source proxy.sh unset"
    echo "----------------------------------------"
    exit 1
fi

# 显示使用说明
echo "代理设置工具"
echo "设置代理：source proxy.sh set"
echo "取消代理：source proxy.sh unset"
echo "----------------------------------------"

# 函数：显示使用方法
usage() {
    echo "Usage: source $0 [set|unset]"
    echo "请确保使用 'source' 或 '.' 命令执行此脚本以影响当前 shell 环境。"
    echo "代理设置工具"
    echo "设置代理：source proxy.sh set"
    echo "取消代理：source proxy.sh unset"
    echo "----------------------------------------"
    return
}

# 检查参数数量
if [ $# -ne 1 ]; then
    usage
    return
fi

# 设置或取消代理
case $1 in
    set)
        read -p "请输入代理地址（格式如 192.168.1.3:7890）: " proxy_input
        if [ -z "$proxy_input" ]; then
            echo "错误：代理地址不能为空"
            return 1
        fi
        proxy_address="http://$proxy_input"
        export HTTP_PROXY="$proxy_address"
        export HTTPS_PROXY="$proxy_address"
        export all_proxy="$proxy_address"
        echo "HTTP/HTTPS 代理已设置为 $proxy_address"
    ;;
    unset)
        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset all_proxy
        echo "HTTP/HTTPS 代理已取消。"
    ;;
    *)
        usage
    ;;
esac