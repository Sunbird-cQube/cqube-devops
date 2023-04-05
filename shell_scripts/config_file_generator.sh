check_sys_user(){
result=`who | head -1 | awk '{print $1}'`
printf "system_user_name: $result\n" >> config_files/config.yml
}
 
check_ip()
{
        is_local_ip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | cut -d ' ' -f 2` > /dev/null 2>&1
	echo $is_local_ip > .ip
               ip=$(cut -d " " -f 2 .ip)
	printf "local_ipv4_address: $ip\n" >> config_files/config.yml
}


check_base_dir(){
        printf "base_dir: /opt\n" >> config_files/config.yml
}

check_state(){
while true
do
echo -e "\e[0;36m${bold}Hint: Please enter state code ( refer to state_list )${normal}"
        echo -e "\e[0;38m${bold}please enter the state_name ${normal} "
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
         printf "state_name: $state_name\n" >> config_files/config.yml
break;
  fi

done
}

check_api_endpoint(){
while true
do
	echo -e "\e[0;36m${bold}Hint: enter domain name if mode of installation is public, if mode of installation is localhost then enter api end point as localhost ( Example: cqubeprojects.com )${normal}"     
echo -e "\e[0;38m${bold}please enter the api_endpoint${normal}"	
read api_endpoint
mode_of_installation=$(awk ''/^mode_of_installation:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)
if [[ $mode_of_installation == localhost ]]; then
        if [[ ! $api_endpoint == "localhost" ]]; then
        echo -e "\e[0;31m${bold}Error - Please provide api_endpoint as localhost for localhost installation${normal}"; fail=1
                        else
                        printf "api_endpoint: $api_endpoint\n" >> config_files/config.yml
                        break;

        fi
fi
if [[ $mode_of_installation == public ]]; then
if [[ (( $api_endpoint =~ \-{2,} ))  ||  (( $api_endpoint =~ \.{2,} )) ]]; then
    echo -e "\e[0;31m${bold}Error - Please provide the proper api endpoint${normal}"; fail=1
         else
         if ! [[ ${#api_endpoint} -le 255 ]]; then
            echo -e "\e[0;31m${bold}Error - FQDN exceeding 255 characters. Please provide the proper api endpoint${normal}"; fail=1
                else
                if ! [[ $api_endpoint =~ ^[^-.@_][a-z0-9i.-]{2,}\.[a-z/]{2,}$ ]]; then
                         echo -e "\e[0;31m${bold}Error - Please provide the proper api endpoint${normal}"; fail=1
                else
                        printf "api_endpoint: $api_endpoint\n" >> config_files/config.yml
                         break;
                 fi
         fi
fi
fi
done
}

check_length(){
    len_status=1
    str_length=${#1}
    if [[ $str_length -ge 3 && $str_length -le 63 ]]; then
        len_status=0
        return $len_status;
    else
        return $len_status;
    fi
}


check_db_user(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own username for the cQube database, numbers are not allowed, Provide the length between 3 and 63${normal}"
echo -e "\e[0;38m${bold}please enter the db_user ${normal} "
read dbuser
    if [[ ! $dbuser =~ ^[A-Za-z_]*[^_0-9\$\@\#\%\*\-\^\?]$ ]]; then
        echo -e "\e[0;31m${bold}Error: db_user should not contain numbers, Please enter alphabets as db_user ${normal}"; fail=1
   else
check_length $dbuser
if ! [[ $? == 0 ]]; then
    echo -e "\e[0;31m${bold}Error - Length of the value db_user is not correct. Provide the length between 3 and 63.${normal}"; fail=1
else
    printf "db_user: $dbuser\n" >> config_files/config.yml
    break;
    fi
fi

done

}

check_db_name(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own database name for the cQube database, numbers are not allowed, Provide the length between 3 and 63${normal}"
echo -e "\e[0;38m${bold}please enter the db_name ${normal}"
read dbname
    if [[ ! $dbname =~ ^[A-Za-z_]*[^_0-9\$\@\#\%\*\-\^\?]$ ]]; then
        echo -e "\e[0;31m${bold}Error - Naming convention is not correct. Please change the value of db_name.${normal}"; fail=1
   else
check_length $dbname
if ! [[ $? == 0 ]]; then
    echo -e "\e[0;31m${bold}Error - Length of the value db_name is not correct. Provide the length between 3 and 63.${normal}"; fail=1
else
    printf "db_name: $dbname\n" >> config_files/config.yml
    break;
    fi
fi

done

}

check_db_password(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own password to for the cQube database, password should contain atleast 1 lower,upper,number,special character (only @!%^*? allowed) and minimum 8 characters${normal}"     
echo -e "\e[0;38m${bold}please enter the db_password ${normal}"
read dbpass

    len="${#dbpass}"
   # if [[ $len -ge 8 ]]; then
        echo "$dbpass" | grep "[A-Z]" | grep "[a-z]" | grep "[0-9]" | grep "[@%^*!?]" > /dev/null 2>&1
        if [[ ! $? -eq 0 ]]; then
            echo -e "\e[0;31m${bold}Error - db_password should contain atleast one uppercase, one lowercase, one special character and one number. And should be minimum of 8 characters.${normal}"; fail=1

    else
            len="${#dbpass}"
            if ! [[ $len -ge 8 ]]; then
                echo -e "\e[0;31m${bold}Error - db_password should contain atleast one uppercase, one lowercase, one special character and one number. And should be minimum of 8 characters.${normal}"; fail=1
        else
 printf "db_password: $dbpass\n" >> config_files/config.yml
break;
    fi
    fi
done
}
check_keycloak_password(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own password to for the cQube keycloak_adm_password , password should contain atleast 1 lower,upper,number,special character (only @!%^*? allowed) and minimum 8 characters${normal}"     
echo -e "\e[0;38m${bold}please enter the keycloak_password ${normal}"
read keycloakpass

    len="${#keycloakpass}"
   # if [[ $len -ge 8 ]]; then
        echo "$keycloakpass" | grep "[A-Z]" | grep "[a-z]" | grep "[0-9]" | grep "[@%^*!?]" > /dev/null 2>&1
        if [[ ! $? -eq 0 ]]; then
            echo -e "\e[0;31m${bold}Error - keycloak_password should contain atleast one uppercase, one lowercase, one special character and one number. And should be minimum of 8 characters.${normal}"; fail=1

    else
            len="${#keycloakpass}"
            if ! [[ $len -ge 8 ]]; then
                echo -e "\e[0;31m${bold}Error - keycloak_password should contain atleast one uppercase, one lowercase, one special character and one number. And should be minimum of 8 characters.${normal}"; fail=1
        else
 printf "keycloak_adm_password: $keycloakpass\n" >> config_files/config.yml
break;
    fi
    fi
done
}

check_keycloak_name(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own keycloak admin name for the cQube , numbers are not allowed, Provide the length between 3 and 63${normal}"
echo -e "\e[0;38m${bold}please enter the keycloak_adm_name ${normal}"
read keycloakname
    if [[ ! $keycloakname =~ ^[A-Za-z_]*[^_0-9\$\@\#\%\*\-\^\?]$ ]]; then
        echo -e "\e[0;31m${bold}Error - Naming convention is not correct. Please change the value.${normal}"; fail=1
   else
check_length $keycloakname
if ! [[ $? == 0 ]]; then
    echo -e "\e[0;31m${bold}Error - Length of the value keycloak_admin_name is not correct. Provide the length between 3 and 63.${normal}"; fail=1
else
    printf "keycloak_adm_name: $keycloakname\n" >> config_files/config.yml
    break;
    fi
fi

done

}

check_mode_of_installation(){
while true
do
echo -e "\e[0;36m${bold}Hint: Please enter the mode of installation as public or localhost${normal}"
echo -e "\e[0;38m${bold}please enter the mode of installation ${normal}"
read installation_mode
if ! [[ $installation_mode == "localhost" || $installation_mode == "public" ]]; then
    echo "\e[0;31m${bold}Error - Please enter either localhost or public.${normal}"; fail=1
    else
    printf "mode_of_installation: $installation_mode\n" >> config_files/config.yml
    break;
fi
done
}

check_storage_type(){
while true
do
if  [[ $installation_mode == "public" ]]; then
    echo -e "\e[0;36m${bold}Hint: enter aws or azure or local if mode of installation is public${normal}"     
    echo -e "\e[0;38m${bold}please enter the storage_type${normal}"
    read storage_typ
      if ! [[ $storage_typ == "aws" || $storage_typ == "azure" || $storage_typ == "local" ]]; then
         echo -e "\e[0;31m${bold}Error - Please enter either aws or local or azure"; fail=1
      else
        printf "storage_type: $storage_typ\n" >> config_files/config.yml
        break;
      fi
else
    echo -e "\e[0;36m${bold}Hint: enter storage type as local if mode of installation is localhost${normal}"     
    echo -e "\e[0;38m${bold}please enter the storage_type${normal}"
    read storage_typ
      if ! [[ $storage_typ == "local" ]]; then
         echo -e "\e[0;31m${bold}Error - Please enter either aws or local or azure"; fail=1
      else
        printf "storage_type: $storage_typ\n" >> config_files/config.yml
        break;
      fi
fi
done
}

check_google_analytics(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter Google Analytics Tracking ID ${normal}"
echo -e "\e[0;38m${bold}please enter the Google Analytics Tracking ID or NA (not applicable) ${normal}"
read google_analytics
        printf "google_analytics_tracking_id: $google_analytics\n" >> config_files/config.yml
        break;
done

}

check_adapter_scheduling_syntax(){

while true
do
echo -e "\e[0;36m${bold}Hint: Enter cron syntax  to run the adapter scheduling${normal}"
echo -e "\e[0;38m${bold}please enter the cron syntax eg if you want to run at 11am this is syntax (0 0 11 * * ?)${normal}"
read cron
   #crontab -l > test_cron
   #echo "$cron /test" > test_cron
   #crontab test_cron
   if [ $? = 1 ]; then
     echo -e "\e[0;31m${bold}Error- echo please check cron syntax${normal}"; fail=1
else
        printf "adapter_scheduler_time: $cron\n" >> config_files/config.yml
        break;

    fi
done
}

check_cron_plugin_syntax(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter cron syntax  to run the nifi plugins${normal}"
echo -e "\e[0;38m${bold}please enter the cron syntax eg if you want to run at 12pm this is syntax (0 0 12 * * ?)${normal}"
read cron
   #crontab -l > test_cron
   #echo "$cron /test" > test_cron
   #crontab test_cron
   if [ $? = 1 ]; then
     echo -e "\e[0;31m${bold}Error- echo please check cron syntax${normal}"; fail=1
else
	printf "plugin_time: $cron\n" >> config_files/config.yml
        break;

    fi
done
}

check_cron_processing_syntax(){

while true
do
echo -e "\e[0;36m${bold}Hint: Enter cron syntax  to run the nifi processing files${normal}"
echo -e "\e[0;38m${bold}please enter the cron syntax eg if you want to run at 12pm this is syntax (0 0 12 * * ?)${normal}"
read cron
   #crontab -l > test_cron
   #echo "$cron /test" > test_cron
   #crontab test_cron
   if [ $? = 1 ]; then
     echo -e "\e[0;31m${bold}Error- echo please check cron syntax${normal}"; fail=1
else
        printf "processing_time: $cron\n" >> config_files/config.yml
        break;

    fi
done
}


check_read_only_db_user(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own username for the cQube read_only_database,Provide the length between 3 and 63${normal}"
echo -e "\e[0;38m${bold}please enter the read_only_db_user?${normal} "
read read_only_dbuser
    if [[ ! $read_only_dbuser =~ ^[A-Za-z_]*[^_0-9\$\@\#\%\*\-\^\?]$ ]]; then
        echo -e "\e[0;31m${bold}Error - Naming convention is not correct. Please change the value of read_only_db_user.${normal}"; fail=1
   else
check_length $read_only_dbuser
if ! [[ $? == 0 ]]; then
    echo -e "\e[0;31m${bold}Error - The length of the value read_only_db_user should be between 3 and 63.${normal}"; fail=1
else
    printf "read_only_db_user: $read_only_dbuser\n" >> config_files/config.yml
    break;
    fi
fi

done

}

check_read_only_db_password(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own password to for the cQube read_only_database, password should contain atleast 1 lower,upper,number,special character (only @!%^*? allowed) and minimum 8 characters${normal}"
echo -e "\e[0;38m${bold}please enter the read_only_db_password${normal}"
read read_only_dbpass

    len="${#read_only_dbpass}"
   # if [[ $len -ge 8 ]]; then
        echo "$read_only_dbpass" | grep "[A-Z]" | grep "[a-z]" | grep "[0-9]" | grep "[@%^*!?]" > /dev/null 2>&1
        if [[ ! $? -eq 0 ]]; then
            echo -e "\e[0;31m${bold}Error - read_only_db_password should contain atleast one uppercase, one lowercase, one special character and one number. And should be minimum of 8 characters.${normal}"; fail=1

    else
            len="${#read_only_dbpass}"
            if ! [[ $len -ge 8 ]]; then
                echo -e "\e[0;31m${bold}Error - read_only_db_password should contain atleast one uppercase, one lowercase, one special character and one number. And should be minimum of 8 characters.${normal}"; fail=1
        else
 printf "read_only_db_password: $read_only_dbpass\n" >> config_files/config.yml
break;
    fi
    fi
done
}


check_config_db(){
        #while true; do
echo -e "\e[0;33m${bold}Currently cQube having default database credentiable with db_name , db_user and db_password  Follow Installation process with below config values.${normal}"
echo -e "\e[0;38m${bold} db_user: cqube_user ${normal}"
echo -e "\e[0;38m${bold} db_name: cqube ${normal}"
echo -e "\e[0;38m${bold} db_password: cQube@123 ${normal}"
echo -e "\e[0;33m${bold}If you want to edit database credentials please enter yes, and if you want to follow the Installation process with above value please enter no .${normal}"
            while true; do

             read -p "Do you still want to edit the database credentials (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done

	    if [[ $yn == yes ]]; then
                                check_db_user
                                check_db_name
                                check_db_password
                          fi

	    if [[ $yn == no ]]; then
printf "db_user: cqube_user\n" >> config_files/config.yml
printf "db_name: cqube\n" >> config_files/config.yml
printf "db_password: cQube@123\n" >> config_files/config.yml

	    fi

    }

check_config_read_only_db(){
        #while true; do
echo -e "\e[0;33m${bold}Currently cQube having default database credentiable with read_only_db_user and read_only_db_password. Follow Installation process with below config values.${normal}"
echo -e "\e[0;38m${bold} read_only_db_user: cqube_db_user ${normal}"
echo -e "\e[0;38m${bold} read_only_db_password: cQube@123 ${normal}"
echo -e "\e[0;33m${bold}If you want to edit database credentials please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the read only database credentials (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done

            if [[ $yn == yes ]]; then
                                check_read_only_db_user
                                check_read_only_db_password
                          fi

         #    done

            if [[ $yn == no ]]; then
printf "read_only_db_user: cqube_db_user\n" >> config_files/config.yml
printf "read_only_db_password: cQube@123\n" >> config_files/config.yml
            fi

    }

rm config_files/config.yml
touch config_files/config.yml
if [[ -e "config_files/config.yml" ]]; then
check_base_dir
check_sys_user
check_state
check_ip
check_mode_of_installation
check_storage_type
check_api_endpoint
check_google_analytics
check_adapter_scheduling_syntax
check_cron_plugin_syntax
check_cron_processing_syntax
check_config_db
check_config_read_only_db
check_keycloak_name
check_keycloak_password
fi

check_config_file(){
if [[ -e "config_files/config.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the config file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/config.yml` ${normal}"
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
             if [[ -e "config_files/config.yml" ]]; then
                          if [[ $yn == yes ]]; then
                                rm config_files/config.yml
                                touch config_files/config.yml
				check_base_dir
				check_sys_user
				check_state
				check_ip
				check_mode_of_installation
				check_storage_type
				check_api_endpoint
				check_google_analytics
				check_adapter_scheduling_syntax
				check_cron_plugin_syntax
				check_cron_processing_syntax
				check_config_db
				check_config_read_only_db
				check_keycloak_name
				check_keycloak_password
                          	fi
             fi
           done
fi
if [[ $yn == no ]]; then
	     echo -e "\e[0;32m${bold}config file has been generated and validated successfully${normal}"

    fi
}

check_config_file
