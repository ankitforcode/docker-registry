FROM golang:1.7-alpine

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution

RUN mkdir -p /go/src/github.com/docker/distribution

RUN set -ex \
    && apk add --no-cache make git

WORKDIR $DISTRIBUTION_DIR

COPY registry $DISTRIBUTION_DIR/registry
COPY config.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]

EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
