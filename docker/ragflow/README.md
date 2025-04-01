# README

<details open>
<summary></b>📗 目录</b></summary>

- 🐳 [Docker Compose](#-docker-compose)
- 🐬 [Docker 环境变量](#-docker-环境变量)
- 🐋 [服务配置](#服务配置)

</details>

## 🐳 Docker Compose

- **docker-compose.yml**  
  为 RAGFlow 及其依赖项设置环境。
- **docker-compose-base.yml**  
  为 RAGFlow 的依赖项设置环境:Elasticsearch/[Infinity](https://github.com/infiniflow/infinity)、MySQL、MinIO 和 Redis。

> [!CAUTION]
> 我们不积极维护 **docker-compose-CN-oc9.yml**、**docker-compose-gpu-CN-oc9.yml** 或 **docker-compose-gpu.yml**,因此使用它们需要自担风险。不过,欢迎你提交 pull request 来改进它们中的任何一个。

## 🐬 Docker 环境变量

[.env](./.env) 文件包含 Docker 的重要环境变量。

### Elasticsearch

- `STACK_VERSION`  
  Elasticsearch 的版本。默认为 `8.11.3`。
- `ES_PORT`  
  用于将 Elasticsearch 服务暴露给主机的端口,允许从 Docker 容器外部访问容器内运行的服务。默认为 `1200`。
- `ELASTIC_PASSWORD`  
  Elasticsearch 的密码。

### Kibana

- `KIBANA_PORT`  
  用于将 Kibana 服务暴露给主机的端口,允许从 Docker 容器外部访问容器内运行的服务。默认为 `6601`。
- `KIBANA_USER`  
  Kibana 的用户名。默认为 `rag_flow`。
- `KIBANA_PASSWORD`  
  Kibana 的密码。默认为 `infini_rag_flow`。

### 资源管理

- `MEM_LIMIT`  
  *特定* Docker 容器在运行时可以使用的最大内存量(以字节为单位)。默认为 `8073741824`。

### MySQL

- `MYSQL_PASSWORD`  
  MySQL 的密码。
- `MYSQL_PORT`  
  用于将 MySQL 服务暴露给主机的端口,允许从 Docker 容器外部访问容器内运行的 MySQL 数据库。默认为 `5455`。

### MinIO

- `MINIO_CONSOLE_PORT`  
  用于将 MinIO 控制台界面暴露给主机的端口,允许从 Docker 容器外部访问容器内运行的基于 Web 的控制台。默认为 `9001`。
- `MINIO_PORT`  
  用于将 MinIO API 服务暴露给主机的端口,允许从 Docker 容器外部访问容器内运行的 MinIO 对象存储服务。默认为 `9000`。
- `MINIO_USER`  
  MinIO 的用户名。
- `MINIO_PASSWORD`  
  MinIO 的密码。

### Redis

- `REDIS_PORT`  
  用于将 Redis 服务暴露给主机的端口,允许从 Docker 容器外部访问容器内运行的 Redis 服务。默认为 `6379`。
- `REDIS_PASSWORD`  
  Redis 的密码。

### RAGFlow

- `SVR_HTTP_PORT`  
  用于将 RAGFlow 的 HTTP API 服务暴露给主机的端口,允许从 Docker 容器外部访问容器内运行的服务。默认为 `9380`。
- `RAGFLOW-IMAGE`  
  Docker 镜像版本。可用版本:

  - `infiniflow/ragflow:v0.16.0-slim`(默认):不嵌入模型的 RAGFlow Docker 镜像。
  - `infiniflow/ragflow:v0.16.0`:嵌入模型的 RAGFlow Docker 镜像,包括:
    - 内置嵌入模型:
      - `BAAI/bge-large-zh-v1.5`
      - `BAAI/bge-reranker-v2-m3`
      - `maidalun1020/bce-embedding-base_v1`
      - `maidalun1020/bce-reranker-base_v1`
    - 在 RAGFlow UI 中选择后将下载的嵌入模型:
      - `BAAI/bge-base-en-v1.5`
      - `BAAI/bge-large-en-v1.5`
      - `BAAI/bge-small-en-v1.5`
      - `BAAI/bge-small-zh-v1.5`
      - `jinaai/jina-embeddings-v2-base-en`
      - `jinaai/jina-embeddings-v2-small-en`
      - `nomic-ai/nomic-embed-text-v1.5`
      - `sentence-transformers/all-MiniLM-L6-v2`

> [!TIP]  
> 如果无法下载 RAGFlow Docker 镜像,请尝试以下镜像。
>
> - 对于 `nightly-slim` 版本:
    >   - `RAGFLOW_IMAGE=swr.cn-north-4.myhuaweicloud.com/infiniflow/ragflow:nightly-slim` 或
>   - `RAGFLOW_IMAGE=registry.cn-hangzhou.aliyuncs.com/infiniflow/ragflow:nightly-slim`。
> - 对于 `nightly` 版本:
    >   - `RAGFLOW_IMAGE=swr.cn-north-4.myhuaweicloud.com/infiniflow/ragflow:nightly` 或
>   - `RAGFLOW_IMAGE=registry.cn-hangzhou.aliyuncs.com/infiniflow/ragflow:nightly`。

### 时区

- `TIMEZONE`  
  本地时区。默认为 `'Asia/Shanghai'`。

### Hugging Face 镜像站点

- `HF_ENDPOINT`  
  huggingface.co 的镜像站点。默认情况下禁用。如果你对主要的 Hugging Face 域的访问受限,可以取消注释此行。

### MacOS

- `MACOS`  
  针对 macOS 的优化。默认情况下禁用。如果你的操作系统是 macOS,可以取消注释此行。

### 最大文件大小

- `MAX_CONTENT_LENGTH`  
  每个上传文件的最大文件大小(以字节为单位)。如果你想更改 128M 的文件大小限制,可以取消注释此行。进行更改后,确保相应地更新 nginx/nginx.conf 中的 `client_max_body_size`。

## 🐋 服务配置

[service_conf.yaml](./service_conf.yaml) 指定了 RAGFlow 的系统级配置,由其 API 服务器和任务执行器使用。在 Docker 化设置中,此文件是根据 [service_conf.yaml.template](./service_conf.yaml.template) 文件自动创建的(将所有环境变量替换为它们的值)。

- `ragflow`
  - `host`:Docker 容器内 API 服务器的 IP 地址。默认为 `0.0.0.0`。
  - `port`:Docker 容器内 API 服务器的服务端口。默认为 `9380`。

- `mysql`
  - `name`:MySQL 数据库名称。默认为 `rag_flow`。
  - `user`:MySQL 的用户名。
  - `password`:MySQL 的密码。
  - `port`:Docker 容器内 MySQL 的服务端口。默认为 `3306`。
  - `max_connections`:与 MySQL 数据库的最大并发连接数。默认为 `100`。
  - `stale_timeout`:超时时间(以秒为单位)。

- `minio`
  - `user`:MinIO 的用户名。
  - `password`:MinIO 的密码。
  - `host`:Docker 容器内 MinIO 的服务 IP *和*端口。默认为 `minio:9000`。

- `oauth`  
  使用第三方帐户注册或登录 RAGFlow 的 OAuth 配置。默认情况下禁用。要启用此功能,请取消注释 **service_conf.yaml.template** 中的相应行。
  - `github`:应用程序的 GitHub 身份验证设置。访问 [Github Developer Settings page](https://github.com/settings/developers) 以获取你的 client_id 和 secret_key。

- `user_default_llm`  
  新 RAGFlow 用户使用的默认 LLM。默认情况下禁用。要启用此功能,请取消注释 **service_conf.yaml.template** 中的相应行。
  - `factory`:LLM 供应商。可用选项:
    - `"OpenAI"`
    - `"DeepSeek"`
    - `"Moonshot"`
    - `"Tongyi-Qianwen"`
    - `"VolcEngine"`
    - `"ZHIPU-AI"`
  - `api_key`:指定 LLM 的 API 密钥。你需要在线申请你的模型 API 密钥。

> [!TIP]  
> 如果你没有在这里设置默认 LLM,请在 RAGFlow UI 的**设置**页面上配置默认 LLM。