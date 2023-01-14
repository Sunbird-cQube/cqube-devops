#!/bin/bash

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
check_sys_user(){
while true
do
echo -e "\e[0;36m${bold}Hint: Type who in the terminal to get the system username${normal}"
echo -e "\e[0;38m${bold}please enter the system_user_name:${normal}"
read username
result=`who | head -1 | awk '{print $1}'`
if [[ `egrep -i ^$username: /etc/passwd ; echo $?` != 0 && $result != $username ]]; then
  echo -e "\e[0;31m${bold}Error - Please check the system_user_name.${normal}"; fail=1
else
  printf "system_user_name: $username\n" >> config.yml
  break;
fi
done
}

check_db_user(){
while true
do
echo -e "\e[0;36m${bold}Hint: Create your own username for the cQube database user should not contain any numbers, Provide the length between 3 and 63${normal}"	
echo -e "\e[0;38m${bold}please enter the db_user:${normal} "
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
echo -e "\e[0;36m${bold}Hint: Create your own database name for the cQube database name should not contain any numbers, Provide the length between 3 and 63${normal}"     
echo -e "\e[0;38m${bold}please enter the db_name:${normal}"
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
echo -e "\e[0;38m${bold}please enter the db_password:${normal}"
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


check_ip(){
while true
do
echo -e "\e[0;36m${bold}Hint: enter the private ip of this server. To find the ip address. Use ip addr or ifconfig,${normal}"
echo -e "\e[0;38m${bold}please enter the local_ipv4_address:${normal}"
read local_ipv4
local ip=$local_ipv4
    ip_stat=1
    ip_pass=0
if ! [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($local_ipv4)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]

           echo -e "\e[0;31m${bold}Error - Invalid value for private ip${normal}"; fail=1
                   ip_stat=$?
        if [[ ! $ip_stat == 0 ]]; then
            echo -e "\e[0;31m${bold}Error - Invalid value for private_ip${normal} "; fail=1
            ip_pass=0
        fi
	else
              ip_pass=0
              is_local_ip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | cut -d ' ' -f 2`
                if  [[ $ip_pass = 0 &&  $is_local_ip != *$ip* ]]; then
                echo -e "\e[0;31m${bold}Error - Invalid value for private ip. Please enter the local ip of this system.${normal} "; fail=1
                                else
                                printf "local_ipv4_address: $local_ipv4\n" >> config.yml
                                break;
                  fi
fi
done
}

check_proxy_ip()
{
while true
do
echo -e "\e[0;36m${bold}Hint: enter the public ip of ngnix server, please enter for localhost installation please enter 127.0.0.1 ,To find the ip address. Use ip addr or ifconfig${normal}"
echo -e "\e[0;38m${bold}please enter the public ngnix ip:${normal} "
read proxy_ip
    local ip=$proxy_ip
    ip_stat=1
    ip_pass=0
    if ! [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        echo -e "\e[0;31m${bold}Error - Invalid value for proxy_host${normal} "; fail=1
                else
                printf "proxy_ip: $proxy_ip\n" >> config.yml
                break;
    fi

done
}

check_api_endpoint(){
while true
do
echo -e "\e[0;36m${bold}Hint: enter domain name ( Example: cqubeprojects.com )${normal}"     
echo -e "\e[0;38m${bold}please enter the api_endpoint:${normal}"
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

rm config.yml
touch config.yml
if [[ -e "config.yml" ]]; then
check_sys_user
check_db_user
check_db_name
check_db_password
check_ip
check_proxy_ip
check_api_endpoint
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
                          if [[ $yn == yes ]]; then
                                 rm config.yml
                                touch config.yml
				check_sys_user
                                check_db_user
                                check_db_name
                                check_db_password
                                check_ip
                                check_proxy_ip
                                check_api_endpoint
			  fi
	     
     	   done	
fi    
     if [[ $yn == no ]]; then
	     echo -e "\e[0;32m${bold}config file has been generated and validated successfully${normal}"

    fi

}

check_config_file
