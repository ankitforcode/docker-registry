FROM golang:1.7-alpine

RUN set -ex \
    && apk add --no-cache git

RUN go get github.com/docker/distribution/cmd/registry

RUN cp bin/registry /bin/registry && \
	mkdir -p /etc/docker/registry/ && \
	cp src/github.com/docker/distribution/cmd/registry/config-dev.yml /etc/docker/registry/config.yml && \
	chmod +x /bin/registry

VOLUME ["/var/lib/registry"]

EXPOSE 5000

ENTRYPOINT ["registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
