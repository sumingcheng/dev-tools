<div align="center">
<a href="https://github.com/sumingcheng/DevTools"><img src="https://github.com/sumingcheng/DevTools/assets/21992204/ea3d950c-823b-4a53-9299-3c0a9234a5d9" width="120" height="120" alt="DevToos logo" ></a>

# DevToos

<p align="center">
  <a href="./README_EN.md">English</a> |
  <a href="./README.md">简体中文</a>
</p>

## 开发工具包

万事开头难，每次部署一些应用都要花费时间查找镜像和编写`Docker compose`。所以本工具包通过提供预配置的 `Docker compose` 文件和各种自动化脚本，帮助你快速启动和运行各种服务和应用，从而节省时间，提高效率。

### 特点

集成多种常用服务和应用的 Docker compose 文件，只需你掌握 docker 的使用即可启动。提供实用脚本，快速处理环境配置、安装与卸载任务。大部分工具和脚本已在 `Ubuntu jammy 22.04 x86_64` 上测试，可以正常启动运行。如果需要其他环境，请测试提交`PR`

### 内容

```bash
 ⚡ root@gptdev  /data/dev-tools   main ●  tree -D -L 1
.
├── [Aug 29 09:24]  docker          # 常用应用的 docker-compose
├── [Aug 23 13:56]  k8s             # k8s 应用
├── [Aug 29 17:14]  mk-template     # Makefile模板
├── [Aug  9 17:54]  py              # python 脚本
├── [Aug 29 09:24]  setup           # 常用的 linux 工具
├── [Aug  9 17:51]  sh              # 常用 sh 脚本
├── [Aug 29 09:24]  styles          # css 样式
└── [Aug  5 10:23]  vector-models   # 向量模型
```

## 快速开始

```git
git clone https://github.com/sumingcheng/dev-tools
```

选择需要部署的应用，进入对应目录，执行`docker-compose -up`或者是使用 `bash xx.sh`执行

### 如何贡献

欢迎并鼓励社区成员贡献代码、文档、报告问题或提供新的想法。如果你有好的建议或功能增加，请通过 Issues 或 Pull Requests 与我们分享。

### 许可证

本项目采用 MIT 许可证，详情请见 LICENSE 文件。

### 支持

如果你觉得这个工具包有用，不妨给我们的项目加星或分享给更多的同行。如遇到问题，欢迎在 GitHub 上提交 Issues。

更欢迎你分享更多自己部署过的好玩有趣的应用~
