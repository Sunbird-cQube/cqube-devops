#!/bin/bash

MY_PATH="microservices"

cd "$MY_PATH"
git clone https://github.com/Sunbird-cQube/spec-ms.git
cd "spec-ms"
git checkout staging
cd ../../

cd "$MY_PATH"
git clone https://github.com/Sunbird-cQube/ingestion-ms.git
cd "ingestion-ms"
git checkout staging
cd ../../

cd "$MY_PATH"
git clone https://github.com/Sunbird-cQube/generator-ms.git
cd "generator-ms"
git checkout staging
cd ../../
