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

dev-tools 是一个集成多种常用服务和应用 Docker compose 模板的开发工具包。它可以帮助开发者快速启动和运行各种服务和应用,从而节省时间,提高开发效率。

### 特点
- 集成多种常用服务和应用的 Docker compose 文件,只需掌握 docker 使用即可快速启动
- 提供实用脚本,可快速处理环境配置、安装与卸载等任务 
- 大部分工具和脚本已在 Ubuntu 22.04 x86_64 环境下测试,可正常运行。其他环境请测试后提交 PR

### 内容

| 目录                              | 描述                      |
| --------------------------------- | ------------------------- |
| [docker](./docker/)               | 常用应用的 docker-compose |
| [k8s](./k8s/)                     | k8s 应用(正在完善)        |
| [Dockerfile](Dockerfile/) | 常用项目打包的 Makefile 模板 |
| [py](./py/)                       | python 脚本               |
| [setup](./setup/)                 | 常用的 linux 工具         |
| [sh](./sh/)                       | 常用 sh 脚本              |
| [styles](./styles/)               | css 样式                  |
| [vector-models](./vector-models/) | 向量模型                  |
| [devops](./devops/) | 部署CI/CD |

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

欢迎并鼓励社区成员贡献代码、文档、报告问题或提供新的想法。如果你有好的建议或新功能,请通过 Issues 或 Pull Requests 与我们分享。

## 使用场景

- 快速搭建开发环境,启动常用服务,如 Redis、MySQL 等
- 测试 docker-compose 编排的应用
- 自动化运维,批量管理服务
- 学习和研究 docker、k8s 等技术

## 许可证

本项目采用 MIT 许可证,详情请见 [LICENSE](./LICENSE) 文件。

## 支持

如果你觉得这个项目有用,欢迎给我们点个 star star 或分享给更多人。

如遇到问题,欢迎提交 [Issues](https//github.com/sumingcheng/dev-tools/issues) 反馈。

也非常欢迎你分享自己部署和使用过的有趣应用,让这个项目变得更加丰富多彩。
