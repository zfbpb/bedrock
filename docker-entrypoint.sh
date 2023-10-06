#!/bin/sh

if [ -d "/var/www/html/web" ]; then
    echo "Bedrock is already installed, exiting."
    echo "DONE."
    exit 1
fi

echo "Cleaning the destination directory..."
rm -rf ..?* .[!.]* *
echo "DONE."

echo "Installing Bedrock..."
composer create-project roots/bedrock .
echo "DONE."

set -a
. /usr/local/bin/.env
set +a

echo "Copying .env from /usr/local/bin to /var/www/html..."
yes | cp -rf /usr/local/bin/.env /var/www/html
ln ./build/.env ./html/.env

# Dodavanje Acorn plugina i konfiguracija odmah nakon instalacije Bedrocka
echo "Installing Acorn plugin..."
composer require roots/acorn
echo "Configuring Acorn in composer.json..."
jq '.scripts["post-autoload-dump"] += ["Roots\\Acorn\\ComposerScripts::postAutoloadDump"]' composer.json | sponge composer.json
echo "DONE."

cd /var/www/html/web/app/themes
echo "Installing Sage theme..."
composer create-project roots/sage $THEME_DIR_NAME
echo "DONE."

exec "$@"
