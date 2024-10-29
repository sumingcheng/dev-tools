FROM node:18.17-alpine AS builder

WORKDIR /react

# 定义构建参数
ARG USE_CHINA_MIRROR=false

# 设置npm源并安装pnpm
RUN if [ "$USE_CHINA_MIRROR" = "true" ]; then \
        npm config set registry https://registry.npmmirror.com; \
    fi && \
    npm install -g pnpm

# 拷贝项目文件
COPY package.json pnpm-lock.yaml src ./src/

# 安装依赖并启动项目
RUN pnpm install && \
    pnpm run start


FROM nginx:stable-alpine AS production

WORKDIR /react
COPY --from=builder /react/dist ./dist
COPY deploy/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
