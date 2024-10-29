#!/bin/bash

# 定义输出证书和密钥的文件名
KEY_FILE="root.key"
CRT_FILE="root.crt"
CSR_FILE="root.csr"

# 生成私钥
openssl genrsa -out $KEY_FILE 2048

# 创建证书签名请求 (CSR)
openssl req -new -key $KEY_FILE -out $CSR_FILE -subj "/C=CN/ST=Beijing/L=Beijing/O=Example Corp/OU=IT Department/CN=example.com"

# 自签名证书
openssl x509 -req -days 365 -in $CSR_FILE -signkey $KEY_FILE -out $CRT_FILE

echo "证书生成完毕："
echo "私钥文件：$KEY_FILE"
echo "证书文件：$CRT_FILE"
