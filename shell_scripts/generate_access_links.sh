#!/bin/bash

api_endpoint=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config.yml)
schema_documentation="https://project-sunbird.atlassian.net/wiki/spaces/CQUB/pages/3279290379/cQube+v5.0+Beta+-+Schema+Documentation"
usage_documentation="https://project-sunbird.atlassian.net/wiki/spaces/CQUB/pages/3279290379/cQube+v5.0+Beta+-+Schema+Documentation"

echo -e "\e[0;36m${bold}cQube dashboard can be accessible using $api_endpoint"
echo -e "\e[0;36m${bold}cQube ingestion api's can be accessible using $api_endpoint/api/ingestion"

echo -e "\e[0;36m${bold}cQube Schema documentation can be accessible using $schema_documentation"
echo -e "\e[0;36m${bold}cQube Usage documentation can be accessible using $usage_documentation"
