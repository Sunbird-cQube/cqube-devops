#!/bin/bash

check_minio_bucket(){
 printf "minio_bucket: cqube-minio-bucket\n" >> config_files/upgradation_local_storage_config.yml
}

check_minio_username(){
 printf "minio_username: minioadmin\n" >> config_files/upgradation_local_storage_config.yml
}

check_minio_password(){
 printf "minio_password: minioadmin\n" >> config_files/upgradation_local_storage_config.yml
}


if [[ -e "config_files/upgradation_local_storage_config.yml" ]]; then
rm config_files/upgradation_local_storage_config.yml
touch config_files/upgradation_local_storage_config.yml
check_minio_bucket
check_minio_username
check_minio_password
fi
