FROM golang:1.7-alpine

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution

RUN set -ex \
    && apk add --no-cache git

RUN go get github.com/docker/distribution/cmd/registry

WORKDIR $DISTRIBUTION_DIR

COPY bin/registry /bin/registry
COPY cmd/registry/config-dev.yml /etc/docker/registry/config.yml

RUN chmod +x /bin/registry

VOLUME ["/var/lib/registry"]

EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
