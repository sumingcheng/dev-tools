# 设置默认后缀和镜像标签
SUFFIX ?= local
IMAGE_TAG ?= 1.0.0

# 定义应用名称和镜像信息
APP_NAME := frontend
FULL_IMAGE_TAG := $(IMAGE_TAG)-$(SUFFIX)
IMAGE_FULL_NAME := $(APP_NAME):$(FULL_IMAGE_TAG)
CONTAINER_NAME := $(APP_NAME)-$(SUFFIX)

# 构建目标
build:
	@if ! docker images -q $(IMAGE_FULL_NAME) | grep -q .; then \
		docker build -t $(IMAGE_FULL_NAME) -f ./docker/Dockerfile.prod .; \
	fi

# 运行目标
run: build
	@docker stop $(CONTAINER_NAME) > /dev/null 2>&1 || true
	@docker rm $(CONTAINER_NAME) > /dev/null 2>&1 || true
	@docker run -d --name $(CONTAINER_NAME) -p 30001:30001 $(IMAGE_FULL_NAME)

# 停止目标
stop:
	@docker stop $(CONTAINER_NAME) || true

# 清理目标
rm-all:
	@docker rm $(CONTAINER_NAME) || true
	@docker rmi $(IMAGE_FULL_NAME) || true

# 伪目标声明
.PHONY: build run stop rm-all