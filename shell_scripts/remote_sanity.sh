#!/bin/bash
sudo docker cp postgres_app:/var/lib/postgresql/data /home/ubuntu/
sudo chown -R ubuntu:ubuntu /home/ubuntu/data
sudo docker stop $(sudo docker ps -aq)
sudo docker rm $(sudo docker ps -aq)
sudo docker rmi $(sudo docker images)

