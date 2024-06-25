# 停止所有容器
stop-all:
	@docker ps -q | xargs -r docker stop

# 启动所有已停止的容器
start-all:
	@docker ps -qaf "status=exited" | xargs -r docker start

# 删除所有容器
remove-all:
	@docker ps -qa | xargs -r docker rm

# 删除所有非默认创建的网络
remove-networks:
	@docker network prune -f

# 删除所有网络，包括默认网络
rm-networks-all:
	@docker network ls -q | xargs -r docker network rm || true

# 停止并删除所有容器和网络
clean-all: stop-all remove-all remove-networks

.PHONY: stop-all start-all remove-all remove-networks rm-networks-all clean-all
