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
chmod u+x shell_scripts/basic_requirements.sh
. "shell_scripts/basic_requirements.sh"

chmod u+x shell_scripts/domain_config_generator.sh
echo -e "\e[0;36m${bold}NOTE: We are going through a process of generating a domain specific configuration file. Please refer to the hints provided and enter the correct value${normal}"
. "shell_scripts/domain_config_generator.sh"

#Running script to validate and genarat config file
chmod u+x shell_scripts/config_file_generator.sh
echo -e "\e[0;36m${bold}NOTE: We are going through a process of generating a configuration file. Please refer to the hints provided and enter the correct value${normal}"
. "shell_scripts/config_file_generator.sh"

# create a docker network using a defined subnet
docker network create --driver=bridge --subnet=10.0.0.0/16 --gateway=10.0.0.1 cqube_net

storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

if [[ $storage_type == "aws" ]]; then
chmod u+x shell_scripts/install_aws_cli.sh
. "shell_scripts/install_aws_cli.sh"
chmod u+x shell_scripts/s3_storage_config_generator.sh
. "shell_scripts/s3_storage_config_generator.sh"
fi

if [[ $storage_type == "azure" ]]; then
chmod u+x shell_scripts/install_aws_cli.sh
. "shell_scripts/install_azure_cli.sh"
chmod u+x shell_scripts/azure_storage_config_generator.sh
. "shell_scripts/azure_storage_config_generator.sh"
fi

if [[ $storage_type == "local" ]]; then
   chmod u+x shell_scripts/local_storage_config_generator.sh
   . "shell_scripts/local_storage_config_generator.sh"
   chmod u+x shell_scripts/minio/install_minio.sh
   . "shell_scripts/minio/install_minio.sh"
fi

if [[ $storage_type == "oracle" ]]; then
   chmod u+x shell_scripts/install_oracle.sh
   . "shell_scripts/install_oracle.sh"
   chmod u+x shell_scripts/oracle_storage_config_generator.sh
   . "shell_scripts/oracle_storage_config_generator.sh"
fi

#Running script to generate program selector config file
access_type=$(awk ''/^access_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
if [[ $access_type == "VSK" ]]; then
   chmod u+x shell_scripts/program_selector.sh
   . "shell_scripts/program_selector.sh"
fi

if [[ $access_type == "NVSK" ]]; then
   chmod u+x shell_scripts/national_program_selector.sh
   . "shell_scripts/national_program_selector.sh"
fi

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

mode_of_installation=$(awk ''/^mode_of_installation:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

if [[ $mode_of_installation == "public" ]]; then
   ansible-playbook ansible/public_install.yml --tags "install"
else
   ansible-playbook ansible/localhost_install.yml --tags "install"
fi

set -e
ansible-playbook ansible/compose.yml --tags "install"

#Initialising the processor group in nifi
chmod u+x shell_scripts/instantiate_static_processor_groups.sh
. "shell_scripts/instantiate_static_processor_groups.sh"

#Grant readonly access to the schemas
chmod u+x shell_scripts/pg_read_only_access.sh
. "shell_scripts/pg_read_only_access.sh"


if [[ $storage_type == "oracle" ]]; then
   chmod u+x shell_scripts/oracle.sh
   . "shell_scripts/oracle.sh"
fi

#Creating realm,client and secret in keycloak
chmod u+x shell_scripts/keycloak.sh
. "shell_scripts/keycloak.sh"

# ingestion of telemetry schema
chmod u+x shell_scripts/telemetry_ingestion.sh
. "shell_scripts/telemetry_ingestion.sh"

#Data ingestion if the user wants to ingest the data automatically
data_pull_status=$(awk ''/^data_pull_status:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
if [[ $data_pull_status == "true" ]]; then
chmod u+x shell_scripts/data_ingestion.sh
. "shell_scripts/data_ingestion.sh"
fi

if [ $? = 0 ]; then
echo -e "\e[0;32m${bold}cQube installed successfully!!${normal}"
fi

#Running script to display important links
chmod u+x shell_scripts/install_generate_access_links.sh
. "shell_scripts/install_generate_access_links.sh"
