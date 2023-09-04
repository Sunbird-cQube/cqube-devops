#!/bin/bash

check_teacherAttendance() {
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable teacherAttendance program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read teacher_Attendance

if ! [[ $teacher_Attendance == "true" || $teacher_Attendance == "false" ]]; then
     echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
else
     printf "sch_att_state: $teacher_Attendance\n" >> config_files/program_selector.yml

     if ! [[ $teacher_Attendance == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for teacher attandance or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read teacher_Attendance_loginStatus
             if ! [[ $teacher_Attendance_loginStatus == "public" || $teacher_Attendance_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "sch_att_state_loginStatus: $teacher_Attendance_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "sch_att_state_loginStatus: public\n" >> config_files/program_selector.yml
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
     printf "pgi_state: $pg_i\n" >> config_files/program_selector.yml

     if ! [[ $pg_i == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for pgi or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private .${normal}"
           read pg_i_loginStatus
             if ! [[ $pg_i_loginStatus == "private" || $pg_i_loginStatus == "public" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "pgi_state_loginStatus: $pg_i_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "pgi_state_loginStatus: public\n" >> config_files/program_selector.yml
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
     printf "pm_poshan_state: $pm_Poshan\n" >> config_files/program_selector.yml

     if ! [[ $pm_Poshan == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for pmPoshan or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read pm_Poshan_loginStatus
             if ! [[ $pm_Poshan_loginStatus == "public" || $pm_Poshan_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "pm_poshan_state_loginStatus: $pm_Poshan_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "pm_poshan_state_loginStatus: public\n" >> config_files/program_selector.yml
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
     printf "udise_state: $ud_ise\n" >> config_files/program_selector.yml

     if ! [[ $ud_ise == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for udise or else enter public${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read ud_ise_loginStatus
             if ! [[ $ud_ise_loginStatus == "public" || $ud_ise_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "udise_state_loginStatus: $ud_ise_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "udise_state_loginStatus: public\n" >> config_files/program_selector.yml
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
     printf "nas_state: $n_as\n" >> config_files/program_selector.yml

     if ! [[ $n_as == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for nas or else enter public${normal}"
           echo -e "\e[0;38m${bold}please enter private or public.${normal}"
           read n_as_loginStatus
             if ! [[ $n_as_loginStatus == "public" || $n_as_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "nas_state_loginStatus: $n_as_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "nas_state_loginStatus: public\n" >> config_files/program_selector.yml
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
     printf "diksha_state: $dik_sha\n" >> config_files/program_selector.yml

     if ! [[ $dik_sha == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for diksha or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read dik_sha_loginStatus
             if ! [[ $dik_sha_loginStatus == "public" || $dik_sha_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "diksha_state_loginStatus: $dik_sha_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "diksha_state_loginStatus: public\n" >> config_files/program_selector.yml
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
     printf "nishtha_state: $nish_tha\n" >> config_files/program_selector.yml

     if ! [[ $nish_tha == "false" ]]; then
           while true
           do
           echo -e "\e[0;36m${bold}Hint: enter private if u need a login screen for nishtha or else enter public ${normal}"
           echo -e "\e[0;38m${bold}please enter public or private.${normal}"
           read nish_tha_loginStatus
             if ! [[ $nish_tha_loginStatus == "public" || $nish_tha_loginStatus == "private" ]]; then
                   echo -e "\e[0;31m${bold}Error - Please enter either public or private ${normal}"; fail=1
             else
                   printf "nishtha_state_loginStatus: $nish_tha_loginStatus\n" >> config_files/program_selector.yml
                   break;
             fi
             done
             break;
     else
          printf "nishtha_state_loginStatus: public\n" >> config_files/program_selector.yml
          break;
     fi
fi
done
}

check_config_file(){
if [[ -e "config_files/program_selector.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the program_selector.yml file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/program_selector.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube program_selector.yml is entered. Follow Installation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the program_selector.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done

if [[ $yn == yes ]]; then

if [[ -e "config_files/program_selector.yml" ]]; then
rm config_files/program_selector.yml
touch config_files/program_selector.yml
check_teacherAttendance
check_pgi
check_pmPoshan
check_udise
check_nas
check_diksha
check_nishtha

fi
fi
done
fi
if [[ $yn == no ]]; then
             echo -e "\e[0;32m${bold}program_selector file has been generated and validated successfully${normal}"

    fi

}


check_program_file(){
if [[ -e "config_files/program_selector.yml" ]]; then
        while true; do
echo -e "\e[0;33m${bold}please preview the program_selector.yml file and confirm if everything is correct.${normal}"
echo -e "\e[0;38m${bold} `cat config_files/program_selector.yml` ${normal}"
echo -e "\e[0;33m${bold}Currently cQube program_selector.yml is entered. Follow Installation process with above config values.${normal}"
echo -e "\e[0;33m${bold}If you want to edit config value please enter yes.${normal}"
            while true; do

             read -p "Do you still want to edit the program_selector.yml file (yes/no)? " yn
             case $yn in
                 yes) break;;
                 no) break 2;;
                 * ) echo "Please answer yes or no.";;
            esac
            done
             if [[ -e "config_files/program_selector.yml" ]]; then
                          if [[ $yn == yes ]]; then
                                 rm config_files/program_selector.yml
                                touch config_files/program_selector.yml
				check_teacherAttendance
				check_pgi
				check_pmPoshan
				check_udise
				check_nas
				check_diksha
				check_nishtha
                                
fi
             fi
           done
fi
if [[ $yn == no ]]; then
             echo -e "\e[0;32m${bold}program_selector file has been generated and validated successfully${normal}"

    fi

}

check_config_file
