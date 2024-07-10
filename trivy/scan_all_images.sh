#!/bin/bash
# 获取所有镜像名称
images=$(docker images --format '{{.Repository}}:{{.Tag}}')

# 扫描每一个镜像
for img in $images
do
    echo "Scanning $img..."
    trivy image "$img"
    echo "Scan complete for $img"
done
