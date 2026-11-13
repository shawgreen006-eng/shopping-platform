#!/bin/sh
set -eu

cd "$(dirname "$0")"
if [ -e .env ]; then
    echo '.env 已存在；为避免覆盖线上数据库密码，未作修改。' >&2
    exit 1
fi

umask 077
shop_password="$(openssl rand -hex 24)"
root_password="$(openssl rand -hex 24)"
printf 'SHOP_DB_PASSWORD=%s\nMYSQL_ROOT_PASSWORD=%s\n' "$shop_password" "$root_password" > .env
echo '已生成仅供本服务器使用的 .env 密码文件。'
