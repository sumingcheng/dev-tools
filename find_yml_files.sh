#!/bin/bash

# 查找所有以 .yml 结尾的文件
echo "查找以 .yml 结尾的文件："
find / -type f -name "*.yml" -print 2>/dev/null

# 提示用户是否要将所有 .yml 文件改名为 .yaml
read -p "是否将所有 .yml 文件重命名为 .yaml？(y/n): " answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    # 执行重命名操作
    echo "开始重命名 .yml 文件为 .yaml..."
    find / -type f -name "*.yml" -exec sh -c 'mv "$1" "${1%.yml}.yaml"' _ {} \; 2>/dev/null
    echo "重命名完成！"
else
    echo "操作已取消，未重命名任何文件。"
fi
