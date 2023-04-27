#!/bin/bash

if [ $( docker ps -a | grep postgres_app | wc -l ) -gt 0 ]; then
sudo docker cp postgres_app:/var/lib/postgresql/data /home/ubuntu/
sudo chown -R ubuntu:ubuntu /home/ubuntu/data
fi
sudo docker stop $(sudo docker ps -aq)
sudo docker rm $(sudo docker ps -aq)
sudo docker rmi $(sudo docker images)

