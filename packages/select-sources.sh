#!/bin/bash

echo "请选择您想要设置的软件源："
echo "1. 阿里云  2. 网易163  3. 清华大学  4. 中科大  5. 使用当前目录下的官方源文件 sources.list"
read -p "输入对应数字 (1-5): " choice
echo

# 定义一个关联数组来存储不同的源
declare -A sources
sources[1]="deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse"

sources[2]="deb http://mirrors.163.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-backports main restricted universe multiverse"

sources[3]="deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse"

sources[4]="deb http://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse"

# 根据用户选择执行对应操作
if [[ $choice =~ ^[1-4]$ ]]; then
    # 设置新的镜像源
    echo "${sources[$choice]}" | sudo tee /etc/apt/sources.list > /dev/null
    # 更新软件源并升级所有已安装的包
    echo "更新软件源并升级..."
    sudo apt update && sudo apt upgrade -y && echo "操作完成。" || echo "更新或升级过程中出错。"
elif [[ $choice == 5 ]]; then
    if [ -f "./sources.list" ]; then
        sudo cp ./sources.list /etc/apt/sources.list && echo "已替换为当前目录下的 sources.list 文件。"
        sudo apt update && sudo apt upgrade -y && echo "操作完成。" || echo "更新或升级过程中出错。"
    else
        echo "没有在当前目录找到 sources.list 文件。"
    fi
else
    echo "无效输入，操作取消。"
fi
