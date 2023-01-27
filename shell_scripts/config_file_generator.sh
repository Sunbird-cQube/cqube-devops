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
echo -e "\e[0;36m${bold}Hint: AWS Access key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_acess_key ${normal}"
read aws_acess_key
    aws_key_status=0
    export AWS_ACCESS_KEY_ID=$aws_acess_key
    export AWS_SECRET_ACCESS_KEY=$2
    aws s3api list-buckets > /dev/null 2>&1
#    if [ ! $? -eq 0 ]; then
#           echo "Error - Invalid aws access or secret keys"; fail=1
        #aws_key_status=1
#       else
  printf "aws_acess_key: $aws_acess_key\n" >> config.yml
  break;
done

}

aws_access_key=$(awk ''/^aws_access_key:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)

check_aws_secret_key(){
while true
do
echo -e "\e[0;36m${bold}Hint: AWS Secret key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_secret_key ${normal}"
aws_access_key=$(awk ''/^aws_access_key:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
read aws_secret_key
    aws_key_status=0
    export AWS_ACCESS_KEY_ID=$aws_acess_key
    export AWS_SECRET_ACCESS_KEY=$aws_secret_key
    aws s3api list-buckets > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then 
	    echo -e "\e[0;31m${bold}Error - Invalid aws access or secret keys.${normal}"; fail=1
         check_aws_key
      #  aws_key_status=1
        else
  printf "aws_secret_key: $aws_secret_key\n" >> config.yml
  break;
    fi
done

}

check_aws_default_region(){
  printf "aws_default_region: ap-south-1\n" >> config.yml
}

check_processing_buc(){
while true
do
echo -e "\e[0;36m${bold}Hint: aws s3 processing bucke${normal}"
echo -e "\e[0;38m${bold}please enter the s3_processing_bucket ${normal}"
read s3_bucket_1
	
#if [[ $aws_key_status == 0 ]]; then
        bucketstatus=`aws s3api head-bucket --bucket "${s3_bucket_1}" 2>&1`
        if [ ! $? == 0 ]
        then
            echo -e "\e[0;31m${bold}Error - Bucket not owned or not found. Please enter the valid bucket name${normal}"; fail=1
	    else
	  printf "s3_processing_bucket: $s3_bucket_1\n" >> config.yml
 		 break;

        fi
done
}

check_archived_buc(){
while true
do
echo -e "\e[0;36m${bold}Hint: aws s3 archived bucket${normal}"
echo -e "\e[0;38m${bold}please enter the s3_archived_bucket ${normal}"
read s3_bucket_2

#if [[ $aws_key_status == 0 ]]; then
        bucketstatus=`aws s3api head-bucket --bucket "${s3_bucket_2}" 2>&1`
        if [ ! $? == 0 ]
        then
            echo -e "\e[0;31m${bold}Error - Bucket not owned or not found. Please enter the valid bucket name${normal}"; fail=1
            else
          printf "s3_archived_bucket: $s3_bucket_2\n" >> config.yml
                 break;

        fi
done
}

check_error_buc(){
while true
do
echo -e "\e[0;36m${bold}Hint: aws s3 error bucket${normal}"
echo -e "\e[0;38m${bold}please enter the s3_error_bucket ${normal}"
read s3_bucket_3

#if [[ $aws_key_status == 0 ]]; then
        bucketstatus=`aws s3api head-bucket --bucket "${s3_bucket_3}" 2>&1`
        if [ ! $? == 0 ]
        then
            echo -e "\e[0;31m${bold}Error - Bucket not owned or not found. Please enter the valid bucket name${normal}"; fail=1
            else
          printf "s3_error_bucket: $s3_bucket_3\n" >> config.yml
                 break;

        fi
done
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
echo -e "\e[0;36m${bold}Hint: enter domain name ( Example: cqubeprojects.com )${normal}"     
echo -e "\e[0;38m${bold}please enter the api_endpoint ${normal}"
read api_endpoint
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

         #    done

	    if [[ $yn == no ]]; then
printf "db_user: cqube_user\n" >> config.yml
printf "db_name: cqube\n" >> config.yml
printf "db_password: cQube@123\n" >> config.yml

	    fi

    }

rm config.yml
touch config.yml
if [[ -e "config.yml" ]]; then
check_base_dir
check_sys_user
check_state
check_ip
check_api_endpoint
check_aws_key
check_aws_secret_key
check_aws_default_region
check_processing_buc
check_archived_buc
check_error_buc
check_config_db
	
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
				check_api_endpoint
                                check_aws_key
                                check_aws_secret_key
                                check_aws_default_region
				check_processing_buc
				check_archived_buc
				check_error_buc
				check_config_db
                          fi
             fi
           done
fi
if [[ $yn == no ]]; then
	     echo -e "\e[0;32m${bold}config file has been generated and validated successfully${normal}"

    fi

}

check_config_file
