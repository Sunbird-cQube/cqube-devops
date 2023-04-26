api_endpoint=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)

sleep 30
sudo docker exec ingest_app  apk add curl << 'EOF'

sudo docker exec ingest_app curl -L http://$api_endpoint/api/ingestion/v4-data-emission
EOF
#sudo docker exec ansible_generator_app_1 /bin/bash -c "/python_app/adapter/VSK_data_transformation.sh" 

#sudo docker exec -i generator_app bash << 'EOF'
#cd /python_app/adapter/
#bash VSK_data_transformation.sh
#EOF

