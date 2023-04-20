
#!/bin/bash

storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

if [[ $storage_type == "oracle" ]]; then
sudo docker cp /root/.oci/ ingest_app:/root

sudo docker cp /root/.oci/ nifi_app:/root

sudo docker cp /root/.oci/ querybuilder_app:/root

sudo docker cp /root/.oci/ generator_app:/root
fi
