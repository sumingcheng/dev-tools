stop-all:
	@docker ps -q | xargs -r docker stop

start-all:
	@docker ps -qaf "status=exited" | xargs -r docker start

remove-all:
	@docker ps -qa | xargs -r docker rm

# 删除所有非默认创建的网络
remove-networks:
	@docker network prune -f

# 删除所有网络，包括默认网络
rm-networks-all:
	@docker network ls -q | xargs -r docker network rm || true

clean-all: stop-all remove-all remove-networks

.PHONY: stop-all start-all remove-all remove-networks rm-networks-all clean-all
