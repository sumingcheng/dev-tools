FROM node:18.17-alpine AS builder

# 接受外部传入的 USE_CHINA_MIRROR 参数
ARG USE_CHINA_MIRROR=false

# 根据 USE_CHINA_MIRROR 参数配置 npm 和 pnpm 的镜像源
RUN if [ "$USE_CHINA_MIRROR" = "true" ]; then \
        npm config set registry https://registry.npmmirror.com/ && \
        npm install -g pnpm && \
        pnpm config set registry https://registry.npmmirror.com/; \
    else \
        npm install -g pnpm; \
    fi && \
    apk add --no-cache libc6-compat

# 设置工作目录
WORKDIR /app

# 环境变量
ENV NEXT_TELEMETRY_DISABLED=1 \
    VITE_PUBLIC_SERVER_URL=""

# 复制项目文件
COPY . .

# 安装依赖并构建
RUN pnpm install && \
    pnpm build

FROM node:18.17-alpine AS runner

WORKDIR /app

# 环境变量
ENV NODE_ENV=production \
    NEXT_TELEMETRY_DISABLED=1 \
    PORT=3001

# 安装运行时依赖
RUN apk --no-cache add curl ca-certificates && \
    update-ca-certificates

# 复制构建产物
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/service ./service
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/pnpm-lock.yaml ./pnpm-lock.yaml

# 安装生产依赖
RUN npm install -g pnpm && \
    pnpm install --prod && \
    npm remove -g pnpm

# 设置容器监听端口
EXPOSE 3001

# 启动命令
CMD ["node", "server.js"]
