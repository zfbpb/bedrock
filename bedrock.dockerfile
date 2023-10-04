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
  nodejs \
  yarn \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  # Adding a user
  && groupadd -g $GROUP_ID bedrock \
  && useradd -m -u $USER_ID -g bedrock bedrock \
  # Cleanup
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

WORKDIR /var/www/html

# Copying files
COPY ./build/.env /usr/local/bin/.env
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Setting execute permissions
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Setting user
USER bedrock

CMD ["/usr/local/bin/docker-entrypoint.sh"]
