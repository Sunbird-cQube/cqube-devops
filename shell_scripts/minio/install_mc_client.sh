#!/bin/sh

minio_username=$(awk ''/^minio_username:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/local_storage_config.yml)
minio_password=$(awk ''/^minio_password:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/local_storage_config.yml)
minio_bucket=$(awk ''/^minio_bucket:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/local_storage_config.yml)
minio_username=$(awk ''/^minio_username:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_local_storage_config.yml)
minio_password=$(awk ''/^minio_password:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_local_storage_config.yml)
minio_bucket=$(awk ''/^minio_bucket:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_local_storage_config.yml)


# Download the mc binary
wget https://dl.min.io/client/mc/release/linux-amd64/mc

# Make the mc binary executable
chmod +x mc

# Move the mc binary to /usr/local/bin
mv mc /usr/local/bin
docker_host=localhost

mc alias set myminio http://$docker_host:9000 $minio_username $minio_password

mc mb myminio/$minio_bucket
