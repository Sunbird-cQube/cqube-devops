#!/bin/bash

txtreset=$(tput sgr0) # Text reset
txtred=$(tput setaf 1) # Red
txtgreen=$(tput setaf 10) #green
txtblue=$(tput setaf 6) #blue

check_os_version() {
# Read the value of the VERSION_ID from the os-release file
VERSION_ID=$(grep DISTRIB_RELEASE /etc/lsb-release | cut -d '=' -f 2)

# Compare the version with the desired version (22.04)
if  [[ $VERSION_ID == "22.04" ]]; then
    echo "$txtblue status check1: $txtgreen Operating system version is 22.04. $txtreset"
else
    echo "$txtblue status check1: $txtred Operating system version is not 22.04. Please make sure to create a VM with ubuntu 22.04 $txtreset"
fi
}


check_cpu_cores() {
# Get the number of processing units (CPU cores + threads)
CPU_CORES=$(nproc)

if  [ $CPU_CORES -ge "4" ]; then
    echo "$txtblue status check2: $txtgreen Number of CPU cores: $CPU_CORES $txtreset"
else
     echo "$txtblue status check2: Number of CPU cores is less than the required. Please make sure 4 cpu core VM is required to deploy cqube $txtreset"
fi
}

check_storage() {
# Get available disk space in GB (using the -h flag for human-readable output)
AVAILABLE_SPACE=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//')

# Define the threshold (100GB)
THRESHOLD=245

# Compare available space with the threshold
if [ "$AVAILABLE_SPACE" -ge "$THRESHOLD" ]; then
    echo "$txtblue status check3: $txtgreen Available storage is greater than or equal to 256GB. $txtreset"
else
    echo "$txtblue status check3: $txtred Available storage is less than 256GB. Please make sure to extend the storage to more than or equal to 100GB $txtreset"
fi
}

check_ram() {
# Get total RAM in GB (using the -h flag for human-readable output)
TOTAL_RAM=$(free -g | awk '/^Mem:/ {print $2}' | sed 's/G//')

# Define the threshold (16GB)
THRESHOLD=15

# Compare total RAM with the threshold
if [ "$TOTAL_RAM" -ge "$THRESHOLD" ]; then
    echo "$txtblue status check3: $txtgreen Total RAM is greater than or equal to 16GB. $txtreset"
else
    echo "$txtblue status check4: $txtgreen Total RAM is less than 16GB. Please create a VM having minimun 16GB RAM $txtreset"
fi
}

check_port() {
# Define the port to check
PORT=$1

# Check if the port is running
if netstat -tuln | grep ":$PORT " > /dev/null; then
    echo "$txtblue status check$2: $txtred Port $PORT is running. Kill the port using the process ID. $txtreset"
    echo "Hint: Run the command sudo netstat -ntlp and note down the PID of the port $1"
    echo "Run the following command to kill the port sudo kill -15 <PID>"
else
    echo "$txtblue status check$2:$txtgreen Port $PORT is not running. $txtreset"
fi
}

check_os_version
check_cpu_cores
check_storage
check_ram
check_port 22 4
check_port 443 5
check_port 9000 6
check_port 9001 7
check_port 8000 8
check_port 4200 9
check_port 3000 10
check_port 3001 11
check_port 3002 12
check_port 3003 13
check_port 8096 14
check_port 5432 15
check_port 8080 16
