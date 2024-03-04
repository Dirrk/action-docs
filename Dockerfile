FROM index.docker.io/library/alpine:3.10

RUN set -x \
  && apk add --no-cache bash sed jq curl git wget \
  && wget -O gomplate https://github.com/hairyhenderson/gomplate/releases/download/v3.6.0/gomplate_linux-amd64 \
  && chmod 755 gomplate \
  && mv gomplate /usr/local/bin/gomplate \
  && mkdir -p /src

COPY src /src/

ENTRYPOINT ["/src/docker-entrypoint.sh"]
