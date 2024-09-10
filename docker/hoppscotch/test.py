import smtplib
from email.mime.text import MIMEText
from email.header import Header
import logging

# 设置日志配置
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 创建一个MIMEText邮件对象，设置文本内容和字符集为utf-8
message = MIMEText('这是通过MailCatcher发送的测试邮件内容。', 'plain', 'utf-8')
message['From'] = Header('from@example.com', 'utf-8')
message['To'] = Header('to@example.com', 'utf-8')
message['Subject'] = Header('测试邮件', 'utf-8')

# 连接到SMTP服务器
server = smtplib.SMTP('172.22.220.64', 1025)

try:
    # 发送邮件
    server.sendmail(
        'from@example.com',
        ['to@example.com'],
        message.as_string()  # 将MIMEText对象转换成字符串
    )
    logging.info('邮件发送成功')
except Exception as e:
    logging.error(f'邮件发送失败: {e}')
finally:
    # 关闭SMTP服务器连接
    server.quit()
    logging.info('SMTP连接已关闭')
