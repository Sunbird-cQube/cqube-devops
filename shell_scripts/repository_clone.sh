#!/bin/bash

MY_PATH="microservices"

cd "$MY_PATH"
git clone https://github.com/Sunbird-cQube/spec-ms.git
cd "spec-ms"
git checkout stable-Jan23
cd ../../

cd "$MY_PATH"
git clone https://github.com/Sunbird-cQube/ingestion-ms.git
cd "ingestion-ms"
git checkout stable-Jan23
cd ../../

cd "$MY_PATH"
git clone https://github.com/Sunbird-cQube/generator-ms.git
cd "generator-ms"
git checkout stable-Jan23
cd ../../
