FROM alpine:latest

RUN apk update && \
    apk add curl && \
    curl -LO https://dl.min.io/server/minio/release/linux-amd64/minio && \
    chmod +x minio && \
    mv minio /usr/local/bin/

EXPOSE 9000

CMD ["minio", "server", "/data"]
