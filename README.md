<div align="center">
<a href="https://github.com/sumingcheng/DevTools"><img src="https://github.com/sumingcheng/DevTools/assets/21992204/ea3d950c-823b-4a53-9299-3c0a9234a5d9" width="120" height="120" alt="DevToos logo" ></a>

# DevToos

<p align="center">
  <a href="./README_EN.md">English</a> |
  <a href="./README.md">简体中文</a>
</p>
</div>


## 开发工具包

万事开头难，每次部署一些应用都要花费时间查找镜像和编写`Docker compose`。所以本工具包通过提供预配置的 `Docker compose` 文件和各种自动化脚本，帮助你快速启动和运行各种服务和应用，从而节省时间，提高效率。

### 特点

集成多种常用服务和应用的 Docker compose 文件，只需你掌握 docker 的使用即可启动。提供实用脚本，快速处理环境配置、安装与卸载任务。大部分工具和脚本已在 `Ubuntu jammy 22.04 x86_64` 上测试，可以正常启动运行。如果需要其他环境，请测试提交`PR`

### 应用列表

以下是目前支持的应用和服务

| 应用/服务     | 服务目录        | 主要功能        |
| ------------- | --------------- | --------------- |
| Elasticsearch | `elasticsearch` | 全文搜索引擎    |
| GitLab Runner | `gitlab-runner` | CI/CD任务自动化 |
| Jellyfin      | `jellyfin`      | 媒体服务器      |
| Kafka         | `kafka`         | 消息队列系统    |
| MinIO         | `minio`         | 对象存储        |
| MongoDB       | `mongo`         | NoSQL数据库     |
| MySQL         | `mysql`         | 关系数据库      |
| Portainer     | `portainer`     | 容器管理平台    |
| PostgreSQL    | `postgres`      | 关系数据库      |
| Prometheus    | `prometheus`    | 监控系统        |
| Redis         | `redis`         | 键值存储        |
| RocketMQ      | `rocketMQ`      | 消息中间件      |
| Syncthing     | `syncthing`     | 文件同步服务    |
| Harbor        | `harbor`        | 镜像仓库        |

### 脚本列表

| 服务目录   | 脚本文件名称            | 主要功能              |
| ---------- | ----------------------- | --------------------- |
| harbor     | `install.sh`            | 安装Harbor            |
| http-proxy | `set_proxy.sh`          | 设置代理服务器配置    |
| minikube   | `install_minikube.sh`   | 安装Minikube          |
| minikube   | `uninstall_minikube.sh` | 卸载Minikube          |
| packages   | `install_apt.sh`        | 使用APT安装常用软件包 |
| packages   | `select-sources.sh`     | APT多种源切换         |
| pyenv      | `install_pyenv.sh`      | 安装 Pyenv            |
| pyenv      | `uninstall_pyenv.sh`    | 卸载 Pyenv            |

### 其他

| 服务目录      | 文件类型       | 文件名称                                                     |
| ------------- | -------------- | ------------------------------------------------------------ |
| gitlab-runner | 配置文件       | `config.toml`, `gitlab.rb`                                   |
| http-proxy    | 脚本文件       | `set_proxy.sh`                                               |
| harbor        | 安装脚本       | `install.sh`                                                 |
| minikube      | 安装与卸载脚本 | `install_minikube.sh`, `uninstall_minikube.sh`               |
| minio         | 脚本和文本文件 | `file.txt`, `upload.py`                                      |
| packages      | 脚本和配置文件 | `apt-list.json`, `install_apt.sh`, `select-sources.sh`, `sources.list` |
| prometheus    | 配置文件       | `grafana.ini`, `prometheus.yml`                              |
| pyenv         | 安装与卸载脚本 | `install_pyenv.sh`, `uninstall_pyenv.sh`                     |
| system-info   | Python 脚本    | `getGPUs.py`, `requirements.txt`                             |

## 快速开始

```git
git clone https://github.com/sumingcheng/DevTools.git
```

选择需要部署的应用，进入对应目录，执行`docker-compose -up`

### 如何贡献

欢迎并鼓励社区成员贡献代码、文档、报告问题或提供新的想法。如果你有好的建议或功能增加，请通过 Issues 或 Pull Requests 与我们分享。

### 许可证

本项目采用 MIT 许可证，详情请见 LICENSE 文件。

### 支持

如果你觉得这个工具包有用，不妨给我们的项目加星或分享给更多的同行。如遇到问题，欢迎在 GitHub 上提交 Issues。

更欢迎你分享更多自己部署过的好玩有趣的应用~
