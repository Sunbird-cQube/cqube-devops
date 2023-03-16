#!/bin/sh

# Download the mc binary
wget https://dl.min.io/client/mc/release/linux-amd64/mc

# Make the mc binary executable
chmod +x mc

# Move the mc binary to /usr/local/bin
mv mc /usr/local/bin
#docker_host=172.17.0.2
docker_host=$(awk ''/^docker_host:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
docker_host=$(awk ''/^docker_host:' /{ if ($2 !~ /#.*/) {print $2}}' upgradation_config.yml)
mc alias set myminio http://$docker_host:9000 minioadmin minioadmin

mc mb myminio/minio-cqube_edu

