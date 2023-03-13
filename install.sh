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

chmod u+x shell_scripts/install_aws_cli.sh
. "shell_scripts/install_aws_cli.sh"

#Running script to validate and genarat config file
chmod u+x shell_scripts/config_file_generator.sh
echo -e "\e[0;36m${bold}NOTE: We are going through a process of generating a configuration file. Please refer to the hints provided and enter the correct value${normal}"
. "shell_scripts/config_file_generator.sh"

#Running script to clone ingestion, spec repository
chmod u+x shell_scripts/repository_clone.sh
. "shell_scripts/repository_clone.sh"

if [ -e /etc/ansible/ansible.cfg ]; then
    sudo sed -i 's/^#log_path/log_path/g' /etc/ansible/ansible.cfg
fi

db_name=$(awk ''/^db_name:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
read_only_user=$(awk ''/^read_only_user:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
read_only_password=$(awk ''/^read_only_password:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
sudo sed -i "s|POSTGRES_DB|$db_name|g;s|READONLY_USER|$read_only_user|g;s|READONLY_PASS|$read_only_password|g" microservices/postgres-ms/init.sql

echo '127.0.0.0' >> /etc/ansible/hosts

if [ ! $? = 0 ]; then
tput setaf 1; echo "Error there is a problem installing Ansible"; tput sgr0
exit
fi

ansible-playbook ansible/install.yml
ansible-playbook ansible/compose.yml
ansible-playbook ansible/configurations.yml

if [ $? = 0 ]; then
echo -e "\e[0;32m${bold}cQube installed successfully!!${normal}"
fi

#Running script to display important links
chmod u+x shell_scripts/generate_access_links.sh
. "shell_scripts/generate_access_links.sh"
