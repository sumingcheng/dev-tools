DC = docker-compose -f

SERVICES = $(shell find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)

.PHONY: $(SERVICES) stop clean help

$(SERVICES):
	$(DC) $@/docker-compose.yaml up -d

stop:
	@read -p "输入要停止的服务名: " SERVICE; \
	$(DC) $$SERVICE/docker-compose.yaml down

help:
	@echo "可用命令："
	@echo "  make [服务名]         - 启动指定的服务。例如：make nginx 启动 nginx 服务"
	@echo "  make stop            - 停止指定的服务，输入服务名后按回车确认"
	@echo ""
	@echo "可管理的服务列表："
	@echo "$(SERVICES)"
	@echo ""
	@echo "示例："
	@echo "  1. 启动所有服务：make"
	@echo "  2. 停止某个服务：make stop"
	@echo ""
	@echo "注意：服务目录下需包含 docker-compose.yaml 文件"
