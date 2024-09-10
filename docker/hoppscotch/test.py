import os
import smtplib
from email.mime.text import MIMEText
from email.header import Header
import logging
from smtplib import SMTPException

# 配置日志
def configure_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

configure_logging()

# 从环境变量中获取SMTP服务器信息
SMTP_HOST = os.getenv('SMTP_HOST', '172.22.220.64')
SMTP_PORT = int(os.getenv('SMTP_PORT', 1025))

# 创建一个MIMEText邮件对象，设置文本内容和字符集为utf-8
message = MIMEText('这是通过MailCatcher发送的测试邮件内容。', 'plain', 'utf-8')
message['From'] = Header('from@example.com', 'utf-8')
message['To'] = Header('to@example.com', 'utf-8')
message['Subject'] = Header('测试邮件', 'utf-8')

# 尝试发送邮件并管理SMTP连接
try:
    with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as server:
        server.sendmail(
            'from@example.com',
            ['to@example.com'],
            message.as_string()  # 将MIMEText对象转换成字符串
        )
    logging.info('邮件发送成功')
except SMTPException as e:
    logging.error(f'SMTP错误: {e}')
except Exception as e:
    logging.error(f'其他错误: {e}')
finally:
    logging.info('SMTP连接已关闭')
