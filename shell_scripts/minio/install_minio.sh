#!/bin/bash

docker pull minio/minio
docker network create ansible_cqube_net
docker run -p 9000:9000 -p 9001:9001 --name cqube_minio --network ansible_cqube_net -d minio/minio:latest server /data --console-address ":9001"
