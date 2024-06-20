import boto3
from botocore.client import Config

# 配置客户端
s3 = boto3.client('s3',
                  endpoint_url='http://172.22.220.64:9000',
                  aws_access_key_id='v2aa8qoQDeX1H6fEWw2C',
                  aws_secret_access_key='Y97SQGXKJTTznM2kFyEfEEad1xphzjqaqQP7Ipbi',
                  config=Config(signature_version='s3v4'),
                  region_name='us-east-1')

# 上传文件
s3.upload_file('file.txt', 'test', 'file.txt')
