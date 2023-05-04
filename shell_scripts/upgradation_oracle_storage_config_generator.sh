#!/bin/bash

check_name_space(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter the oracle Name space ${normal}"
echo -e "\e[0;38m${bold}please enter the oracle name space ${normal}"
read name_space
        printf "oracle_namespace: $name_space\n" >> config_files/upgradation_oracle_storage_config.yml
        break;
done

}


check_bucket_name(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter oracle bucket_name ${normal}"
echo -e "\e[0;38m${bold}please enter the oracle storage bucket name ${normal}"
read bucket_name
        printf "oracle_bucket: $bucket_name\n" >> config_files/upgradation_oracle_storage_config.yml
        break;
done

}

check_oracle_storage_config_file(){
if [[ -e "config_files/upgradation_oracle_storage_config.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the oracle storage storage config file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/upgradation_oracle_storage_config.yml` ${normal}"
echo -e "\e[0;33m${bold}If you edit the oracle bucket name, all data will be lost. Currently cQube upgradation_oracle_storage_config.yml is entered. Follow upgradation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the upgradation_oracle_storage_config.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
             if [[ -e "config_files/oracle_storage_config.yml" ]]; then
                          if [[ $yn == yes ]]; then
                             rm config_files/upgradation_oracle_storage_config.yml
                             touch config_files/upgradation_oracle_storage_config.yml
                             check_name_space
			     check_bucket_name

                           fi
             fi
     done
fi

if [[ $yn == no ]]; then
             echo -e "\e[0;32m${bold}config file has been generated and validated successfully${normal}"

    fi
}

check_oracle_storage_config_file

