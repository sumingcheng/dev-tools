import smtplib

# 设置MailCatcher的SMTP服务器地址和端口
server = smtplib.SMTP('localhost', 1025)

# 发送邮件
server.sendmail(
    "from@example.com",
    "to@example.com",
    "Subject: 测试邮件\n这是通过MailCatcher发送的测试邮件内容。"
)

# 关闭SMTP服务器连接
server.quit()
