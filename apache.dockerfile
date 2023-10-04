ARG APACHE_VERSION=
FROM httpd:${APACHE_VERSION:+${APACHE_VERSION}-}alpine

LABEL name=apache-service

RUN apk update; \
  apk upgrade;

# Copy apache vhost file to proxy php requests to php-fpm container
COPY ./build/apache/apache.config.conf /usr/local/apache2/conf/apache.config.conf
RUN echo "Include /usr/local/apache2/conf/apache.config.conf" \
  >> /usr/local/apache2/conf/httpd.conf
