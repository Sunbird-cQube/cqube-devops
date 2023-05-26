#!/bin/bash

cd ../
cd Sunbird-cQube-processing-ms/impl/c-qube
#yarn cli ingest-grammar
#yarn cli ingest-dimension
yarn cli ingest-data --filter='nas'
