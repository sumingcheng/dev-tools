docker_image_name ?= vue-demo
docker_image_tag ?= v1.0.0

dockerfile_path = deploy/Dockerfile

build:
	docker build --build-arg USE_CHINA_MIRROR=true -f $(dockerfile_path) -t $(docker_image_name):$(docker_image_tag) .

build-nocache:
	docker build --build-arg USE_CHINA_MIRROR=true --no-cache -f $(dockerfile_path) -t $(docker_image_name):$(docker_image_tag) .

run:
	cd deploy && docker-compose -f docker-compose-dev.yaml up -d

down:
	cd deploy && docker-compose -f docker-compose-dev.yaml down

reset:
	-@git pull
	-@cd deploy && docker-compose -f docker-compose-dev.yaml down
	-@docker rmi ${docker_image_name}:${docker_image_tag} || true
	-@$(MAKE) build
	-@cd deploy && docker-compose -f docker-compose-dev.yaml up -d

.PHONY: build build-nocache run down reset