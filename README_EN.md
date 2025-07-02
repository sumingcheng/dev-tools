<div align="center">
  <img src="https://github.com/sumingcheng/DevTools/assets/21992204/ea3d950c-823b-4a53-9299-3c0a9234a5d9" width="120" height="120" alt="DevTools logo" >
  <h1>dev-tools</h1>

  <p align="center">
    <a href="./README_EN.md">English</a> |
    <a href="./README.md">简体中文</a>
  </p>

  <p align="center">
    <a href="https://github.com/sumingcheng/dev-tools/stargazers"><img src="https://img.shields.io/github/stars/sumingcheng/dev-tools" alt="Stars Badge"/></a>
    <a href="https://github.com/sumingcheng/dev-tools/network/members"><img src="https://img.shields.io/github/forks/sumingcheng/dev-tools" alt="Forks Badge"/></a>
    <a href="https://github.com/sumingcheng/dev-tools/pulls"><img src="https://img.shields.io/github/issues-pr/sumingcheng/dev-tools" alt="Pull Requests Badge"/></a>
    <a href="https://github.com/sumingcheng/dev-tools/issues"><img src="https://img.shields.io/github/issues/sumingcheng/dev-tools" alt="Issues Badge"/></a>
    <a href="./LICENSE"><img src="https://img.shields.io/github/license/sumingcheng/dev-tools?color=2b9348" alt="License Badge"/></a>
  </p>
</div>

## Introduction

Tired of the tedious work of setting up environments repeatedly for every new project? `dev-tools` is here to solve that.

This is a powerful `make` + `docker-compose` toolkit that bundles dozens of essential development services—from databases to large language models—into standard, one-command-to-start templates. Say goodbye to tedious configurations and get a complete development environment up and running in minutes, so you can focus on what truly matters: coding and innovation.

Most tools and scripts have been tested on Ubuntu 22.04 x86_64. For other environments, please test and submit a PR if needed.

## What's Inside?

### 🐳 Docker Service Orchestration ([docker/](./docker/))

A collection of `docker-compose` configurations for a wide range of popular development tools and services, covering everything from databases to AI applications.

- **AI / Large Language Models (LLM)**: `anything-llm`, `dify`, `maxkb`, `ragflow`, `lobeChat`, `gpt-sovits`, `xinference`, `open-webui`, `omniparse`, `deep-lx`, `searxng-api`
- **Databases & Caching**: `mysql`, `postgres`, `mongo`, `redis`, `milvus`, `neo4j`, `elasticsearch`, `consul`
- **CI/CD & DevOps**: `gitlab`, `gitlab-runner`, `jenkins`, `rancher`, `sentry`, `trivy`, `portainer`
- **Object Storage & File Services**: `minio`, `cloudreve`, `alist`, `filebrowser`, `sftpGo`
- **API Gateway & Testing**: `apisix`, `one-api`, `hoppscotch`, `api-testing`, `goproxy`
- **Monitoring & Alerting**: `prometheus`, `uptime-kuma`
- **Message Queues & Service Discovery**: `kafka`, `rocketMQ`, `nacos`
- **Content Management & Collaboration**: `wordpress`, `halo`, `onlyoffice`, `zentao`, `waline`, `jellyfin`
- **Utilities**: `vault` (secret management), `syncthing` (file sync), `kkfileview` (file preview), `mailCatcher` (email capture), `frpc`/`frps` (NAT traversal)
- **Vector Database Management**: `attu` (Milvus admin)

### 🚀 Vector Model Services ([vector-models/](./vector-models/))

Quickly deploy services for popular vector embedding and reranker models.

- **Embedding Models**: `bge-large-api`, `m3e-large-api`
- **Reranker Models**: `bge-reranker-base`, `bge-reranker-large`, `bge-reranker-v2-m3`

### 🐍 Python Scripts ([py/](./py/))

A collection of useful Python automation scripts.

- `doc2md`: Convert Word documents to Markdown
- `get-gpu`: Detect GPU information
- `llm-test`: Test LLM services
- `logger`: Logger module configuration
- `uploadFiles`: A simple file upload application

### 🐚 Shell Scripts ([sh/](./sh/))

Shell scripts for environment configuration, software installation, and management.

- **Environment Management**: `anaconda`, `miniconda3`, `pyenv`
- **System Tools**: `openssl` (certificate generation), `setup` (apt tool installation), `sources` (source switching)
- **Development Tools**: `minikube` (local K8s), `remote-dev` (remote dev permissions)
- **Proxy Tools**: `http-proxy`, `ssh-proxy`
- **Others**: `gui`, `randomGitHistory`

### 📦 DevOps & K8s ([devops/](./devops/), [k8s/](./k8s/))

- **DevOps**: Includes deployment solutions for CI/CD related services like `container-registry` (Harbor, Distribution).
- **Kubernetes**: Provides K8s configurations for basic services like `mysql`, `nginx`, and `redis` (work in progress).

## Quick Start

Clone the project:

```bash
git clone https://github.com/sumingcheng/dev-tools.git
cd dev-tools
```

Navigate to the directory of the application you want to deploy. For example, to start Redis:

```bash
cd docker/
make help    # View supported commands
make up      # Start the service
```

## How to Contribute

We welcome and encourage community members to contribute code, documentation, report issues, or provide new ideas. If you have good suggestions or feature additions, please share them through Issues or Pull Requests.

## License

This project is under the MIT License, see the [LICENSE](./LICENSE) file for details.
