import smtplib
from email.mime.text import MIMEText
from email.header import Header
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Get current time
current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

# Create email message
html_content = f"""
<html>
<body>
  <h1>这是通过MailCatcher发送的测试邮件内容。当前时间：{current_time}</h1>
</body>
</html>
"""
message = MIMEText(html_content, 'html', 'utf-8')
message['From'] = Header('from@example.com', 'utf-8')
message['To'] = Header('to@example.com', 'utf-8')
message['Subject'] = Header('测试邮件', 'utf-8')

# Send email
try:
    server = smtplib.SMTP('172.22.220.64', 1025)
    server.sendmail('from@example.com', ['to@example.com'], message.as_string())
    logging.info('邮件发送成功')
finally:
    server.quit()
    logging.info('SMTP连接已关闭')
