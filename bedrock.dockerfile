ARG PHP_VERSION
FROM php:${PHP_VERSION:+${PHP_VERSION}-}cli

LABEL name=bedrock-service

ARG USER_ID=1000
ARG GROUP_ID=1000

# Installing packages and tools
RUN apt-get update && apt-get install -y \
  git \
  curl \
  unzip \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && groupadd -g $GROUP_ID bedrock \
  && useradd -m -u $USER_ID -g bedrock bedrock \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

RUN mkdir -p /var/www/html && chown -R bedrock:bedrock /var/www/html

WORKDIR /var/www/html

# Copying files
COPY --chown=bedrock:bedrock ./build/.env /usr/local/bin/.env
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Setting execute permissions
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Setting user
USER bedrock

CMD ["/usr/local/bin/docker-entrypoint.sh"]
