# Bedrock/Sage10-MySQL-Apache-PHP-Docker

Project under construction.


docker compose up bedrock

docker-compose exec utility composer update

docker-compose exec utility composer update -w var/www/html/web/app/themes/sage-demo

docker-compose exec utility yarn install -w var/www/html/web/app/themes/sage-demo

docker-compose exec utility bash

There is no existing directory at "/var/www/html/web/app/cache/acorn/logs" and it could not be created: Permission denied
docker exec -u root -it [container-id] /bin/bash

pokretanje kontejnera kao root:
docker compose up utility -d
docker exec -u root -it utility /bin/bash

u kontejneru kao root: chmod -R 0755 app i sve radi, treba naći bolje rješenje

Ovako mora biti:
.setUrl('http://localhost:3000')
.setProxyUrl('http://localhost:8000')
.watch(['resources/views', 'app']);
