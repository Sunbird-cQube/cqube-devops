#!/bin/bash

api_endpoint=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
db_user=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
db_name=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
db_password=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
mode_of_installation=$(awk ''/^mode_of_installation:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)


schema_documentation="https://project-sunbird.atlassian.net/wiki/spaces/CQUB/pages/3279290379/cQube+v5.0+Beta+-+Schema+Documentation"
usage_documentation="https://project-sunbird.atlassian.net/wiki/spaces/CQUB/pages/3279290379/cQube+v5.0+Beta+-+Schema+Documentation"

if [[ $mode_of_installation == public ]]; then
echo -e "\e[0;36m${bold}cQube dashboard can be accessible using $api_endpoint"
echo -e "\e[0;36m${bold}cQube ingestion api's can be accessible using $api_endpoint/api/ingestion"
fi

if [[ $mode_of_installation == localhost ]]; then
echo -e "\e[0;36m${bold}cQube dashboard can be accessible using $api_endpoint:4200"
echo -e "\e[0;36m${bold}cQube ingestion api's can be accessible using $api_endpoint:3000/api/ingestion"
fi

echo -e "\e[0;36m${bold}cQube Schema documentation can be accessible using $schema_documentation"
echo -e "\e[0;36m${bold}cQube Usage documentation can be accessible using $usage_documentation"
