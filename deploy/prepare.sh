#!/usr/bin/env bash
set -euo pipefail

deploy_dir="$(cd "$(dirname "$0")" && pwd)"
project_dir="$(dirname "$deploy_dir")"
frontend_dir="$project_dir/shopfronted"
backend_dir="${1:-$project_dir/shopbackend}"

if [[ ! -f "$frontend_dir/package.json" || ! -f "$backend_dir/pom.xml" ]]; then
    echo "找不到前端或后端项目。用法：bash deploy/prepare.sh [后端项目路径]" >&2
    exit 1
fi

if [[ ! -d "$frontend_dir/node_modules" ]]; then
    (cd "$frontend_dir" && npm ci)
fi

(cd "$frontend_dir" && npm run build)
(cd "$backend_dir" && ./mvnw -q -DskipTests clean package)

cp "$backend_dir/target/shopbackend-0.0.1-SNAPSHOT.jar" "$deploy_dir/api/shopbackend.jar"
rm -rf "$deploy_dir/web/dist"
cp -R "$frontend_dir/dist" "$deploy_dir/web/dist"

release_archive="$project_dir/shop-release.tar.gz"
(
    cd "$project_dir"
    COPYFILE_DISABLE=1 tar -czf "$release_archive" \
        deploy/compose.yaml deploy/.env.example deploy/create-env.sh deploy/README.md \
        deploy/api/Dockerfile deploy/api/shopbackend.jar \
        deploy/web/Dockerfile deploy/web/nginx.conf deploy/web/dist \
        deploy/database/01-init.sql
)

echo "部署包已准备好：$release_archive"
