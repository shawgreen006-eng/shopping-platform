# 购物网站部署包

这套部署包把 Vue 页面、Spring Boot 接口和 MySQL 放在一台云服务器上。浏览器只访问服务器的 80 端口；数据库和 Java 的 3306、8080 端口不对公网开放。

## 本机准备

后端项目在本目录的上一级 `shopbackend`，前端项目在本目录的上一级 `shopfronted`。在大作业目录运行：

```bash
bash deploy/prepare.sh
```

脚本会生成 `shop-release.tar.gz`，其中包含后端程序、前端页面、6 张商品图片和部署配置。它不会包含数据库密码。后续更新代码时再运行一次脚本，然后重新传输这个压缩包。

## 服务器准备

建议选择中国香港地域、Ubuntu 24.04、至少 2 核 CPU / 2 GB 内存的轻量云服务器。腾讯云当前公开标价中的香港入门型 2 核 2 GB 是 38 元/月，最终价格以购买页为准。购买前核对到期时间；服务器到期日应晚于**提交实验报告后三个月**。中国香港服务器无需中国内地 ICP 备案，但该入门型套餐不保证跨境公网质量，必须从校园网实际测试。如果校园网访问不稳定，需要调整地域或网络方案。

在服务器上安装 Docker Engine 和 Compose 插件，开放入站 TCP 80 与 SSH 22；不要向公网开放 3306 或 8080。安装步骤以 Docker 官方 Ubuntu 文档为准：<https://docs.docker.com/engine/install/ubuntu/>。

把 `shop-release.tar.gz` 传到服务器用户的主目录后，在服务器内执行：

```bash
tar -xzf shop-release.tar.gz
cd ~/deploy
sh create-env.sh
docker compose up -d --build
docker compose ps
```

首次启动时，MySQL 会创建 `shop` 数据库并载入 6 件示例商品。初始化 SQL 只在空数据库卷首次创建时执行。网站地址是 `http://服务器公网IP/`，商品接口是 `http://服务器公网IP/api/products`。登录、购物车、下单等作业功能目前还没有实现；上线这个版本只是让商品目录先公开可访问。

## 核对与更新

从校园网打开网站，确认 6 件商品和图片都出现，再搜索“键盘”。服务器上可用 `docker compose logs --tail=100 api` 查看后端日志。更新时重新运行本机 `prepare.sh`、上传并解压新的压缩包，再在服务器执行 `docker compose up -d --build`。不要删除 `mysql_data` 数据卷，它保存数据库内容。更新时也不要再次运行 `create-env.sh`，应保留服务器现有的 `.env`。

目前只公开商品目录。以后加入注册、登录或真实支付前，应先配置域名与 HTTPS，不要让用户通过明文 HTTP 提交账号或支付信息。

如需公开提交代码，另将前后端源码上传到 GitHub 或 Gitee，并在仓库 README 中填写自己的学号、姓名和源码说明；不要上传 `.env`、本机 MySQL 密码或 IntelliJ 的 `.idea` 文件。
