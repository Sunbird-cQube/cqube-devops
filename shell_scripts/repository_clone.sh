#!/bin/bash

MY_PATH=microservices
REPOSITORY=dev

cd "$MY_PATH"

if ! [[ -d spec-ms ]]; then
	git clone https://github.com/Sunbird-cQube/spec-ms.git
	cd "spec-ms"
	git checkout $REPOSITORY
	cd ../../
else
	cd "spec-ms"
	git checkout $REPOSITORY
	git pull
        cd ../../
fi

cd "$MY_PATH"
if ! [[ -d ingestion-ms ]]; then
	git clone https://github.com/Sunbird-cQube/ingestion-ms.git
	cd "ingestion-ms"
	git checkout $REPOSITORY
	cd ../../
else
	cd "ingestion-ms"
	git checkout $REPOSITORY
	git pull
	cd ../../
fi

cd "$MY_PATH"
if ! [[ -d generator-ms ]]; then
	git clone https://github.com/Sunbird-cQube/generator-ms.git
	cd "generator-ms"
	git checkout $REPOSITORY
	cd ../../
else 
	cd "generator-ms"
	git checkout $REPOSITORY
	git pull
	cd ../../

fi
