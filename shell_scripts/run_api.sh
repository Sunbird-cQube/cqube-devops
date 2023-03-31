api_endpoint=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' upgradation_config.yml)
sudo docker exec ansible_ingest_app_1  apk add curl

sudo docker exec ansible_ingest_app_1 curl -L http://$api_endpoint/api/ingestion/v4-data-emission

#sudo docker exec ansible_generator_app_1 /bin/bash -c "/python_app/adapter/VSK_data_transformation.sh" 

sudo docker exec -i ansible_generator_app_1 bash << 'EOF'
cd /python_app/adapter/
bash VSK_data_transformation.sh
EOF
