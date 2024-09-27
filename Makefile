# 通用变量定义
DC = docker-compose -f
DOCKER_DIR = docker

# 定义服务列表
SERVICES = alist apisix api-testing consul deep-lx elasticsearch filebrowser frp \
           gitlab-runner goproxy halo hoppscotch jellyfin kafka kkfileview lobe-chat-db \
           mailCatcher maxkb minio mongo mysql nacos neo4j nginx portainer postgres \
           prometheus rancher redis rocketMQ sentry sftpGo syncthing trivy vault \
           xinference zentao

# 执行目标：启动和停止服务
.PHONY: $(SERVICES) stop-% clean

# 启动服务的规则
$(SERVICES):
	$(DC) $(DOCKER_DIR)/$@/docker-compose.yml up -d

# 停止服务的规则
stop-%:
	$(DC) $(DOCKER_DIR)/$*/docker-compose.yml down

# 清理目标
clean:
	@echo "Cleaning up..."
	# 这里可以添加清理生成的文件等命令

# 帮助命令
help:
	@echo "可用的命令："
	@echo "  make [服务名]         - 启动指定的服务。例如：make nginx"
	@echo "  make stop-[服务名]    - 停止指定的服务。例如：make stop-nginx"
	@echo "  make clean           - 执行一般清理操作。"
	@echo "可管理的服务：$(SERVICES)"