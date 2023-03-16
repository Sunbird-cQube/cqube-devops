#!/bin/sh

# Download the mc binary
wget https://dl.min.io/client/mc/release/linux-amd64/mc

# Make the mc binary executable
chmod +x mc

# Move the mc binary to /usr/local/bin
mv mc /usr/local/bin
docker_host=172.17.0.2
mc alias set myminio http://$docker_host:9000 minioadmin minioadmin

mc mb myminio/minio-cqube-edu
