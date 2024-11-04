#!/bin/bash

# 检查 root 用户权限
if [[ $(id -u) -ne 0 ]]; then
    echo "此脚本需要以 root 用户权限运行"
    exit 1
fi

# 显示代理设置
echo "HTTP Proxy: $HTTP_PROXY"
echo "HTTPS Proxy: $HTTPS_PROXY"

# 设置 Harbor 版本
HARBOR_VERSION="v2.11.1"
HARBOR_TAR="harbor-offline-installer-$HARBOR_VERSION.tgz"
HARBOR_URL="https://github.com/goharbor/harbor/releases/download/$HARBOR_VERSION/$HARBOR_TAR"
HARBOR_DIR=~/harbor

# 创建 Harbor 安装目录
mkdir -p "$HARBOR_DIR"
cd "$HARBOR_DIR" || { echo "无法进入目录 $HARBOR_DIR，退出。"; exit 1; }

# 检查是否已经下载过 Harbor
if [[ ! -f "$HARBOR_TAR" ]]; then
    echo "下载 Harbor 安装包..."
    curl -LO "$HARBOR_URL" || { echo "下载失败，退出。"; exit 1; }
else
    echo "Harbor 安装包已存在，跳过下载。"
fi

# 解压安装包
tar xvf "$HARBOR_TAR" || { echo "解压失败，退出。"; exit 1; }
cd harbor || { echo "无法进入目录 harbor，退出。"; exit 1; }

# 确保 harbor.yml 文件已经存在
if [[ ! -f "harbor.yml" ]]; then
    echo "配置文件 harbor.yml 不存在，请确保已正确配置。"
    exit 1
fi

# 安装 Harbor
./install.sh || { echo "Harbor 安装失败，退出。"; exit 1; }

# 启动 Harbor
docker-compose up -d || { echo "启动 Harbor 失败，退出。"; exit 1; }

# 提示用户
echo "Harbor 已下载并解压。"
echo "Harbor 正在运行中。"
echo "默认管理员用户名: admin"
echo "默认管理员密码: Harbor12345"
