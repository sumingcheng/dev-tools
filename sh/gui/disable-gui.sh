#!/bin/bash

# 检查gdm服务是否活跃，并停止它
if systemctl is-active --quiet gdm3; then
    echo "正在停止 gdm3..."
    sudo systemctl stop gdm3
    echo "gdm3 已被停止。系统下次启动时将自动恢复。"
else
    echo "gdm3 未运行或未安装。"
fi
