#!/bin/bash

# 函数：显示使用方法
usage() {
    echo "Usage: source $0 [set|unset]"
    echo "请确保使用 'source' 或 '.' 命令执行此脚本以影响当前 shell 环境。"
    return
}

# 检查是否通过 source 执行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "错误：此脚本应该使用 'source' 或 '.' 命令执行以修改环境变量。"
    exit 1
fi

# 检查参数数量
if [ $# -ne 1 ]; then
    usage
    return
fi

# 设置或取消代理
case $1 in
    set)
        export HTTP_PROXY="http://172.22.220.64:7890"
        export HTTPS_PROXY="http://172.22.220.64:7890"
        echo "HTTP/HTTPS 代理已设置为 $HTTP_PROXY"
    ;;
    unset)
        unset HTTP_PROXY
        unset HTTPS_PROXY
        echo "HTTP/HTTPS 代理已取消。"
    ;;
    *)
        usage
    ;;
esac
