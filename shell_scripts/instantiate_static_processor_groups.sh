#!/bin/bash

db_user=$(awk ''/^db_user:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)
db_name=$(awk ''/^db_name:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

echo "Instantiating the processor group in nifi"
sleep 60
sudo docker exec -i ansible_generator_app_1 bash << 'EOF'
cd /python_app/static_processor_group/
python3 add_nifi_template.py
EOF

sudo docker exec -i ansible_nifi_app_1 bash << 'EOF'
bash cqube-ingest-install.sh
EOF

sudo docker exec -i ansible_postgres_app_1 psql -U $db_user -d $db_name << 'EOF'
ALTER TABLE spec."EventGrammar" ALTER  "instrumentField" DROP NOT NULL;
ALTER TABLE spec."EventGrammar" ALTER  "instrumentType" DROP NOT NULL;
ALTER TABLE spec."EventGrammar" ALTER  "dimensionMapping" DROP NOT NULL;
EOF
