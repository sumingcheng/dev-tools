# grafana.ini 常用配置

```ini
# 服务器配置
[server]
http_port = 3000                         # Grafana 服务监听的 HTTP 端口
domain = example.com                     # Grafana 的域名，影响 cookie 和邮件链接
root_url = http://example.com/grafana    # 访问 Grafana 实例的完整 URL

# 数据库配置
[database]
type = mysql                             # 使用的数据库类型，支持 mysql, postgres, sqlite3 等
host = 127.0.0.1:3306                    # 数据库服务器地址
name = grafana                           # 数据库名称
user = user                              # 数据库用户名
password = password                      # 数据库密码

# 安全设置
[security]
admin_user = admin                       # 默认管理员用户名
admin_password = admin123456             # 默认管理员密码
disable_gravatar = true                  # 禁用 Gravatar 头像

# 认证设置
[auth]
disable_login_form = false               # 是否禁用登录表单
oauth_auto_login = false                 # 是否启用 OAuth 自动登录

# 日志设置
[log]
mode = console                           # 日志输出模式，可以是 console, file, syslog 等
level = info                             # 日志级别，例如：info, warn, error

# SMTP/邮件设置
[smtp]
enabled = true                           # 是否启用 SMTP 发送邮件功能
host = smtp.example.com:587              # SMTP 服务器地址
user = myuser                            # SMTP 服务器用户名
password = mypassword                    # SMTP 服务器密码

# 邮件配置示例
[emails]
welcome_email_on_sign_up = true          # 是否在用户注册时发送欢迎邮件
templates_pattern = emails/*.html        # 邮件模板文件路径

```
