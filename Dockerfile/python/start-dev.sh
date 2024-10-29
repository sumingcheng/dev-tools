#!/bin/bash

# 启动 uvicorn 服务器
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload