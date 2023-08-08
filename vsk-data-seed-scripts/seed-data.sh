#!/bin/bash

read -p "Do you want to ingest data? (y/n): " choice

if [ "$choice" == "n" ] || [ "$choice" == "N" ] || [ "$choice" == "No" ] || [ "$choice" == "NO" ] || [ "$choice" == "no" ]; then
    exit 0
fi

echo "💿 Starting Data Ingestion"

bash ./seed_vsk_dimensions_grammar.sh
bash ./seed_vsk_grammar.sh

wget https://drive.usercontent.google.com/download?id=1t1YYTzJeGyUrh1YZvk6d2uae39yDKj1c -O demo-data.zip
unzip demo-data.zip
rm demo-data.zip

python seed_dimensions_data.py