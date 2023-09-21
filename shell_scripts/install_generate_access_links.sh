#!/bin/bash

api_endpoint=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)
db_user=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)
db_name=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)
db_password=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)
mode_of_installation=$(awk ''/^mode_of_installation:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)


schema_documentation="https://project-sunbird.atlassian.net/wiki/spaces/CQUB/pages/3279290379/cQube+v5.0+Beta+-+Schema+Documentation"
usage_documentation="https://project-sunbird.atlassian.net/wiki/spaces/CQUB/pages/3280764974/Usage+Documentation"

if [[ $mode_of_installation == public ]]; then
echo -e "\e[0;36m${bold}cQube dashboard can be accessible using https://$api_endpoint/dashboard"
echo -e "\e[0;36m${bold}cQube admin dashboard can be accessible using https://$api_endpoint/admin"
echo -e "\e[0;36m${bold}cQube keycloak can be accessible using https://$api_endpoint/auth"
echo -e "\e[0;36m${bold}cQube ingestion api's can be accessible using https://$api_endpoint/api/ingestion"
echo -e "\e[0;36m${bold}cQube spec api's can be accessible using https://$api_endpoint/api/spec"
fi

if [[ $mode_of_installation == localhost ]]; then
echo -e "\e[0;36m${bold}cQube dashboard can be accessible using http://$api_endpoint:4200"
echo -e "\e[0;36m${bold}cQube admin dashboard can be accessible using http://$api_endpoint:4201"
echo -e "\e[0;36m${bold}cQube keycloak can be accessible using http://$api_endpoint:8080/auth"
echo -e "\e[0;36m${bold}cQube ingestion api's can be accessible using http://$api_endpoint:3000"
echo -e "\e[0;36m${bold}cQube spec api's can be accessible using http://$api_endpoint:3001"
fi

echo -e "\e[0;36m${bold}cQube Schema documentation can be accessible using $schema_documentation"
echo -e "\e[0;36m${bold}cQube Usage documentation can be accessible using $usage_documentation"
echo -e "\e[0;36m${bold}All the configuartion files can be found in config_files directory"


data_pull_status=$(awk ''/^data_pull_status:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/domain_specific_config.yml)
if [[ $data_pull_status == "true" ]]; then
	echo "As you have selected to pull the data from nvsk, Please wait for approximately 20 Minutes to visualise the data on cqube dashboard!"
fi
