#!/bin/bash

# 检查是否提供了足够的参数
if [ "$#" -ne 2 ]; then
    echo "用法：$0 用户名 目录路径"
    exit 1
fi

USER="$1"
DIRECTORY="$2"

# 更改所有权
sudo chown -R $USER:$USER "$DIRECTORY"

# 更改权限
sudo chmod -R 777 "$DIRECTORY"

# 将目录添加到 Git 安全目录列表
git config --global --add safe.directory "$DIRECTORY"

# 进入指定的目录
cd "$DIRECTORY" || exit

#  Git 忽略文件权限的变化
git config core.fileMode false

echo "已为用户 $USER 更新 $DIRECTORY 的权限和 Git 设置。"

# 使用方法 ./update_permissions.sh smc /home/smc/filePath1
