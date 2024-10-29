docker_image_name ?= conda-demo
docker_image_tag ?= v1.0.0

dockerfile_path = deploy/Dockerfile

build:
	docker build -f $(dockerfile_path) -t $(docker_image_name):$(docker_image_tag) .

build-ufw:
	docker build --build-arg USE_CHINA_MIRROR=true -f $(dockerfile_path) -t $(docker_image_name):$(docker_image_tag) .

build-nocache:
	docker build --no-cache -f $(dockerfile_path) -t $(docker_image_name):$(docker_image_tag) .

run:
	cd deploy && docker-compose up -d

reset:
	-@git pull
	-@cd deploy && docker-compose down
	-@docker rmi ${docker_image_name}:${docker_image_tag} || true
	-@$(MAKE) build
	-@cd deploy && docker-compose up -d

.PHONY: build build-ufw build-nocache run reset