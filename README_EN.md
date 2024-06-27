## Application Deployment Toolkit

Getting started is often the hardest part, especially when deploying applications as it involves time-consuming tasks like searching for images and writing Docker compose files. Thus, this toolkit provides pre-configured Docker compose files and various automation scripts to help you quickly launch and run various services and applications, saving time and enhancing efficiency.

### Features

This toolkit integrates Docker compose files for various commonly used services and applications, accessible to anyone familiar with Docker. It includes practical scripts for quickly handling environment configurations, installations, and uninstallations. Most tools and scripts have been tested on `Ubuntu jammy 22.04 x86_64` and are confirmed to work smoothly. If you need to use other environments, please test and submit a `PR`.

### Application List

Here are the currently supported applications and services:

| Application/Service | Service Directory | Main Function                 |
| ------------------- | ----------------- | ----------------------------- |
| Elasticsearch       | `elasticsearch`   | Full-text search engine       |
| GitLab Runner       | `gitlab-runner`   | CI/CD task automation         |
| Jellyfin            | `jellyfin`        | Media server                  |
| Kafka               | `kafka`           | Message queue system          |
| MinIO               | `minio`           | Object storage                |
| MongoDB             | `mongo`           | NoSQL database                |
| MySQL               | `mysql`           | Relational database           |
| Portainer           | `portainer`       | Container management platform |
| PostgreSQL          | `postgres`        | Relational database           |
| Prometheus          | `prometheus`      | Monitoring system             |
| Redis               | `redis`           | Key-value store               |
| RocketMQ            | `rocketMQ`        | Message middleware            |
| Syncthing           | `syncthing`       | File synchronization service  |

### Script List

| Service Directory | Script File Name        | Main Function                   |
| ----------------- | ----------------------- | ------------------------------- |
| harbor            | `install.sh`            | Install Harbor                  |
| http-proxy        | `set_proxy.sh`          | Set proxy server configuration  |
| minikube          | `install_minikube.sh`   | Install Minikube                |
| minikube          | `uninstall_minikube.sh` | Uninstall Minikube              |
| packages          | `install_apt.sh`        | Install common packages via APT |
| packages          | `select-sources.sh`     | Switch APT sources              |
| pyenv             | `install_pyenv.sh`      | Install Pyenv                   |
| pyenv             | `uninstall_pyenv.sh`    | Uninstall Pyenv                 |

### Additional

| Service Directory | File Type                               | File Names                                                   |
| ----------------- | --------------------------------------- | ------------------------------------------------------------ |
| gitlab-runner     | Configuration files                     | `config.toml`, `gitlab.rb`                                   |
| http-proxy        | Script file                             | `set_proxy.sh`                                               |
| harbor            | Installation script                     | `install.sh`                                                 |
| minikube          | Installation and uninstallation scripts | `install_minikube.sh`, `uninstall_minikube.sh`               |
| minio             | Scripts and text file                   | `file.txt`, `upload.py`                                      |
| packages          | Scripts and configuration files         | `apt-list.json`, `install_apt.sh`, `select-sources.sh`, `sources.list` |
| prometheus        | Configuration files                     | `grafana.ini`, `prometheus.yml`                              |
| pyenv             | Installation and uninstallation scripts | `install_pyenv.sh`, `uninstall_pyenv.sh`                     |
| system-info       | Python scripts                          | `getGPUs.py`, `requirements.txt`                             |

## Quick Start

```
git
Copy code
git clone https://github.com/yourusername/project-deployment-toolkit.git
```

Choose the application you need to deploy, go to the corresponding directory, and execute `docker-compose up`.

### How to Contribute

We welcome and encourage community members to contribute code, documentation, report issues, or provide new ideas. If you have good suggestions or feature additions, please share them through Issues or Pull Requests.

### License

This project is under the MIT License, see the LICENSE file for details.

### Support

If you find this toolkit useful, consider starring our project or sharing it with more colleagues. If you encounter any problems, feel free to submit an Issue on GitHub.

We look forward to your contributions and more interesting applications that you have deployed!