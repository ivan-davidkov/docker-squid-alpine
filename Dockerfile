FROM alpine:latest

MAINTAINER ivan@davidkov.eu

RUN apk update \
    && apk add squid \
    && apk add curl \
    && apk add openssl \
    && rm -rf /var/cache/apk/*

COPY configFiles/squid.conf /etc/squid/squid.conf
COPY configFiles/openssl.cnf /etc/ssl/openssl.cnf
COPY start-squid.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/start-squid.sh"]
