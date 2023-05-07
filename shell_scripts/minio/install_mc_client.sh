#!/bin/sh


# Download the mc binary
wget https://dl.min.io/client/mc/release/linux-amd64/mc

# Make the mc binary executable
chmod +x mc

# Move the mc binary to /usr/local/bin
mv mc /usr/local/bin
docker_host=localhost

mc alias set myminio http://$docker_host:9002 minioadmin minioadmin

mc mb myminio/cqube-minio-bucket
