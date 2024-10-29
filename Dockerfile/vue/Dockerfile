# 使用Alpine版的Node镜像以减小构建尺寸
FROM node:18.17-alpine AS builder

WORKDIR /vue

# 定义构建参数
ARG USE_CHINA_MIRROR=false

# 设置 npm registry
RUN if [ "$USE_CHINA_MIRROR" = "true" ]; then \
        npm config set registry https://registry.npmmirror.com; \
    fi && \
    npm install -g pnpm

COPY package.json pnpm-lock.yaml ./
RUN pnpm install
RUN pnpm build

# 使用轻量级的nginx镜像
FROM nginx:stable-alpine AS production

WORKDIR /vue

COPY --from=builder /vue/dist /vue
COPY --from=builder /vue/deplpy/nginx.conf /etc/nginx/nginx.conf

EXPOSE 9001
