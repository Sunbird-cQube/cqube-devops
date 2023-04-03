#!/bin/bash

check_input_files(){

input_path=$(awk ''/^input_path:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
system_user_name=$(awk ''/^system_user_name:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
azure_connection_string=$(awk ''/^azure_connection_string:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_azure_container_config.yml)

mkdir /home/$system_user_name/old_input_files
if [[ $storage_type == local ]]; then
echo "migrating the cQube-4.1 input data to old_input_files directory ..."
cp -R $input_path* old_input_files

fi
if [[ $storage_type == aws ]]; then
echo "migrating the cQube-4.1 s3 input bucket data to old_input_files directory ..."    
aws s3 sync s3://$input_path /home/$system_user_name/old_input_files
fi

if [[ $storage_type == azure ]]; then
echo "migrating the cQube-4.1 input container data to old_input_files directory ..."    
az login

az storage blob download-batch -d . --connection-string "$azure_connection_string" --source $input_path --destination /home/$system_user_name/old_input_files

fi
}

check_input_files

