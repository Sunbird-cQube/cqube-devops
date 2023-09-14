#!/bin/bash
cd ../
cd Sunbird-cQube-processing-ms/impl/c-qube
yarn cli ingest-grammar -g='dimension' 
yarn cli ingest-grammar -g='event' 
yarn cli ingest-dimension
