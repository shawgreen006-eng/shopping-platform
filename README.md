# 购物网站大作业

这是一个使用 Vue、Spring Boot 和 MySQL 开发的购物网站课程项目。目前已完成商品展示与搜索，购物车、账号、订单等功能仍在开发中。

## 目录

- `shopfronted/`：Vue 前端（项目创建时使用的名称，保留原名）。
- `shopbackend/`：Spring Boot 后端。**以后请在这个目录修改后端代码**；`~/Downloads/shopbackend` 是之前的旧副本。
- `database/`：商品表的升级脚本。
- `deploy/`：服务器部署配置与初始化脚本；用法见 [部署说明](deploy/README.md)。

## 本地运行

1. 启动本机 MySQL，确保已有 `shop` 数据库和 `products` 表。
2. 在 IntelliJ 中打开 `shopbackend/`，运行 `ShopbackendApplication`。运行配置中设置环境变量 `SHOP_DB_PASSWORD` 为**你自己的本机数据库密码**，不要把密码写进代码或提交到 GitHub。
3. 在终端进入 `shopfronted/`，运行 `npm ci` 和 `npm run dev`。
4. 浏览器打开终端显示的本地地址，通常为 `http://localhost:5173/`。前端把 `/api` 请求转发到本机 8080 端口的后端。

## 上传代码

项目根目录已经单独初始化 Git 仓库并创建首次提交，避免把电脑其他文件带上去。先在 GitHub 新建**空白仓库**（不要勾选添加 README、`.gitignore` 或许可证），再在本目录运行：

```bash
git remote add origin https://github.com/你的用户名/你的仓库名.git
git push -u origin main
```

上传前可用 `git status --short` 核对文件清单。仓库应包括源码和商品图片，不应包括密码、`.env`、`node_modules`、编译结果或 IntelliJ 的 `.idea` 目录。今后修改代码后，用 `git add .`、`git commit -m "说明本次改动"`、`git push` 更新。课程报告要求的姓名、学号请由本人填写到此 README，再提交。
