#!/bin/bash

db_user=$(awk ''/^db_user:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)
db_name=$(awk ''/^db_name:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

echo "Instantiating the processor group in nifi"
sleep 60
sudo docker exec -i generator_app bash << 'EOF'
cd /python_app/static_processor_group/
python3 add_nifi_template.py
EOF

sudo docker exec -i nifi_app bash << 'EOF'
bash cqube-ingest-install.sh
EOF

sudo docker exec -i postgres_app psql -U $db_user -d $db_name << 'EOF'
ALTER TABLE spec."EventGrammar" ALTER  "instrumentField" DROP NOT NULL;
ALTER TABLE spec."EventGrammar" ALTER  "instrumentType" DROP NOT NULL;
ALTER TABLE spec."EventGrammar" ALTER  "dimensionMapping" DROP NOT NULL;
EOF
