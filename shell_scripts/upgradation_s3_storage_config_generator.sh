#!/bin/bash

check_aws_key(){
while true
do
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
if [[ $storage_type == aws ]]; then
echo -e "\e[0;36m${bold}Hint: AWS Access key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_access_key ${normal}"
read aws_access_key
if [[ -z $aws_access_key ]]; then
echo -e "\e[0;31m${bold}Error - Invalid aws access ${normal}"; fail=1

    aws_key_status=0
    export AWS_ACCESS_KEY_ID=$aws_access_key
    export AWS_SECRET_ACCESS_KEY=$2
    aws s3api list-buckets > /dev/null 2>&1
else
  printf "aws_access_key: $aws_access_key\n" >> config_files/upgradation_aws_s3_config.yml
  break;
fi
fi
done

}

check_aws(){
while true
do
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
if [[ $storage_type == aws ]]; then
echo -e "\e[0;36m${bold}Hint: # AWS Access key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_access_key ?${normal}"
read aws_access_key_id
sed -i "/aws_access_key: /d" config_files/upgradation_aws_s3_config.yml
printf  "aws_access_key: $aws_access_key_id\n"  >> config_files/upgradation_aws_s3_config.yml
  break;
fi
done

}

check_aws_secret_key(){
while true
do
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
if [[ $storage_type == aws ]]; then
echo -e "\e[0;36m${bold}Hint: AWS Secret key for creation of s3 bucket${normal}"
echo -e "\e[0;38m${bold}please enter the aws_secret_key ${normal}"
aws_access_key=$(awk ''/^aws_access_key:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_aws_s3_config.yml)
read aws_secret_key
if [[ -z $aws_secret_key ]]; then
        echo -e "\e[0;31m${bold}Error - Invalid aws access or secret keys.${normal}"; fail=1
fi  
aws_key_status=0
    export AWS_ACCESS_KEY_ID=$aws_access_key
    export AWS_SECRET_ACCESS_KEY=$aws_secret_key
    aws s3api list-buckets > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
            echo -e "\e[0;31m${bold}Error - Invalid aws access or secret keys.${normal}"; fail=1
         check_aws
        aws_key_status=1
        else
  printf "aws_secret_key: $aws_secret_key\n" >> config_files/upgradation_aws_s3_config.yml
  break;
    fi
    fi
done

}


check_aws_default_region(){
storage_type=$(awk ''/^storage_type:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/upgradation_config.yml)
if [[ $storage_type == aws ]]; then
  printf "aws_default_region: ap-south-1\n" >> config_files/upgradation_aws_s3_config.yml
fi
}


check_archived_buc(){

while true
do

echo -e "\e[0;36m${bold}Hint: aws s3  bucket${normal}"
echo -e "\e[0;38m${bold}please enter the unique  s3 bucket name ${normal}"
read bucket_name

s3_bucket=$(cat /opt/cqube/conf/base_aws_s3_config.yml | grep s3_bucket )
old_s3_bucket=$(cut -d ":" -f2 <<< "$s3_bucket")
t=`echo $old_s3_bucket`

if [[ ! "$t" == "$bucket_name" ]]; then
    echo -e "\e[0;31m${bold}Error -  must be same as previously used bucket.${normal}"; fail=1
else
                printf "s3_bucket: $bucket_name\n" >> config_files/upgradation_aws_s3_config.yml
                break;
        fi
done

}


rm config_files/upgradation_aws_s3_config.yml
touch config_files/upgradation_aws_s3_config.yml
if [[ -e "config_files/upgradation_aws_s3_config.yml" ]]; then
check_aws_key
check_aws_secret_key
check_archived_buc
fi


check_aws_config_file(){
if [[ -e "config_files/upgradation_aws_s3_config.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the aws s3 storage config file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/upgradation_aws_s3_config.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube upgradation_aws_s3_config.yml is entered. Follow Upgradation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you edit the s3 bucket name, all data will be lost. If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the upgradation_aws_s3_config.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
             if [[ -e "config_files/upgradation_aws_s3_config.yml" ]]; then
                          if [[ $yn == yes ]]; then
		             rm config_files/upgradation_aws_s3_config.yml
                             touch config_files/upgradation_aws_s3_config.yml
                             check_aws_key
                             check_aws_secret_key
                             check_archived_buc
			   fi
	     fi
     done
fi

if [[ $yn == no ]]; then
             echo -e "\e[0;32m${bold}config file has been generated and validated successfully${normal}"

    fi
}

check_aws_config_file

