#!/bin/bash

# 创建目录用于存放配置文件和数据库文件
mkdir -p lobe-chat-db
cd lobe-chat-db

# 检查 docker-compose.yaml 文件是否存在，如果不存在，则下载
if [ ! -f "docker-compose.yml" ]; then
    curl -fsSL https://raw.githubusercontent.com/lobehub/lobe-chat/HEAD/docker-compose/local/docker-compose.yml > docker-compose.yaml
fi

# 检查 .env 文件是否存在，如果不存在，则下载
if [ ! -f ".env" ]; then
    curl -fsSL https://raw.githubusercontent.com/lobehub/lobe-chat/HEAD/docker-compose/local/.env.zh-CN.example > .env
fi

# 返回到原始目录
cd ..

# 启动服务
docker-compose -f lobe-chat-db/docker-compose.yaml up -d
