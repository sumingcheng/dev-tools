# 启用 Git Large File Storage (LFS)
gitlab_rails['lfs_enabled'] = true

# 设置 GitLab 服务器的时区
gitlab_rails['time_zone'] = 'Asia/Shanghai'

# 设置 GitLab 访问的 URL
external_url 'http:/172.22.220.64'

# 设置 GitLab 的 root 密码
gitlab_rails['initial_root_password'] = '12345678'

# # 设置 GitLab Shell 使用的 SSH 端口
gitlab_rails['gitlab_shell_ssh_port'] = 2222

# # 启用 HTTPS，自动将 HTTP 流量重定向至 HTTPS
# nginx['redirect_http_to_https'] = true

# # 配置 SSL 证书和密钥的文件路径
# nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.example.com.crt"
# nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.example.com.key"

# # 设置 PostgreSQL 的内存缓冲区大小
# postgresql['shared_buffers'] = "256MB"

# # 配置备份文件的存储路径和保留时间（秒）
# gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"
# gitlab_rails['backup_keep_time'] = 604800  # 保留备份7天

# # 配置 SMTP 设置以发送电子邮件
# gitlab_rails['smtp_enable'] = true
# gitlab_rails['smtp_address'] = "smtp.example.com"
# gitlab_rails['smtp_port'] = 587
# gitlab_rails['smtp_user_name'] = "user@example.com"
# gitlab_rails['smtp_password'] = "password"
# gitlab_rails['smtp_domain'] = "example.com"
# gitlab_rails['smtp_authentication'] = "login"
# gitlab_rails['smtp_enable_starttls_auto'] = true  # 启用 StartTLS 自动协商

