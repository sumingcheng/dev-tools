# 第一阶段：构建阶段
# 使用官方Go 1.22镜像作为基础镜像
FROM golang:1.22 as builder

# 设置工作目录
WORKDIR /app

# 首先复制go.mod和go.sum文件
# 这利用了Docker的缓存机制，只有当这些文件变更时才重新下载依赖
COPY go.mod go.sum ./

# 下载依赖项
RUN go mod download

# 复制项目中的所有文件到工作目录
COPY . .

# 构建应用程序，启用CGO禁用以保证静态链接
RUN CGO_ENABLED=0 GOOS=linux go build -o /goapp

# 第二阶段：运行阶段
# 使用官方的Alpine镜像为基础，因为它足够小，适合用来运行应用
FROM alpine:latest

# 在新的镜像中创建一个非root用户来运行我们的应用
RUN adduser -D myuser
USER myuser

# 从构建阶段拷贝编译好的应用
COPY --from=builder /goapp /usr/local/bin/goapp

# 设置运行时的工作目录
WORKDIR /home/myuser

# 指定容器启动时运行的命令
CMD ["goapp"]
