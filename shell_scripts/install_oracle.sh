#bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"

curl https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh -o install.sh

sudo pip install oci-cli

oci setup config

