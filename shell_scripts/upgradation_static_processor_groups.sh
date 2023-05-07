#!/bin/bash

db_user=$(awk ''/^db_user:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
db_name=$(awk ''/^db_name:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)

echo "Instantiating the processor group in nifi. It will take atleast 120 seconds to instantiate. Please do not cancel the process"
sleep 120
sudo docker exec -i generator_app bash << 'EOF'
cd /python_app/static_processor_group/
python3 add_nifi_template.py
EOF

sudo docker exec -i nifi_app bash << 'EOF'
pip3 install oci-cli
bash cqube-ingest-install.sh
EOF

sudo docker exec -i postgres_app psql -U $db_user -d $db_name << 'EOF'
ALTER TABLE spec."EventGrammar" ALTER  "instrumentField" DROP NOT NULL;
ALTER TABLE spec."EventGrammar" ALTER  "instrumentType" DROP NOT NULL;
ALTER TABLE spec."EventGrammar" ALTER  "dimensionMapping" DROP NOT NULL;
EOF
