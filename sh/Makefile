SHELL := /bin/bash
.PHONY: anaconda harbor http-proxy miniconda3 minikube pyenv setup sources ssh-proxy

anaconda:
	@echo "正在进入 anaconda 目录..."
	@cd anaconda && bash ./install.sh

harbor:
	@echo "正在进入 harbor 目录..."
	@cd harbor && bash ./install.sh

miniconda3:
	@echo "正在进入 miniconda3 目录..."
	@cd miniconda3 && bash ./install.sh

minikube:
	@echo "正在进入 minikube 目录..."
	@cd minikube && bash ./install.sh

pyenv:
	@echo "正在进入 pyenv 目录..."
	@cd pyenv && bash ./install_pyenv.sh

setup:
	@echo "正在进入 setup 目录..."
	@cd setup && bash install_apt.sh

sources:
	@echo "正在进入 sources 目录..."
	@cd sources && bash select-sources.sh

http:
	@echo "正在进入 http-proxy 目录..."
	@cd http-proxy && bash ./proxy.sh

ssh:
	@echo "正在进入 ssh-proxy 目录..."
	@cd ssh-proxy && source ./proxy.sh set
