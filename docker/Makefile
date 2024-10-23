# 通用变量定义
DC = docker-compose -f

# 定义服务列表
SERVICES = alist apisix api-testing consul deep-lx elasticsearch filebrowser frp \
           gitlab-runner goproxy halo hoppscotch jellyfin kafka kkfileview lobe-chat-db \
           mailCatcher maxkb minio mongo mysql nacos neo4j nginx portainer postgres \
           prometheus rancher redis rocketMQ sentry sftpGo syncthing trivy vault \
           xinference zentao milvus attu uptime-kuma omniparse

# 执行目标：启动和停止服务
.PHONY: $(SERVICES) stop clean help

# 启动服务的规则
$(SERVICES):
	$(DC) $@/docker-compose.yaml up -d

# 停止服务的规则
stop:
	@read -p "输入要停止的服务名: " SERVICE; \
	$(DC) $$SERVICE/docker-compose.yaml down

# 帮助命令
help:
	@echo "可用的命令："
	@echo "  make [服务名]         - 启动指定的服务。例如：make nginx"
	@echo "  make stop            - 输入服务名来停止指定的服务。"
	@echo "可管理的服务：$(SERVICES)"
