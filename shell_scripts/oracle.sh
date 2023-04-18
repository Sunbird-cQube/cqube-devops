
#!/bin/bash

storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

if [[ $storage_type == "oracle" ]]; then
sudo docker cp /home/ubuntu/.oci/ ingest_app:/root

sudo docker cp /home/ubuntu/.oci/ nifi_app:/root

sudo docker cp /home/ubuntu/.oci/ querybuilder_app:/root

sudo docker cp /home/ubuntu/.oci/ generator_app:/root
fi
