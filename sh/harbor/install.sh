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

# 创建 Harbor 安装目录
mkdir -p ~/harbor && cd ~/harbor

# 下载最新版本的 Harbor
curl -LO $HARBOR_URL

# 解压安装包
tar xvf $HARBOR_TAR
cd harbor

# 复制配置文件
cp harbor.yml.tmpl harbor.yml

# 自动配置示例 (可根据需要调整)
# 修改主机名
sed -i 's/hostname: reg.mydomain.com/hostname: localhost/g' harbor.yml

# 安装 Harbor
./install.sh

# 启动 Harbor
docker-compose up -d

# 提示用户
echo "Harbor 已下载并解压。"
echo "Harbor 正在运行中。"
echo "默认管理员用户名: admin"
echo "默认管理员密码: Harbor12345"
