#!/bin/bash

check_minio_bucket(){
while true
do
 echo -e "\e[0;36m${bold}Hint: Enter the name of minio bucket name which needs to get created.${normal}"
 echo -e "\e[0;36m${bold}Please enter the minio bucket name${normal}"
 read minio_bucket_name
 printf "minio_bucket: $minio_bucket_name\n" >> config_files/upgradation_local_storage_config.yml
 break;
done
}

check_minio_username(){
while true
do
 echo -e "\e[0;36m${bold}Hint: Enter the username to login to minio.${normal}"
 echo -e "\e[0;36m${bold}Please enter the minio user name${normal}"
 read minio_user_name
 printf "minio_username: $minio_user_name\n" >> config_files/upgradation_local_storage_config.yml
 break;
done
}

check_minio_password(){
while true
do
 echo -e "\e[0;36m${bold}Hint: Enter the password to login to minio.${normal}"
 echo -e "\e[0;36m${bold}Please enter the minio password${normal}"
 read minio_pass
 printf "minio_password: $minio_pass\n" >> config_files/upgradation_local_storage_config.yml
 break;
done
}


check_local_config_file(){
echo -e "\e[0;33m${bold}Currently default minio credentials and bucket to be created are displayed below.${normal}"
echo -e "\e[0;38m${bold} minio_username: minioadmin ${normal}"
echo -e "\e[0;38m${bold} minio_password: minioadmin ${normal}"
echo -e "\e[0;38m${bold} minio_bucket: minio-cqube-edu ${normal}"
echo -e "\e[0;33m${bold}If you want to edit the local storage config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the local_storage file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
                          if [[ $yn == yes ]]; then
                             rm config_files/upgradation_local_storage_config.yml
                             touch config_files/upgradation_local_storage_config.yml
			     check_minio_bucket
                             check_minio_username
                             check_minio_password
                           fi

if [[ $yn == no ]]; then
   rm config_files/upgradation_local_storage_config.yml
   touch config_files/upgradation_local_storage_config.yml
   printf "minio_username: minioadmin\n" >> config_files/upgradation_local_storage_config.yml
   printf "minio_password: minioadmin\n" >> config_files/upgradation_local_storage_config.yml
   printf "minio_bucket: minio-cqube-edu\n" >> config_files/upgradation_local_storage_config.yml
   echo -e "\e[0;32m${bold}Local storage config file has been generated and validated successfully${normal}"
fi
}

check_local_config_file
