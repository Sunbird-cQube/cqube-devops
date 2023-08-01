### Gitpod 

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/<git_username>/cqube-devops/tree/gitpod-branch)

# cQube_devops Installation
###  Prerequisites to install cQube_devops:

- Ubuntu 22.04 (supported) 
- 16 GB of System RAM (minimum requirement)
- 4 core CPU (minimum requirement)
- 250GB HDD

### Security Group Configuration:
- Port 80 inbound from 0.0.0.0/0
- Port 443 inbound from 0.0.0.0/0
- Port 8000 inbound from nginx private ip ( to communicate with kong )
- 5432 inbound to the particular ip which needs access

### Kong Configurations: ( already configured using one step deployment )
- 3000 will get routed to /ingestion
- 3001 will get routed to /spec
- 3003 will get routed to /generator

### Domain Name:
- Create a domain name
- Configure cname of ec2 instance to the domain name
- Create a SSL certificate for the domain name.

# Installation Steps:
- Open Terminal
- Clone the cqube-devops repository using following command
   ```git clone https://github.com/Sunbird-cQube/cqube-devops.git```

- Navigate to the directory where cQube_devops has been downloaded or cloned 
  ```
  cd cqube_devops/
  git checkout dev
  git pull
  ```

- Enter the configuration details for the below mentioned list in config.yml (* all the values are mandatory)

- configuration file which contains some constant values and few required variables should be entered by the user. Following are the variables which get added in the config file.
 
- Constant Variables: These variables are auto generated
  ```
  System_user_name
  base_dir
  Private_ip
  aws_default_region
  ```
- Optional_variables: Database credentials contain default values. If the user wishes to enter their own credentials then the user should opt for yes to enter their credentials otherwise can opt for no when the question pops up

  ```
  db_user_name
  db_name
  db_password
  ```
  
- User Input Variables: These are variables which need to be entered by the user by following the Hint provided

- state_name ( Enter the required state code by referring to the state list provided )
- api_end_point ( Enter the url in which cqube to be configured )
- s3_access_key
- s3_secret_key
- s3 processing bucket name
- s3 archived bucket name
- s3 error bucket name

- Note: Users should follow the Hints provided in the description and should enter the variables accordingly. If the entered value is wrong then an error message gets displayed and the user should modify the variable value accordingly.


- Give the following permission to the install.sh file

  ```
  chmod u+x install.sh
  ```

- Install cQube using the non-root user with sudo privilege

- Configuration filled in config.yml will be validated first. If there is any error during validation, you will be prompted with the appropriate error message and the installation will be aborted. Refer the error message and solve the errors appropriately, then re-run the installation script ```sudo ./install.sh```

- Start the installation by running install.sh shell script file as mentioned below:

  ```
  sudo ./install.sh
  ```

Once installation is completed without any errors, you will be prompted the following message. 
```**cQube installed successfully!!**```
