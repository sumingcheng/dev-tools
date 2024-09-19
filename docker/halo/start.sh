#!/bin/bash

# 获取当前脚本所在目录
current_dir="$(pwd)"

# 设置必要的目录路径
data_dir="$current_dir/data"
config_dir="$current_dir/config"

# 检查并创建数据和配置目录
echo "检查并创建数据目录..."
mkdir -p $data_dir
mkdir -p $config_dir

# 设置目录权限
echo "设置目录权限..."
chown 1100:1100 $data_dir
chown 1100:1100 $config_dir

# 输出目录状态
echo "输出目录权限和所有权状态..."
ls -lnd $data_dir
ls -lnd $config_dir

# 运行 Docker Compose
echo "启动 Docker Compose..."
docker-compose up -d
