FROM golang:1.22@sha256:829eff99a4b2abffe68f6a3847337bf6455d69d17e49ec1a97dac78834754bd6 AS kopia

RUN CGO_ENABLED=0 go install github.com/kopia/kopia@v0.18.0

FROM alpine:3@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a

RUN apk add --no-cache bash github-cli

COPY --from=kopia /go/bin/kopia /usr/bin/kopia

COPY backup.sh /app/backup.sh
RUN chmod +x /app/backup.sh

CMD ["./app/backup.sh"]

