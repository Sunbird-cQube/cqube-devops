check_sys_user(){
result=`who | head -1 | awk '{print $1}'`
  printf "system_user_name: $result\n" >> config.yml

}
 
check_ip()
{
        is_local_ip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | cut -d ' ' -f 2` > /dev/null 2>&1
	echo $is_local_ip > .ip
               ip=$(cut -d " " -f 2 .ip)
	printf "local_ipv4_address: $ip\n" >> config.yml

}


check_aws_key(){
while true
do
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
if [[ $storage_type == aws ]]; then	
echo -e "\e[0;36m${bold}Hint: AWS Access key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_access_key ${normal}"
read aws_access_key
    aws_key_status=0
    export AWS_ACCESS_KEY_ID=$aws_access_key
    export AWS_SECRET_ACCESS_KEY=$2
    aws s3api list-buckets > /dev/null 2>&1
  printf "aws_access_key: $aws_access_key\n" >> config.yml
  break;
fi
done

}

check_aws(){
while true
do
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
if [[ $storage_type == aws ]]; then
echo -e "\e[0;36m${bold}Hint: # AWS Access key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_access_key ?${normal}"
read aws_access_key_id
sed -i "/aws_access_key: /d" config.yml
printf  "aws_access_key: $aws_access_key_id\n"  >> config.yml
  break;
fi
done

}

check_aws_secret_key(){
while true
do
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
if [[ $storage_type == aws ]]; then
echo -e "\e[0;36m${bold}Hint: AWS Secret key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_secret_key ${normal}"
aws_access_key=$(awk ''/^aws_access_key:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
read aws_secret_key
    aws_key_status=0
    export AWS_ACCESS_KEY_ID=$aws_access_key
    export AWS_SECRET_ACCESS_KEY=$aws_secret_key
    aws s3api list-buckets > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then 
	    echo -e "\e[0;31m${bold}Error - Invalid aws access or secret keys.${normal}"; fail=1
         check_aws
        aws_key_status=1
        else
  printf "aws_secret_key: $aws_secret_key\n" >> config.yml
  break;
    fi
    fi
done

}

check_aws_default_region(){
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
if [[ $storage_type == aws ]]; then	
  printf "aws_default_region: ap-south-1\n" >> config.yml
fi
}


check_archived_buc(){
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
        if [[ $storage_type == aws ]]; then
aws_access_key_id=$(awk ''/^aws_access_key:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
aws_secret_access_key=$(awk ''/^aws_secret_key:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)

aws configure set aws_access_key_id $aws_access_key_id
aws configure set aws_secret_access_key $aws_secret_access_key
aws configure set region ap-south-1
aws s3api create-bucket --bucket s3_cqube_edu --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1 2>&1
        if [ $? == 0 ]
                then
        printf "s3_bucket: s3-cqube-edu\n" >> config.yml
else
while true
do
echo -e "\e[0;36m${bold}Hint: Default created s3 bucket name is alredy exist so enter the unique aws s3 bucket name${normal}"
echo -e "\e[0;38m${bold}please enter the s3_archived_bucket ${normal}"
read s3_bucket_2

aws s3api create-bucket --bucket $s3_bucket_2 --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1 2>&1
if [ ! $? == 0 ]
        then
echo -e "\e[0;31m${bold}Error - Bucket already exist. Please enter the unique bucket name${normal}"; fail=1
else
                printf "s3_bucket: $s3_bucket_2\n" >> config.yml
break;
        fi

done
        fi
        fi
}


check_base_dir(){
        printf "base_dir: /opt\n" >> config.yml
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
done < state_codes
  if [[ $state_found == 0 ]] ; then
    echo -e "\e[0;31m${bold}Error - Invalid State code. Please refer the state_list file and enter the correct value.${normal}"; fail=1
else
         printf "state_name: $state_name\n" >> config.yml
break;
  fi

done
}

check_api_endpoint(){
while true
do
	echo -e "\e[0;36m${bold}Hint: enter domain name if storage_type is local the api_end_point should be localhost, if storage_type is aws apli_end_point should be domain name ( Example: cqubeprojects.com )${normal}"     
echo -e "\e[0;38m${bold}please enter the api_endpoint?${normal}"
read api_endpoint
mode_of_installation=$(awk ''/^mode_of_installation:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
if [[ $mode_of_installation == localhost ]]; then
        if [[ ! $api_endpoint == "localhost" ]]; then
        echo -e "\e[0;31m${bold}Error - Please provide api_endpoint as localhost for localhost installation${normal}"; fail=1
                        else
                        printf "api_endpoint: $api_endpoint\n" >> config.yml
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
                        printf "api_endpoint: $api_endpoint\n" >> config.yml
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
        echo -e "\e[0;31m${bold}Error - Naming convention is not correct. Please change the value of db_user.${normal}"; fail=1
   else
check_length $dbuser
if ! [[ $? == 0 ]]; then
    echo -e "\e[0;31m${bold}Error - Length of the value db_user is not correct. Provide the length between 3 and 63.${normal}"; fail=1
else
    printf "db_user: $dbuser\n" >> config.yml
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
    printf "db_name: $dbname\n" >> config.yml
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
 printf "db_password: $dbpass\n" >> config.yml
break;
    fi
    fi
done
}

check_mode_of_installation(){
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
if [[ $storage_type == aws ]]; then
        printf "mode_of_installation: public\n" >> config.yml
fi
if [[ $storage_type == "local" ]]; then
        printf "mode_of_installation: localhost\n" >> config.yml
    fi
if [[ $storage_type == "azure" ]]; then
        printf "mode_of_installation: public\n" >> config.yml
    fi
}

check_storage_type(){

while true
do
echo -e "\e[0;36m${bold}Hint: enter aws or local${normal}"     
echo -e "\e[0;38m${bold}please enter the storage_type${normal}"
read storage_typ

    if ! [[ $storage_typ == "aws" || $storage_typ == "local" || $storage_typ == "azure" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either aws or local azure"; fail=1
else
        printf "storage_type: $storage_typ\n" >> config.yml
        break;
        fi
done

}

check_google_analytics(){

while true
do
echo -e "\e[0;36m${bold}Hint: Enter Google Analytics Property ID ${normal}"
echo -e "\e[0;38m${bold}please enter the Google Analytics Property ID or NA (not applicable) ${normal}"
read google_analytics
        printf "google_analytics_property_id: $google_analytics\n" >> config.yml
        break;
done

}

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
         printf "azure_connection_string: $az_connection_string\n" >> config.yml
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
    printf "azure_account_key: $az_key\n" >> config.yml
        break;

done
}
check_az_container_key(){

while true
do
echo -e "\e[0;36m${bold}Hint: Enter Azure account key ${normal}"
echo -e "\e[0;38m${bold}please enter the azure account key${normal}"
read az_con_key
sed -i "/azure_account_key: /d" config.yml
printf  "azure_account_key: $az_con_key\n"  >> config.yml
  break;
done

}


check_az_storage_account_name(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter Azure account name ${normal}"
echo -e "\e[0;38m${bold}please enter the azure account name${normal}"
read az_name
azure_account_key=$(awk ''/^azure_account_key:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
    az_account_status=0

    az storage container list --account-key $azure_account_key --account-name $az_name > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
           echo -e "\e[0;31m${bold}Error - Invalid az account name${normal}"; fail=1
    check_az_container_key
    #az_account_status=1
else
        printf "azure_container_name: $az_name\n" >> config.yml
        break;

    fi
done
}

check_az_archived_container(){
azure_connection_string=$(awk ''/^azure_connection_string:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)

if [[ $storage_type == azure ]]; then
export AZURE_STORAGE_CONNECTION_STRING="$azure_connection_string"
if az storage container create --name azure-cqube-edu --connection-string "$azure_connection_string" --output table | grep -q "True"; then

        printf "azure_container: azure-cqube-edu\n" >> config.yml

else

while true
do
echo -e "\e[0;36m${bold}Hint: Default creating azure container is already exist so Enter unique Azure blob container name ${normal}"
echo -e "\e[0;38m${bold}please enter the azure archived blob container${normal}"
read az_archived_container
az_container_status=0
  export AZURE_STORAGE_CONNECTION_STRING="$azure_connection_string"
azure_connection_string=$(awk ''/^azure_connection_string:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
if az storage container create --name $az_archived_container --connection-string "$azure_connection_string" --output table | grep -q "False"; then
            echo -e "\e[0;31m${bold}Error - Container alredy exit Please change the container name ${normal}"; fail=1

        else
                printf "azure_container: $az_archived_container\n" >> config.yml
                break;
    fi

done
fi
fi
}

check_minio_archive_buc(){
       storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
       if [[ $storage_type == local ]]; then

                printf "minio_bucket: minio-cqube-edu\n" >> config.yml
        fi
}

check_docker_host(){
dk_ip=`docker inspect cqube_minio | grep IPAddress | cut -d '"' -f 4`

        echo $dk_ip > .dk_ip
                ip=$(cut -d " " -f 1 .dk_ip)

        printf "docker_host: $ip\n" >> config.yml
}

check_base_dir(){
        printf "base_dir: /opt\n" >> config.yml
}


check_minio_username(){
       storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
       if [[ $storage_type == local ]]; then

                printf "minio_username: minioadmin\n" >> config.yml
        fi
}

check_minio_password(){
       storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
       if [[ $storage_type == local ]]; then

                printf "minio_password: minioadmin\n" >> config.yml
        fi
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
    echo -e "\e[0;31m${bold}Error - Length of the value read_only_db_user is not correct. Provide the length between 3 and 63.${normal}"; fail=1
else
    printf "read_only_user: $read_only_dbuser\n" >> config.yml
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
 printf "read_only_password: $read_only_dbpass\n" >> config.yml
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
printf "db_user: cqube_user\n" >> config.yml
printf "db_name: cqube\n" >> config.yml
printf "db_password: cQube@123\n" >> config.yml

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
printf "read_only_db_user: cqube_db_user\n" >> config.yml
printf "read_only_db_password: cQube@123\n" >> config.yml
            fi

    }
rm config.yml
touch config.yml
if [[ -e "config.yml" ]]; then
check_base_dir
check_sys_user
check_state
check_ip
check_docker_host
check_storage_type
check_mode_of_installation
check_api_endpoint
if [[ $storage_type == local ]]; then
check_minio_username
check_minio_password
check_minio_archive_buc
fi
if [[ $storage_type == aws ]]; then
check_aws_key
check_aws_secret_key
check_archived_buc
fi
if [[ $storage_type == azure ]]; then
check_az_storage_connection_string
check_az_key
check_az_storage_account_name
check_az_archived_container
fi
check_google_analytics
check_config_db
check_config_read_only_db
fi

check_config_file(){
if [[ -e "config.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the config file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config.yml` ${normal}"
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
             if [[ -e "config.yml" ]]; then
                          if [[ $yn == yes ]]; then
                                 rm config.yml
                                touch config.yml
				check_base_dir
				check_sys_user
				check_state
				check_ip
				check_docker_host
				check_storage_type
				check_mode_of_installation
				check_api_endpoint
				if [[ $storage_type == local ]]; then
				check_minio_username
				check_minio_password
				check_minio_archive_buc
				fi
				if [[ $storage_type == aws ]]; then
				check_aws_key
				check_aws_secret_key
				check_archived_buc
				fi
				if [[ $storage_type == azure ]]; then
				check_az_storage_connection_string
				check_az_key
				check_az_storage_account_name
				check_az_archived_container
				fi
				check_google_analytics
				check_config_db
				check_config_read_only_db
                          	fi
             fi
           done
fi
if [[ $yn == no ]]; then
	     echo -e "\e[0;32m${bold}config file has been generated and validated successfully${normal}"

    fi

}

check_config_file

