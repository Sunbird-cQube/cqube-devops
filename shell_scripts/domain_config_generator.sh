#!/bin/bash

check_access_type(){
while true
do
    echo -e "\e[0;36m${bold}Hint: enter NVSK or VSK or others${normal}"
    echo -e "\e[0;38m${bold}please enter the access_type${normal}"
    read access_typ
      if ! [[ $access_typ == "NVSK" || $access_typ == "VSK" || $access_typ == "others" ]]; then
         echo -e "\e[0;31m${bold}Error - Please enter either NVSK or VSK or others"; fail=1
      else
        printf "access_type: $access_typ\n" >> config_files/domain_specific_config.yml
        break;
      fi
done
}

check_state(){
access_type=$(awk ''/^access_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
if [[ $access_type == "NVSK" || $access_type == "others" ]]; then
   printf "state_name: NA\n" >> config_files/domain_specific_config.yml
else
  while true
  do
  echo -e "\e[0;36m${bold}Hint: Please enter state code ( refer to state_list )${normal}"
  echo -e "\e[0;38m${bold}please enter the state_code ${normal} "
  read state_name
  state_found=0
  while read line; do
  if [[ $line == $state_name ]] ; then
     state_found=1
  fi
  done < shell_scripts/state_codes
  if [[ $state_found == 0 ]] ; then
     echo -e "\e[0;31m${bold}Error - Invalid State Code. Please refer to the state_list file and enter the correct value.${normal}"; fail=1
  else
     printf "state_name: $state_name\n" >> config_files/domain_specific_config.yml
     break;
  fi
  done
fi
}

check_state_id(){
access_type=$(awk ''/^access_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
state_name=$(awk ''/^state_name:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
if [[ $access_type == "VSK" ]]; then
   state_id_check=$(grep -o "$state_name=[0-9]*" sshell_scripts/tate_id_list | cut -d'=' -f2)
   printf "state_id: $state_id_check\n" >> config_files/domain_specific_config.yml
else
   printf "state_id: NA\n" >> config_files/domain_specific_config.yml
fi
}

check_login(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable login screen for cqube dashboard ${normal}"
echo -e "\e[0;38m${bold}please enter true or false. ${normal}"
read login_status
        if ! [[ $login_status == "true" || $login_status == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "loginpage_status: $login_status\n" >> config_files/domain_specific_config.yml
                        break;

        fi
done
}

check_data_pull_status(){
access_type=$(awk ''/^access_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
if ! [[ $access_type == "NVSK" || $access_type == "others" ]]; then
     while true
     do
     echo -e "\e[0;36m${bold}Hint: Enter true if you want to pull the data from NVSK server. Else enter false ${normal}"
     echo -e "\e[0;38m${bold}please enter true or false. ${normal}"
     read data_pull
     if ! [[ $data_pull == "true" || $data_pull == "false" ]]; then
          echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
     else
          printf "data_pull_status: $data_pull\n" >> config_files/domain_specific_config.yml
          break;
     fi
     done
else
	printf "data_pull_status: NA\n" >> config_files/domain_specific_config.yml
        break;
fi
}

check_nvsk_url(){
data_pull_status=$(awk ''/^data_pull_status:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
if [[ $data_pull_status == "true" ]]; then
   while true
   do
   echo -e "\e[0;36m${bold}Hint: enter NVSK domain name ( Example: cqubeprojects.com )${normal}"     
   echo -e "\e[0;38m${bold}please enter the nvsk_endpoint${normal}" 
   read nvsk_endpoint
   if [[ (( $nvsk_endpoint =~ \-{2,} ))  ||  (( $nvsk_endpoint =~ \.{2,} )) ]]; then
    echo -e "\e[0;31m${bold}Error - Please provide the proper api endpoint${normal}"; fail=1
         else
         if ! [[ ${#nvsk_endpoint} -le 255 ]]; then
            echo -e "\e[0;31m${bold}Error - FQDN exceeding 255 characters. Please provide the proper api endpoint${normal}"; fail=1
                else
                if ! [[ $nvsk_endpoint =~ ^[^-.@_][a-z0-9i.-]{2,}\.[a-z/]{2,}$ ]]; then
                         echo -e "\e[0;31m${bold}Error - Please provide the proper api endpoint${normal}"; fail=1
                else
                        printf "nvsk_api_endpoint: $nvsk_endpoint\n" >> config_files/domain_specific_config.yml
                         break;
                 fi
         fi
   fi
   done
else
   printf "nvsk_api_endpoint: NA\n" >> config_files/domain_specific_config.yml
   break;
fi
}

rm config_files/domain_specific_config.yml
touch config_files/domain_specific_config.yml
if [[ -e "config_files/domain_specific_config.yml" ]]; then
check_access_type
check_state
check_login
check_state_id
check_data_pull_status
check_nvsk_url
fi


check_domain_config_file(){
if [[ -e "config_files/domain_specific_config.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the config file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/domain_specific_config.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube config.yml is entered. Follow Installation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the config.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
             if [[ -e "config_files/domain_specific_config.yml" ]]; then
		if [[ $yn == yes ]]; then
                                rm config_files/domain_specific_config.yml
                                touch config_files/domain_specific_config.yml
				check_access_type
				check_state
				check_login
				check_state_id
				check_data_pull_status
                                check_nvsk_url
                          	fi
             fi
           done
fi
if [[ $yn == no ]]; then
	     echo -e "\e[0;32m${bold}config file defining the domain configurations has been generated and validated successfully${normal}"

    fi
}

check_domain_config_file
