#!/bin/sh

freshInstall="y"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Installing Bedrock..."
composer create-project roots/bedrock .
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Installing Sage theme..."
cd /var/www/html/web/app/themes
composer create-project roots/sage sage-demo
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

echo "Theme path: /html/web/app/themes/${THEME_DIR_NAME}"

  # Take all the extra arguments and execute them as a command.
exec "$@"
