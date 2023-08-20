#!/bin/bash

check_os_version() {
echo "Checking if install os version is ubuntu 22.04"
# Read the value of the VERSION_ID from the os-release file
VERSION_ID=$(grep DISTRIB_RELEASE /etc/lsb-release | cut -d '=' -f 2)

echo $VERSION_ID
# Compare the version with the desired version (22.04)
if  [[ $VERSION_ID == "22.04" ]]; then
    echo "Operating system version is 22.04."
else
    echo "Operating system version is not 22.04. Please make sure to create a VM with ubuntu 22.04"
fi
}


check_cpu_cores() {
# Get the number of processing units (CPU cores + threads)
CPU_CORES=$(nproc)

if  [ $CPU_CORES -ge "4" ]; then
    echo "Number of CPU cores: $CPU_CORES"
else
     echo "Number of CPU cores is less than the required. Please make sure 4 cpu core VM is required to deploy cqube"
fi
}

check_storage() {
# Get available disk space in GB (using the -h flag for human-readable output)
AVAILABLE_SPACE=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//')

# Define the threshold (100GB)
THRESHOLD=90

# Compare available space with the threshold
if [ "$AVAILABLE_SPACE" -ge "$THRESHOLD" ]; then
    echo "Available storage is greater than or equal to 100GB."
else
    echo "Available storage is less than 100GB. Please make sure to extend the storage to more than or equal to 100GB"
fi
}

check_ram() {
# Get total RAM in GB (using the -h flag for human-readable output)
TOTAL_RAM=$(free -g | awk '/^Mem:/ {print $2}' | sed 's/G//')

# Define the threshold (16GB)
THRESHOLD=15

# Compare total RAM with the threshold
if [ "$TOTAL_RAM" -ge "$THRESHOLD" ]; then
    echo "Total RAM is greater than or equal to 16GB."
else
    echo "Total RAM is less than 16GB. Please create a VM having minimun 16GB RAM"
fi
}

check_port() {
# Define the port to check
PORT=$1

# Check if the port is running
if netstat -tuln | grep ":$PORT " > /dev/null; then
    echo "Port $PORT is running. Kill the port using the process ID."
    echo "Run the command sudo netstat -ntlp and note down the PID of the port $1"
    echo "Run the following command to kill the port sudo kill -15 <PID>"
else
    echo "Port $PORT is not running."
fi
}

check_os_version
check_cpu_cores
check_storage
check_ram
check_port 80
check_port 443
check_port 9000
check_port 9001
check_port 8000
check_port 4200
check_port 3000
check_port 3001
check_port 3002
check_port 3003
check_port 8096
check_port 5432
check_port 8080
