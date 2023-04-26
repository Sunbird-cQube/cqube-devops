#!/bin/bash

sudo docker cp  /home/ubuntu/data/ postgres_app:/var/lib/postgresql/

sudo docker restart postgres_app
