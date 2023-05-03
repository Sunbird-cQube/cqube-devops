#!/bin/bash

if [ $( docker ps -a | grep postgres_app | wc -l ) -gt 0 ]; then
sudo docker cp postgres_app:/var/lib/postgresql/data /home/ubuntu/
sudo chown -R ubuntu:ubuntu /home/ubuntu/data
fi
sudo docker stop ingest_app
sudo docker stop generator_app
sudo docker stop nginx_app
sudo docker stop kong_app
sudo docker stop spec_app
sudo docker stop dashboard_app
sudo docker stop python_app
sudo docker stop querybuilder_app
sudo docker stop nifi_app

sudo docker rm ingest_app
sudo docker rm generator_app
sudo docker rm nginx_app
sudo docker rm kong_app
sudo docker rm spec_app
sudo docker rm dashboard_app
sudo docker rm python_app
sudo docker rm querybuilder_app
sudo docker rm nifi_app


sudo docker rmi $(sudo docker images)
sudo docker volume rm ansible_adapter_volume

