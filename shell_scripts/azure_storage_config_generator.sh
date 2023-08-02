#!/bin/bash

check_az_storage_connection_string(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter Azure connection string ${normal}"
echo -e "\e[0;38m${bold}please enter the connection string${normal}"
read az_connection_string

    az_account_status=0
    export AZURE_STORAGE_CONNECTION_STRING="$az_connection_string"

    az storage container list  --connection-string "$az_connection_string" > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
           echo -e "\e[0;31m${bold}Error echo Error - Invalid az storage connection string${normal}"; fail=1
        az_account_status=1
        else
         printf "azure_connection_string: $az_connection_string\n" >> config_files/azure_container_config.yml
        break;
    fi
done
}

check_az_key(){

while true
do
echo -e "\e[0;36m${bold}Hint: Enter Azure account key ${normal}"
echo -e "\e[0;38m${bold}please enter the azure account key${normal}"
read az_key
    printf "azure_account_key: $az_key\n" >> config_files/azure_container_config.yml
        break;

done
}


check_az_storage_account_name(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter Azure account name ${normal}"
echo -e "\e[0;38m${bold}please enter the azure account name${normal}"
read az_name
azure_account_key=$(awk ''/^azure_account_key:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/azure_container_config.yml)
    az_account_status=0

    az storage container list --account-key $azure_account_key --account-name $az_name > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
           echo -e "\e[0;31m${bold}Error - Invalid az account name${normal}"; fail=1
    check_az_container_key
    #az_account_status=1
else
        printf "azure_account_name: $az_name\n" >> config_files/azure_container_config.yml
        break;

    fi
done
}

check_az_archived_container(){
azure_connection_string=$(awk ''/^azure_connection_string:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/azure_container_config.yml)
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

if [[ $storage_type == azure ]]; then
export AZURE_STORAGE_CONNECTION_STRING="$azure_connection_string"
if az storage container create --name azure-cqube-edu --connection-string "$azure_connection_string" --output table | grep -q "True"; then

        printf "azure_container: azure-cqube-edu\n" >> config_files/azure_container_config.yml
else
while true
do
echo -e "\e[0;33m${bold}azure container azure-cqube-edu is already exists. if you want to continue with the same azure container enter no or you want to create new container enter yes .${normal}"
while true; do

             read -p "enter yes or no (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done

            if [[ $yn == yes ]]; then
echo -e "\e[0;36m${bold}Hint: Enter Azure blob container name ${normal}"
echo -e "\e[0;38m${bold}please enter the azure blob container${normal}"
read az_archived_container
az_container_status=0
  export AZURE_STORAGE_CONNECTION_STRING="$azure_connection_string"
azure_connection_string=$(awk ''/^azure_connection_string:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/azure_container_config.yml)
if az storage container create --name $az_archived_container --connection-string "$azure_connection_string" --output table | grep -q "False"; then
echo -e "\e[0;31m${bold}Error - Container alredy exit Please change the container name ${normal}"; fail=1

else
                  printf "azure_container: $az_archived_container\n" >> config_files/azure_container_config.yml
                  break;
fi
            fi
    done
fi
if [[ $yn == no ]]; then

printf "azure_container: azure-cqube-edu\n" >> config_files/azure_container_config.yml
fi
    fi

}


rm config_files/azure_container_config.yml
touch config_files/azure_container_config.yml
if [[ -e "config_files/azure_container_config.yml" ]]; then
check_az_storage_connection_string
check_az_key
check_az_storage_account_name
check_az_archived_container
fi

check_azure_config_file(){
if [[ -e "config_files/azure_container_config.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the azure storage config file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/azure_container_config.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube azure_container_config.yml is entered. Follow Installation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the azure_container_config.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
             if [[ -e "config_files/azure_container_config.yml" ]]; then
                          if [[ $yn == yes ]]; then
                             rm config_files/azure_container_config.yml
                             touch config_files/azure_container_config.yml
			     check_az_storage_connection_string
                             check_az_key
                             check_az_storage_account_name
                             check_az_archived_container
                           fi
             fi
     done
fi

if [[ $yn == no ]]; then
             echo -e "\e[0;32m${bold}Azure config file has been generated and validated successfully${normal}"

    fi
}

check_azure_config_file
