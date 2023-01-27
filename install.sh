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

echo '127.0.0.0' >> /etc/ansible/hosts

if [ ! $? = 0 ]; then
tput setaf 1; echo "Error there is a problem installing Ansible"; tput sgr0
exit
fi

ansible-playbook ansible/install.yml
ansible-playbook ansible/compose.yml
ansible-playbook ansible/install_nginx.yml

if [ $? = 0 ]; then
api_endpoint=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
echo "cQube installed successfully!!"
echo "cQube ingestion api's can be accessible using $api_endpoint/ingestion"
echo "cQube spec api's can be accessible using $api_endpoint/spec"
fi
