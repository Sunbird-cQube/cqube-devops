#!/bin/bash
echo "Intantiating the processor group in nifi"
sleep 60
sudo docker exec -i ansible_generator_app_1 bash << 'EOF'
cd /python_app/static_processor_group/
python3 add_nifi_template.py
EOF

sudo docker exec -i ansible_nifi_app_1 bash << 'EOF'
bash cqube-ingest-install.sh
EOF
