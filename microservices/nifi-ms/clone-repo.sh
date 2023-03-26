#!/bin/bash

result=$(curl -X GET --header "Accept: */*" "https://api.github.com/repos/ChakshuGautam/cQube-POCs/releases/latest")
echo "******************************************************* Response from server ********************************************************"
key='zipball_url'
value=$(echo $result | jq -r ".$key")
echo "$value"
rm -rf cqube-ingest.zip
rm -rf ChakshuGautam-cQube-POCs*
echo "***************************************************** Downloading the zip file ******************************************************"
wget -O cqube-ingest.zip $value
echo "****************************************************** Unzipping the zip file *******************************************************"
unzip cqube-ingest.zip
cd ChakshuGautam-cQube-POCs*
cd impl/c-qube
mkdir debug
