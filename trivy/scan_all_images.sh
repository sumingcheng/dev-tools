#!/bin/bash

# 安装 Trivy
echo "正在安装 Trivy..."
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh

# 检查 Trivy 是否安装成功
if ! command -v trivy &> /dev/null
then
    echo "Trivy 安装失败，退出脚本。"
    exit 1
fi
echo "Trivy 安装成功。"

# 获取所有本地 Docker 镜像
echo "获取本地所有 Docker 镜像..."
mapfile -t images < <(docker images --format '{{.Repository}}:{{.Tag}}')

# 检查是否有镜像可供扫描
if [ ${#images[@]} -eq 0 ]; then
    echo "没有找到任何 Docker 镜像，退出脚本。"
    exit 1
fi

# 扫描每个镜像
echo "开始扫描所有镜像..."
for image in "${images[@]}"
do
    echo "正在扫描镜像：$image"
    trivy image "$image"
    echo "镜像 $image 扫描完成。"
done

echo "所有镜像扫描完成。"
