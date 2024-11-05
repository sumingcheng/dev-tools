#!/bin/bash

# 检查 root 用户权限
if [[ $(id -u) -ne 0 ]]; then
    echo "此脚本需要以 root 用户权限运行"
    exit 1
fi

# 提示用户确认卸载
echo "警告: 此操作将卸载 Harbor 并删除相关数据，无法恢复！"
read -p "是否确认卸载 Harbor？ (y/n): " confirmation
if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
    echo "卸载操作已取消。"
    exit 0
fi

# 检查 Harbor 是否在运行
if docker ps -q -f name=harbor; then
    echo "Harbor 正在运行中，准备停止并删除容器..."
    docker-compose down || { echo "停止 Harbor 容器失败，退出。"; exit 1; }
else
    echo "Harbor 未在运行，跳过停止容器步骤。"
fi

# 删除 Docker 容器、网络、卷等（如果存在）
echo "删除 Docker 容器、网络和卷..."
docker-compose down -v --remove-orphans || { echo "删除 Docker 容器和卷失败，退出。"; exit 1; }

# 检查 Harbor 文件目录是否存在并删除
HARBOR_TAR="harbor-offline-installer-*.tgz"
if [[ -f "$HARBOR_TAR" ]]; then
    echo "删除 Harbor 安装包: $HARBOR_TAR"
    rm -f "$HARBOR_TAR" || { echo "删除 Harbor 安装包失败，退出。"; exit 1; }
fi

# 删除 Harbor 解压目录
if [[ -d "harbor" ]]; then
    echo "删除 Harbor 解压目录: harbor"
    rm -rf "harbor" || { echo "删除 Harbor 目录失败，退出。"; exit 1; }
fi

# 删除所有相关的 Docker 镜像（可选）
read -p "是否删除所有 Harbor Docker 镜像? (y/n): " remove_images
if [[ "$remove_images" == "y" || "$remove_images" == "Y" ]]; then
    echo "删除 Harbor Docker 镜像..."
    docker images | grep "goharbor" | awk '{print $3}' | xargs docker rmi -f || { echo "删除 Docker 镜像失败，退出。"; exit 1; }
fi

# 删除 Harbor 配置文件 (如果用户不再需要)
read -p "是否删除 Harbor 配置文件 harbor.yml? (y/n): " remove_config
if [[ "$remove_config" == "y" || "$remove_config" == "Y" ]]; then
    echo "删除 Harbor 配置文件: harbor.yml"
    rm -f "harbor.yml" || { echo "删除 Harbor 配置文件失败，退出。"; exit 1; }
fi

# 清理可能存在的 Docker 网络（如果 Harbor 使用了专用网络）
echo "清理 Docker 网络..."
docker network ls | grep "harbor" | awk '{print $1}' | xargs docker network rm || { echo "清理 Docker 网络失败，退出。"; exit 1; }

# 清理 Docker 卷（如果使用了持久化数据存储）
echo "清理 Docker 卷..."
docker volume ls | grep "harbor" | awk '{print $2}' | xargs docker volume rm || { echo "清理 Docker 卷失败，退出。"; exit 1; }

# 提示用户卸载完成
echo "Harbor 卸载完成。"
echo "如有任何未删除的文件或镜像，请手动清理。"
