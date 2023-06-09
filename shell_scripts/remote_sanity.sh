#!/bin/bash

if [ $( docker ps -a | grep postgres_app | wc -l ) -gt 0 ]; then
sudo docker cp postgres_app:/var/lib/postgresql/data /opt/cqube
sudo chown -R ubuntu:ubuntu /home/cqube/data
fi

if [ $( docker ps -a | grep nifi_app | wc -l ) -gt 0 ]; then
sudo docker cp nifi_app:/opt/nifi/nifi-current/Sunbird-cQube-processing-ms /opt/cqube
sudo chown -R ubuntu:ubuntu /opt/cqube/Sunbird-cQube-processing-ms
fi

remove_docker(){
if [ $( docker ps -a | grep $1 | wc -l ) -gt 0 ]; then
sudo docker stop $1
sudo docker rm $1
sudo docker rmi $2
fi
}

remove_docker ingest_app ingestion_ms:1
remove_docker spec_app spec_ms:1
remove_docker generator_app generator_ms:1
remove_docker nifi_app nifi_ms:1 
remove_docker kong_app kong:latest
remove_docker python_app python_ms:1
remove_docker dashboard_app dashboard_ms:1
remove_docker querybuilder_app querybuilder_ms:1

sudo docker volume rm adapter_volume
