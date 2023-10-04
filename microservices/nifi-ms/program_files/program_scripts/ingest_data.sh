#!/bin/bash
echo "$1"
cd ../
cd Sunbird-cQube-processing-ms/impl/c-qube
yarn cli ingest-grammar -g='dimension' 
yarn cli ingest-grammar -g='event' 
yarn cli ingest-dimension
echo "yarn cli ingest-data --filter='$1'"
yarn cli ingest-data --filter="$1"
