FROM php:8.0-cli

# Instalacija osnovnih alata potrebnih za vašu skriptu
RUN apt-get update && apt-get install -y \
  git \
  zip \
  unzip \
  curl

# Instalacija Composer-a
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Definiranje radnog direktorija
WORKDIR /var/www/html

# Kopirajte vašu skriptu u kontejner
COPY  ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Osigurajte da je vaša skripta izvršiva
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
