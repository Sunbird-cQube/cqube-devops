#!/bin/bash

check_studentAttendance(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable studentAttendance program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read student_Attendance
        if ! [[ $student_Attendance == "true" || $student_Attendance == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "studentAttendance: $student_Attendance\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_teacherAttendance(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable teacherAttendance program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read teacher_Attendance
        if ! [[ $teacher_Attendance == "true" || $teacher_Attendance == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "teacherAttendance: $teacher_Attendance\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_reviewMeetings(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable review_Meetings program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false. ${normal}"
read review_Meetings
        if ! [[ $review_Meetings == "true" || $review_Meetings == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "reviewMeetings: $review_Meetings\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_pgi(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable pgi program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read pg_i
        if ! [[ $pg_i == "true" || $pg_i == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "pgi: $pg_i\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_pmPoshan(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable pmPoshan program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read pm_Poshan
        if ! [[ $pm_Poshan == "true" || $pm_Poshan == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "pmPoshan: $pm_Poshan\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_udise(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable udise program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read ud_ise
        if ! [[ $ud_ise == "true" || $ud_ise == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "udise: $ud_ise\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_nas(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable nas program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read n_as
        if ! [[ $n_as == "true" || $n_as == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "nas: $n_as\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_diksha(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable diksha program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read dik_sha
        if ! [[ $dik_sha == "true" || $dik_sha == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "diksha: $dik_sha\n" >> config_files/program_selector.yml
                        break;

        fi
done
}

check_nishtha(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable nishtha program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read nish_tha
        if ! [[ $nish_tha == "true" || $nish_tha == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "nishtha: $nish_tha\n" >> config_files/program_selector.yml
                        break;

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
#check_studentAttendance
check_teacherAttendance
#check_reviewMeetings
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
				#check_studentAttendance
				check_teacherAttendance
				#check_reviewMeetings
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
