ARG PHP_VERSION
FROM php:${PHP_VERSION:+${PHP_VERSION}-}fpm as php-base

EXPOSE 9000

LABEL name=php-service

# Install essential packages
RUN apt-get update \
  && apt-get install -y \
  build-essential \
  curl \
  git \
  gnupg \
  less \
  nano \
  vim \
  unzip \
  zip \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

FROM php-base

# Install php extensions and related packages
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync \
  && install-php-extensions \
  @composer \
  exif \
  gd \
  memcached \
  mysqli \
  pcntl \
  pdo_mysql \
  zip \
  && apt-get update \
  && apt-get install -y \
  gifsicle \
  jpegoptim \
  libpng-dev \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  libmemcached-dev \
  locales \
  lua-zlib-dev \
  optipng \
  pngquant \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

COPY ./build/php/fpm/pool.d /etc/php/fpm/pool.d
