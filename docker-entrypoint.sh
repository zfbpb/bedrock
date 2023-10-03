#!/bin/sh
freshInstall="y" # Nova instalacija?

ENV_PATH="./.env" # Putanja do bedrock .env datoteke u html folderu

echo ""
echo "Installing Bedrock..."
composer create-project roots/bedrock .
echo ""

echo ""
echo "Exporting .env variables..."

set -a
. /usr/local/bin/.env
set +a

echo ""
echo "Copying .env from /usr/local/bin to /var/www/html..."
yes | cp -rf /usr/local/bin/.env /var/www/html
ln ./.config/.env ./html/.env

echo "Installing Sage theme..."
cd /var/www/html/web/app/themes
echo ""
composer create-project roots/sage sage-demo

# Provjerava postoji li .env datoteka na navedenoj putanji
if [ -f "$ENV_PATH" ]; then
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo "Ispisujem sadržaj .env datoteke:"
    cat "$ENV_PATH"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
else
    echo ""
    echo "############################"
    echo "Nalazimo se na putanji: $(pwd) a ENV_PATH je na putanji $ENV_PATH"
    echo "############################"
    echo ""
    echo ".env datoteka ne postoji na putanji $ENV_PATH"
fi

# Finalization function.
finalize() {
  echo ""
  echo "*****************************************************************************************"
  echo ""
  echo " All done!"
  echo " cd into /html/web/app/themes/{THEME_DIR_NAME} on your host machine and run: "
  echo ""
  echo " yarn install "
  echo ""
  echo " and then "
  echo ""
  echo " yarn start "
  echo ""
  echo " to serve the project."
  echo ""
  echo "*****************************************************************************************"
  echo ""
}

  finalize

  # Take all the extra arguments and execute them as a command.
exec "$@"
