FROM php:8.0-cli

# Instalacija osnovnih alata potrebnih za vašu skriptu
RUN apt-get update && apt-get install -y \
  git \
  zip \
  unzip \
  curl \
  default-mysql-client \
  vim \
  nano \
  wget

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn

# nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash


# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY  ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# ENTRYPOINT ["docker-entrypoint.sh"]

# definiramo zadani proces koji će se pokrenuti kada se kontejner pokrene, to je bolja opcija nego entrypoint jer ga možemo overridati kada samostalno pokrećemo utility kontejner da bismo koristili njegove alate poput bash console: 

# samostalno pokretanje kontejnera:
# docker compose up utility -d
# docker run -it --entrypoint /bin/bash <image_name>
# primjer wp-cli:
# root@fbc8283ff3fa:/var/www/html# cd web
# root@fbc8283ff3fa:/var/www/html/web# wp user list

CMD ["/usr/local/bin/docker-entrypoint.sh"]
