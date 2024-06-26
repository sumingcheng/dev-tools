#!/bin/bash

set -e

# 打印脚本功能描述
cat << EOF
该脚本将卸载 Minikube、kubectl 及可选的 conntrack。
将删除所有相关数据和配置。
请谨慎使用，数据删除后无法恢复。
EOF

# 请求用户确认
read -p "确定继续吗？(y/N): " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || exit 1

# 停止 Minikube
echo "正在停止 Minikube..."
minikube stop || { echo "停止 Minikube 失败。"; exit 1; }

# 删除 Minikube 及其所有相关文件
echo "正在删除 Minikube VM 及所有相关文件..."
minikube delete --all --purge || { echo "删除 Minikube 数据失败。"; exit 1; }

# 移除 Minikube 可执行文件
echo "正在移除 Minikube 可执行文件..."
sudo rm -f /usr/local/bin/minikube || { echo "移除 Minikube 可执行文件失败。"; exit 1; }

# 移除 kubectl 可执行文件
echo "正在移除 kubectl 可执行文件..."
sudo rm -f /usr/local/bin/kubectl || { echo "移除 kubectl 可执行文件失败。"; exit 1; }

# 清理遗留文件
echo "正在清理遗留文件..."
sudo rm -rf ~/.minikube || { echo "移除 .minikube 目录失败。"; exit 1; }
sudo rm -rf ~/.kube || { echo "移除 .kube 目录失败。"; exit 1; }

# 可选：卸载 conntrack
read -p "也要移除 conntrack 吗？(y/N): " remove_conntrack
if [[ "$remove_conntrack" =~ ^[Yy]$ ]]; then
    if sudo apt-get remove --auto-remove conntrack; then
        echo "成功移除 conntrack。"
    else
        echo "移除 conntrack 失败。"
        exit 1
    fi
fi

echo "Minikube 及相关工具已成功卸载。"
