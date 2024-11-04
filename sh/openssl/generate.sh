#!/bin/bash

# 配置变量
KEY_FILE="root.key"         # 私钥文件名
CRT_FILE="root.crt"         # 证书文件名
CSR_FILE="root.csr"         # CSR 文件名
DAYS_VALID=365               # 证书有效天数
COUNTRY="CN"                 # 国家
STATE="Beijing"              # 省份
LOCALITY="Beijing"           # 城市
ORG="Example Corp"           # 组织
ORG_UNIT="IT Department"     # 组织单位
COMMON_NAME="harbor.com"     # 公共名称

# 生成私钥
if openssl genrsa -out "$KEY_FILE" 2048; then
    echo "私钥生成成功：$KEY_FILE"
else
    echo "私钥生成失败" >&2
    exit 1
fi

# 创建证书签名请求 (CSR)
if openssl req -new -key "$KEY_FILE" -out "$CSR_FILE" -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORG/OU=$ORG_UNIT/CN=$COMMON_NAME"; then
    echo "证书签名请求生成成功：$CSR_FILE"
else
    echo "CSR 生成失败" >&2
    exit 1
fi

# 自签名证书
if openssl x509 -req -days "$DAYS_VALID" -in "$CSR_FILE" -signkey "$KEY_FILE" -out "$CRT_FILE"; then
    echo "自签名证书生成成功：$CRT_FILE"
else
    echo "证书生成失败" >&2
    exit 1
fi

echo "证书生成完毕："
echo "私钥文件：$KEY_FILE"
echo "证书文件：$CRT_FILE"
