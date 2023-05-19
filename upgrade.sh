#!/bin/bash

if [ `whoami` != root ]; then
    tput setaf 1; echo "Please run this script using sudo"; tput sgr0
  exit
else
    if [[ "$HOME" != "/root" ]]; then
        tput setaf 1; echo "Please run this script using normal user with 'sudo' privilege,  not as 'root'"; tput sgr0
    fi
fi

#Running script to install the basic softwares
chmod u+x shell_scripts/upgrade_basic_requirements.sh
. "shell_scripts/upgrade_basic_requirements.sh"

#Running script to validate and genarat config file
chmod u+x shell_scripts/upgradation_config_file_generator.sh
echo -e "\e[0;36m${bold}NOTE: We are going through a process of generating a configuration file. Please refer to the hints provided and enter the correct value${normal}"
. "shell_scripts/upgradation_config_file_generator.sh"

storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)

chmod u+x shell_scripts/remote_sanity.sh
. "shell_scripts/remote_sanity.sh"

if [[ $storage_type == "aws" ]]; then
chmod u+x shell_scripts/install_aws_cli.sh
. "shell_scripts/install_aws_cli.sh"
chmod u+x shell_scripts/upgradation_s3_storage_config_generator.sh
. "shell_scripts/upgradation_s3_storage_config_generator.sh"
fi

if [[ $storage_type == "azure" ]]; then
chmod u+x shell_scripts/install_azure_cli.sh
. "shell_scripts/install_azure_cli.sh"
chmod u+x shell_scripts/upgradation_azure_storage_config_generator.sh
. "shell_scripts/upgradation_azure_storage_config_generator.sh"
fi

if [[ $storage_type == "local" ]]; then
chmod u+x shell_scripts/local_storage_config_generator.sh
. "shell_scripts/local_storage_config_generator.sh"
chmod u+x shell_scripts/minio/install_minio.sh
. "shell_scripts/minio/install_minio.sh"
chmod u+x shell_scripts/minio/install_mc_client.sh
. "shell_scripts/minio/install_mc_client.sh"
chmod u+x shell_scripts/minio/crop_minio_ip.sh
. "shell_scripts/minio/crop_minio_ip.sh"
fi

if [[ $storage_type == "oracle" ]]; then
chmod u+x shell_scripts/install_oracle.sh
. "shell_scripts/install_oracle.sh"
chmod u+x shell_scripts/oracle_storage_config_generator.sh
. "shell_scripts/oracle_storage_config_generator.sh"
fi

#Running script to generate program selector config file
chmod u+x shell_scripts/program_selector.sh
. "shell_scripts/program_selector.sh"


#Running script to clone all the required repositories
chmod u+x shell_scripts/repository_clone.sh
. "shell_scripts/repository_clone.sh"

if [ -e /etc/ansible/ansible.cfg ]; then
    sudo sed -i 's/^#log_path/log_path/g' /etc/ansible/ansible.cfg
fi

echo '127.0.0.0' >> /etc/ansible/hosts

if [ ! $? = 0 ]; then
tput setaf 1; echo "Error there is a problem installing Ansible"; tput sgr0
exit
fi

if ! [ $( docker ps -a | grep postgres_app | wc -l ) -gt 0 ]; then
	
sed -i 's/^#/ /g' ansible/upgrade.yml
else
	echo "postgre container already exist"
fi


# migrating the cQube-4.1 data to cQube-5.O
chmod u+x shell_scripts/data_migration.sh
. "shell_scripts/data_migration.sh"

ansible-playbook ansible/remote_sanity.yml --tags "update"
ansible-playbook ansible/upgrade.yml --tags "update"
set -e
ansible-playbook ansible/upgrade_compose.yml --tags "update"

#Initialising the processor group in nifi
chmod u+x shell_scripts/upgradation_static_processor_groups.sh
. "shell_scripts/upgradation_static_processor_groups.sh"

chmod u+x shell_scripts/run_api.sh
. "shell_scripts/run_api.sh"

if [[ $storage_type == "oracle" ]]; then

chmod u+x shell_scripts/oracle.sh
. "shell_scripts/oracle.sh"

fi

#chmod u+x shell_scripts/restore_pgdata.sh
#. "shell_scripts/restore_pgdata.sh"

chmod u+x shell_scripts/upgradation_keycloak.sh
. "shell_scripts/upgradation_keycloak.sh"

if [ $? = 0 ]; then
echo -e "\e[0;32m${bold}cQube Upgraded successfully!!${normal}"
fi

#Running script to display important links
chmod u+x shell_scripts/install_generate_access_links.sh
. "shell_scripts/upgrade_generate_access_links.sh"

