#!/bin/sh

# freshInstall="y"

# echo "Installing Bedrock..."
# composer create-project roots/bedrock .
# echo "DONE."

# cd /var/www/html/web/app/themes
# echo "Installing Sage theme..."
# composer create-project roots/sage sage-demo
# echo "DONE."

# echo "Theme path: /html/web/app/themes/${THEME_DIR_NAME}"

#!/bin/sh

echo "Trenutni direktorij je: $(pwd)"
echo "Pregled datoteka u trenutnom direktoriju:"
ls -la $(pwd)

# Ako datoteka postoji, pokušajte je kopirati
if [ -f "demo1.txt" ]; then
  cp -v demo1.txt demo2.txt
else
  echo "Datoteka demo1.txt ne postoji!"
fi

exec "$@"
