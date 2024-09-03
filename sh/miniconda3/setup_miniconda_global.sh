#!/bin/bash

# 检查当前用户是否有管理员权限
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要管理员权限运行。请使用sudo或作为root用户运行。"
    exit 1
fi

# 检查 Miniconda 安装路径
if [ ! -d "/opt/miniconda3" ]; then
    echo "未检测到 /opt/miniconda3 目录。请确保Miniconda已安装在此路径。"
    exit 1
fi

# 创建全局环境初始化脚本
echo "正在创建全局环境初始化脚本..."
echo -e "#!/bin/sh\n# Initialize Miniconda environment\nsource /opt/miniconda3/etc/profile.d/conda.sh" > /etc/profile.d/miniconda.sh
chmod +x /etc/profile.d/miniconda.sh
echo "全局环境初始化脚本创建完成。"

# 确认脚本是否创建成功
if [ -f "/etc/profile.d/miniconda.sh" ]; then
    echo "Miniconda 环境初始化脚本已成功创建于 /etc/profile.d/miniconda.sh"
else
    echo "创建脚本失败，请手动检查 /etc/profile.d 目录权限。"
    exit 1
fi

echo "Miniconda 配置完成。请注销并重新登录以应用更改，或在每个终端会话中手动运行 'source /etc/profile.d/miniconda.sh'"
