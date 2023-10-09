ARG PHP_VERSION
ARG NODE_VERSION

FROM php:${PHP_VERSION:+${PHP_VERSION}-}cli

LABEL name=utility-service

ARG USER_ID=1000
ARG GROUP_ID=1000

# Installing packages and tools
RUN apt-get update && apt-get install -y \
  sudo \
  git \
  zip \
  unzip \
  curl \
  default-mysql-client \
  vim \
  nano \
  wget \
  libzip-dev \
  libicu-dev \
  libonig-dev \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  libxml2-dev \
  libxslt1-dev \
  libssl-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd pdo_mysql mysqli zip exif intl bcmath soap xsl \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION:-18}.x | bash - \
  && apt-get install -y nodejs \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn \
  && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && groupadd -g $GROUP_ID bedrock \
  && useradd -m -u $USER_ID -g bedrock bedrock \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

WORKDIR /var/www/html

USER bedrock

CMD ["tail", "-f", "/dev/null"]
