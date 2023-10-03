#!/bin/sh

cd /var/www/html
echo ""
echo "Installing Bedrock..."
composer create-project roots/bedrock .

echo ""
echo "Installing Sage theme..."
cd /var/www/html/web/app/themes
composer create-project roots/sage sage-demo

# Putanja do .env datoteke
ENV_PATH="./.env"

# Provjerava postoji li .env datoteka na navedenoj putanji
if [ -f "$ENV_PATH" ]; then
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo "Ispisujem sadržaj .env datoteke:"
    cat "$ENV_PATH"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
else
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
