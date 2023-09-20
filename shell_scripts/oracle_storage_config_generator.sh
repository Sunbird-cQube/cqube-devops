#!/bin/bash

check_name_space(){
while true
do
echo -e "\e[0;38m${bold}please enter the oracle name space ${normal} \e[0;36m${bold}(Hint: Enter the oracle Name space) ${normal}"
read name_space
if [[ -z $name_space ]]; then
   echo -e "\e[0;31m${bold}Error - Entered value is empty. please enter the Oracle name space${normal}"; fail=1
else
   printf "oracle_namespace: $name_space\n" >> config_files/oracle_storage_config.yml
   break;
fi
done

}


check_bucket_name(){
while true
do
	echo -e "\e[0;38m${bold}please enter the oracle storage bucket name ${normal} \e[0;36m${bold}(Hint: Enter oracle bucket_name)${normal}"
read bucket_name
if [[ -z $bucket_name ]]; then
   echo -e "\e[0;31m${bold}Error - Entered value is empty. please enter the Oracle bucket name${normal}"; fail=1
else
   printf "oracle_bucket: $bucket_name\n" >> config_files/oracle_storage_config.yml
   break;
fi
done

}

rm config_files/oracle_storage_config.yml
touch config_files/oracle_storage_config.yml
if [[ -e "config_files/oracle_storage_config.yml" ]]; then
check_name_space
check_bucket_name
fi


check_oracle_storage_config_file(){
if [[ -e "config_files/oracle_storage_config.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the oracle storage storage config file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/oracle_storage_config.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube oracle_storage_config.yml is entered. Follow Installation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the oracle_storage_config.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
             if [[ -e "config_files/oracle_storage_config.yml" ]]; then
                          if [[ $yn == yes ]]; then
                             rm config_files/oracle_storage_config.yml
                             touch config_files/oracle_storage_config.yml
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
                          
