Squid
=====

Slim image (18MB) of Squid 3.5.4 running under Alpine Linux 3.2. This is a FORK :) original work chrisdaish@gmail.com

Changes
=======
 - Container on alpine:latest
 - Added openssl
 - Added ssl_bump
 - Updated config in order to work with SSL interception

How to use
=========

```
docker build -t local-squid https://github.com/ivan-davidkov/docker-squid-alpine.git
```

```
docker run -p 3128:3128 local-squid
```

With bespoke configuration:

```
docker run  -v <configPath>/squid.conf:/etc/squid/squid.conf:ro \
            -v <configPath/cache:/var/cache/squid:rw \
            -v /var/log/squid:/var/log/squid:rw \
            -v /etc/localtime:/etc/localtime:ro \
            -p 3128:3128 \
            local-squid
```

change your browser settings to use proxy server then point to localhost:3128
add the new SS certificate to your browser
enjoy
