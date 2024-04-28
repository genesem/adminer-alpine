
# docker.io/genesem/adminer-alpine
# https://github.com/genesem/adminer-alpine

FROM alpine:latest
LABEL maintainer "Gene Semerenko - https://github.com/genesem"

COPY about /usr/local/bin/ 
# COPY setconf.sh /etc/nginx/setconf

RUN set -eux; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk update && apk add -u procps bind-tools \
    rm -rf /var/cache/apk/*; \
    chmod +x /usr/local/bin/about; \
    mkdir -p /var/www/logs /var/www/html;

#COPY *.conf /etc/nginx/
#COPY conf.d /etc/nginx/conf.d

COPY www     /var/www
#WORKDIR     /etc/nginx/

# Execute the script to set internal dns resolver:
# ENTRYPOINT ["/bin/ash", "setconf.sh"]  # must be called from pod post init

# STOPSIGNAL SIGTERM
STOPSIGNAL SIGQUIT

EXPOSE 8010

#ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]


