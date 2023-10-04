#!/bin/sh

freshInstall="y"

echo "Installing Bedrock..."
composer create-project roots/bedrock .
echo "DONE."

# echo "Copying .env from /build to /html..."
# cp -v ../build/.env .env
# echo "DONE."

set -a
. /usr/local/bin/.env
set +a

echo "Copying .env from /usr/local/bin to /var/www/html..."
yes | cp -rf /usr/local/bin/.env /var/www/html
ln ./build/.env ./html/.env

cd /var/www/html/web/app/themes
echo "Installing Sage theme..."
composer create-project roots/sage sage-demo
echo "DONE."

# echo "Theme path: /html/web/app/themes/${THEME_DIR_NAME}"

exec "$@"
