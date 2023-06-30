#!/bin/bash

check_microImprovements(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable microImprovements program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read micro_Improvements
        if ! [[ $micro_Improvements == "true" || $micro_Improvements == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "microImprovements: $micro_Improvements\n" >> config_files/national_program_selector.yml
                        break;

        fi
done
}

check_ncf(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable ncf program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read n_cf
        if ! [[ $n_cf == "true" || $n_cf == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "ncf: $n_cf\n" >> config_files/national_program_selector.yml
                        break;

        fi
done
}

check_ncertQuiz(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable ncertQuiz program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read ncert_Quiz
        if ! [[ $ncert_Quiz == "true" || $ncert_Quiz == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "ncertQuiz: $ncert_Quiz\n" >> config_files/national_program_selector.yml
                        break;

        fi
done
}

check_nipunBharat(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable nipunBharat program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read nipun_Bharat
        if ! [[ $nipun_Bharat == "true" || $nipun_Bharat == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "nipunBharat: $nipun_Bharat\n" >> config_files/national_program_selector.yml
                        break;

        fi
done
}

check_udise_plus(){
while true
do
echo -e "\e[0;36m${bold}Hint: Enter true or false to enable udise+ program ${normal}"
echo -e "\e[0;38m${bold}please enter true or false.${normal}"
read udise_plus
        if ! [[ $udise_plus == "true" || $udise_plus == "false" ]]; then
        echo -e "\e[0;31m${bold}Error - Please enter either true or false ${normal}"; fail=1
                        else
                        printf "udise+: $udise_plus\n" >> config_files/national_program_selector.yml
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
                        printf "pgi: $pg_i\n" >> config_files/national_program_selector.yml
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
                        printf "pmPoshan: $pm_Poshan\n" >> config_files/national_program_selector.yml
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
                        printf "nas: $n_as\n" >> config_files/national_program_selector.yml
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
                        printf "diksha: $dik_sha\n" >> config_files/national_program_selector.yml
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
                        printf "nishtha: $nish_tha\n" >> config_files/national_program_selector.yml
                        break;

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
check_microImprovements
check_ncf
check_ncertQuiz
check_nipunBharat
check_udise_plus
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
				check_microImprovements
                                check_ncf
                                check_ncertQuiz
                                check_nipunBharat
                                check_udise_plus
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


