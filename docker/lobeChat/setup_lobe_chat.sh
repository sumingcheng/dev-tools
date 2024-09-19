#!/bin/bash

# 创建目录用于存放配置文件和数据库文件
mkdir -p lobe-chat-db
cd lobe-chat-db

# 从远程仓库拉取配置文件
curl -fsSL https://raw.githubusercontent.com/lobehub/lobe-chat/HEAD/docker-compose/local/docker-compose.yml > docker-compose.yml
curl -fsSL https://raw.githubusercontent.com/lobehub/lobe-chat/HEAD/docker-compose/local/.env.zh-CN.example > .env

# 返回到原始目录
cd ..

# 启动服务
docker-compose -f lobe-chat-db/docker-compose.yml up -d
