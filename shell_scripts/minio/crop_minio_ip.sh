#!/bin/bash

fetch_minio_ip=$(docker inspect cqube_minio | grep 172 | grep IPAddress)
echo $fetch_minio_ip > shell_scripts/minio/minio_ip
minio_ip=$(cut -d " " -f 2 shell_scripts/minio/minio_ip)
touch ansible/roles/generator/vars/main.yml
echo minio_ip_address: ${minio_ip//,} >  ansible/roles/generator/vars/main.yml

