#!/bin/bash
# 安装 Trivy
echo "正在安装 Trivy..."
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin


# 检查 Trivy 是否安装成功
if ! command -v trivy &> /dev/null
then
    echo "Trivy 安装失败，退出脚本。"
    exit 1
fi
echo "Trivy 安装成功。"