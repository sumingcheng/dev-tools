#!/bin/bash

set -e # 遇到错误时终止执行

# 安装 conntrack 工具
echo "Installing conntrack..."
sudo apt install -y conntrack

# 下载并安装 kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# 测试 kubectl 是否安装成功
if kubectl version --client; then
    echo "kubectl installed successfully!"
else
    echo "Failed to install kubectl"
    exit 1
fi

# 下载并安装 Minikube
echo "Installing Minikube..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# 启动 Minikube
echo "Starting Minikube..."
minikube start

# 显示安装状态
minikube status
