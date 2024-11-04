#!/bin/bash

# 检查 root 用户权限
if [[ $(id -u) -ne 0 ]]; then
    echo "此脚本需要以 root 用户权限运行"
    exit 1
fi

# Harbor 安装目录
HARBOR_DIR="/path/to/harbor"  # 请替换为实际的 Harbor 安装路径

# 停止并删除所有 Harbor 容器
echo "正在停止 Harbor 容器..."
docker-compose -f "$HARBOR_DIR/docker-compose.yml" down

# 删除 Harbor 所有镜像
echo "正在删除 Harbor 镜像..."
docker rmi $(docker images | grep goharbor)

# 删除网络
echo "正在删除 Harbor 网络..."
docker network rm harbor_harbor

# 删除 Harbor 安装目录
echo "正在删除 Harbor 安装目录..."
rm -rf "$HARBOR_DIR"

echo "Harbor 已成功卸载。"
