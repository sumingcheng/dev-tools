#!/bin/bash

# 检查命令行参数
if [ "$1" == "generate" ]; then
    # 生成 requirements.txt
    echo "生成 requirements.txt 文件中..."
    pip freeze > requirements.txt
    echo "requirements.txt 已生成。"
    
    elif [ "$1" == "install" ]; then
    # 安装依赖
    echo "从 requirements.txt 安装依赖..."
    pip install -r requirements.txt
    echo "依赖安装完成。"
    
else
    echo "无效的参数。请使用 'generate' 生成 requirements.txt 或 'install' 安装依赖。"
fi
