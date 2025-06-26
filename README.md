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

## 简介
这是一个强大的 `make` + `docker-compose` 工具集，将数十种开发必备服务（从数据库到大模型）封装为标准、可一键启动的模板。告别繁琐配置，让您在几分钟内拉起一套完整的开发环境，专注于真正重要的编码和创新。

大部分工具和脚本已在 Ubuntu 22.04 x86_64 环境下测试,可正常运行。其他环境请测试后提交 PR

## 项目内容

### 🐳 Docker 服务编排 ([docker/](./docker/))

提供了一系列常用开发工具和服务的 `docker-compose` 配置，覆盖了从数据库到 AI 应用的广泛场景。

- **AI / 大语言模型 (LLM)**: `anything-llm`, `dify`, `maxkb`, `ragflow`, `lobeChat`, `gpt-sovits`, `xinference`, `open-webui`, `omniparse`, `deep-lx`, `searxng-api`
- **数据库与缓存**: `mysql`, `postgres`, `mongo`, `redis`, `milvus`, `neo4j`, `elasticsearch`, `consul`
- **CI/CD 与 DevOps**: `gitlab`, `gitlab-runner`, `jenkins`, `rancher`, `sentry`, `trivy`, `portainer`
- **对象存储与文件服务**: `minio`, `cloudreve`, `alist`, `filebrowser`, `sftpGo`
- **API 网关与测试**: `apisix`, `one-api`, `hoppscotch`, `api-testing`, `goproxy`
- **监控与告警**: `prometheus`, `uptime-kuma`
- **消息队列与服务发现**: `kafka`, `rocketMQ`, `nacos`
- **内容管理与协作**: `wordpress`, `halo`, `onlyoffice`, `zentao`, `waline`, `jellyfin`
- **实用工具**: `vault` (密钥管理), `syncthing` (文件同步), `kkfileview` (文件预览), `mailCatcher` (邮件捕获), `frpc`/`frps` (内网穿透)
- **向量数据库管理**: `attu` (Milvus 管理界面)

### 🚀 向量模型服务 ([vector-models/](./vector-models/))

快速部署常用的向量嵌入 (Embedding) 和重排 (Reranker) 模型服务。

- **Embedding 模型**: `bge-large-api`, `m3e-large-api`
- **Reranker 模型**: `bge-reranker-base`, `bge-reranker-large`, `bge-reranker-v2-m3`

### 🐍 Python 脚本 ([py/](./py/))

一系列实用的 Python 自动化脚本。

- `doc2md`: Word 文档转 Markdown
- `get-gpu`: 检测 GPU 信息
- `llm-test`: 大语言模型服务测试
- `logger`: 日志模块配置
- `uploadFiles`: 一个简单的文件上传应用

### 🐚 Shell 脚本 ([sh/](./sh/))

用于环境配置、软件安装和管理的 Shell 脚本。

- **环境管理**: `anaconda`, `miniconda3`, `pyenv`
- **系统工具**: `openssl` (证书生成), `setup` (apt 工具安装), `sources` (软件源切换)
- **开发工具**: `minikube` (本地 K8s), `remote-dev` (远程开发权限)
- **代理工具**: `http-proxy`, `ssh-proxy`
- **其他**: `gui`, `randomGitHistory`

### 📦 DevOps 与 K8s ([devops/](./devops/), [k8s/](./k8s/))

- **DevOps**: 包含 `container-registry` (Harbor, Distribution) 等 CI/CD 相关服务的部署方案。
- **Kubernetes**: 提供 `mysql`, `nginx`, `redis` 等基础服务的 K8s 配置（正在完善中）。

## 快速开始

克隆项目
```bash 
git clone https//github.com/sumingcheng/dev-tools.git
cd dev-tools
```

选择需要部署的应用,进入对应目录。例如启动 Redis
```bash
cd docker/
make help    # 查看支持的命令
make up      # 启动服务 
```

## 如何贡献

欢迎并鼓励社区成员贡献代码、文档、报告问题或提供新的想法。如果你有好的建议或新功能,请通过 Issues 或 Pull Requests 与我们分享

## 许可证

本项目 MIT 许可证,详情请见 [LICENSE](./LICENSE) 文件。

