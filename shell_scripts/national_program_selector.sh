#!/bin/bash

check_microImprovement() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable microImprovement program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read micro_Improvement

if ! [[ $micro_Improvement == "true" || $micro_Improvement == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "micro_improvements_nation: $micro_Improvement\n" >> config_files/national_program_selector.yml

     if ! [[ $micro_Improvement == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for microImprovement or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private .${normal}"
           read micro_Improvement_loginStatus
             if ! [[ $micro_Improvement_loginStatus == "private" || $micro_Improvement_loginStatus == "public" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "micro_improvements_nation_loginStatus: $micro_Improvement_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "micro_improvements_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}

check_ncf() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable ncf program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read n_cf

if ! [[ $n_cf == "true" || $n_cf == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "ncf_nation: $n_cf\n" >> config_files/program_selector.yml

     if ! [[ $n_cf == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for ncf or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private .${normal}"
           read n_cf_loginStatus
             if ! [[ $n_cf_loginStatus == "private" || $n_cf_loginStatus == "public" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "ncf_nation_loginStatus: $n_cf_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "ncf_nation_loginStatus: public\n" >> config_files/program_selector.yml
          break;
     fi
fi
done
}

check_quiz() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable ncert_quiz program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read Quiz

if ! [[ $Quiz == "true" || $Quiz == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "ncert_quiz_nation: $Quiz\n" >> config_files/national_program_selector.yml

     if ! [[ $Quiz == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for pgi or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private .${normal}"
           read Quiz_loginStatus
             if ! [[ $Quiz_loginStatus == "private" || $Quiz_loginStatus == "public" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "ncert_quiz_nation_loginStatus: $Quiz_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "ncert_quiz_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}


check_nipunBharat() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable nipunBharat program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read nipun_Bharat

if ! [[ $nipun_Bharat == "true" || $nipun_Bharat == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "nipun_bharat_nation: $nipun_Bharat\n" >> config_files/national_program_selector.yml

     if ! [[ $nipun_Bharat == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for pgi or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private .${normal}"
           read nipun_Bharat_loginStatus
             if ! [[ $nipun_Bharat_loginStatus == "private" || $nipun_Bharat_loginStatus == "public" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "nipun_bharat_nation_loginStatus: $nipun_Bharat_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "nipun_bharat_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}

check_udise() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable udise program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read ud_ise

if ! [[ $ud_ise == "true" || $ud_ise == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "udise_nation: $ud_ise\n" >> config_files/national_program_selector.yml

     if ! [[ $ud_ise == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for udise or else enter public${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read ud_ise_loginStatus
             if ! [[ $ud_ise_loginStatus == "public" || $ud_ise_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "udise_nation_loginStatus: $ud_ise_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "udise_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}


check_pgi() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable pgi program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read pg_i

if ! [[ $pg_i == "true" || $pg_i == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "pgi_nation: $pg_i\n" >> config_files/national_program_selector.yml

     if ! [[ $pg_i == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for pgi or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private .${normal}"
           read pg_i_loginStatus
             if ! [[ $pg_i_loginStatus == "private" || $pg_i_loginStatus == "public" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "pgi_nation_loginStatus: $pg_i_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "pgi_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}

check_pmPoshan() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable pmPoshan program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read pm_Poshan

if ! [[ $pm_Poshan == "true" || $pm_Poshan == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "pm_poshan_nation: $pm_Poshan\n" >> config_files/national_program_selector.yml

     if ! [[ $pm_Poshan == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for pmPoshan or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read pm_Poshan_loginStatus
             if ! [[ $pm_Poshan_loginStatus == "public" || $pm_Poshan_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "pm_poshan_nation_loginStatus: $pm_Poshan_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "pm_poshan_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}

check_nas() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable nas program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read n_as

if ! [[ $n_as == "true" || $n_as == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "nas_nation: $n_as\n" >> config_files/national_program_selector.yml

     if ! [[ $n_as == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for nas or else enter public${normal}"
           echo -e "\e[0;38m${bold}please enter private or public.${normal}"
           read n_as_loginStatus
             if ! [[ $n_as_loginStatus == "public" || $n_as_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "nas_nation_loginStatus: $n_as_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "nas_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}

check_diksha() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable diksha program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read dik_sha

if ! [[ $dik_sha == "true" || $dik_sha == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "diksha_nation: $dik_sha\n" >> config_files/national_program_selector.yml

     if ! [[ $dik_sha == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for diksha or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read dik_sha_loginStatus
             if ! [[ $dik_sha_loginStatus == "public" || $dik_sha_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "diksha_nation_loginStatus: $dik_sha_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "diksha_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}

check_nishtha() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable nishtha program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read nish_tha

if ! [[ $nish_tha == "true" || $nish_tha == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "nishtha_nation: $nish_tha\n" >> config_files/national_program_selector.yml

     if ! [[ $nish_tha == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for nishtha or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read nish_tha_loginStatus
             if ! [[ $nish_tha_loginStatus == "public" || $nish_tha_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "nishtha_nation_loginStatus: $nish_tha_loginStatus\n" >> config_files/national_program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "nishtha_nation_loginStatus: public\n" >> config_files/national_program_selector.yml
          break;
     fi
fi
done
}

check_config_file(){
if [[ -e "config_files/national_program_selector.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the national_program_selector.yml file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/national_program_selector.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube national_program_selector.yml is entered. Follow Installation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the national_program_selector.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done

if [[ $yn == yes ]]; then

if [[ -e "config_files/national_program_selector.yml" ]]; then
rm config_files/national_program_selector.yml
touch config_files/national_program_selector.yml
check_microImprovement
check_ncf
check_quiz
check_nipunBharat
check_udise
check_pgi
check_pmPoshan
check_nas
check_diksha
check_nishtha
fi
fi
done
fi
if [[ $yn == no ]]; then
             echo -e "\e[0;32m${bold}national_program_selector file has been generated and validated successfully${normal}"

    fi

}


check_program_file(){
if [[ -e "config_files/national_program_selector.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the national_program_selector.yml file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/national_program_selector.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube program_selector.yml is entered. Follow Installation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the national_program_selector.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
             if [[ -e "config_files/national_program_selector.yml" ]]; then
                          if [[ $yn == yes ]]; then
                                 rm config_files/program_selector.yml
                                touch config_files/program_selector.yml
				check_microImprovement
                                check_ncf
                                check_quiz
                                check_nipunBharat
                                check_udise
				check_pgi
				check_pmPoshan
				check_nas
				check_diksha
				check_nishtha
                                
fi
             fi
           done
fi
if [[ $yn == no ]]; then
             echo -e "\e[0;32m${bold}national_program_selector file has been generated and validated successfully${normal}"

    fi

}

check_config_file
