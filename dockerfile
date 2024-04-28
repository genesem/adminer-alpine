
# docker.io/genesem/adminer-alpine
# https://github.com/genesem/adminer-alpine

FROM alpine:latest
LABEL maintainer "Gene Semerenko - https://github.com/genesem"

# update repositories to edge
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    echo "UTC" > /etc/timezone;

RUN set -eux; \
    apk update && apk upgrade; \
    apk add --no-cache php php-common \
    php-odbc php-pdo php-pdo_odbc php-pdo_dblib \
    php-mysqli php-pdo_mysql php-pdo_pgsql \
    php-bcmath php-xml php-xmlreader php-bz2 php-iconv \
    php-opcache php-zip php-json php82-mbstring php82-session;

RUN rm -rf /var/cache/apk/*; \
    mkdir -p /var/www;

COPY www    /var/www
WORKDIR     /var/www

STOPSIGNAL SIGINT
EXPOSE 8080

CMD	[ "php", "-S", "[::]:8080", "-t", "/var/www" ]
