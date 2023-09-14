#!/bin/bash

sudo docker exec -i ingest_app sh << 'EOF'
apk add curl
curl --location --request GET 'http://spec_app:3001/readjsonFiles'
sleep 15
curl --location --request GET 'http://ingest_app:3000/upload-dimension'
sleep 15
curl --location --request POST 'http://ingest_app:3000/data-emitter'
EOF
