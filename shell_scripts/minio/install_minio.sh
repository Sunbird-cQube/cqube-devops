#!/bin/bash
api_endpoint=$(awk ''/^api_endpoint:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

mode_of_installation=$(awk ''/^mode_of_installation:' /{ if ($2 !~ /#.*/) {print $2}}' config_files/config.yml)

if ! [ $( docker ps -a | grep cqube_minio | wc -l ) -gt 0 ]; then
   # minio setup as a contaioner
   docker pull minio/minio

 if [[ $mode_of_installation == public ]]; then
      docker run -d -p 9000:9000 -p 9001:9001 --name cqube_minio --restart=always --network cqube_net --ip 10.0.0.2 -e "MINIO_SERVER_URL=https://$api_endpoint/" -e "MINIO_BROWSER_REDIRECT_URL=https://$api_endpoint/minio/ui"  -e "MINIO_ROOT_USER=minioadmin" -e "MINIO_ROOT_PASSWORD=minioadmin" -e "MINIO_BROWSER=on" minio/minio:latest server /data --console-address ":9001"
  else
      docker run -p 9000:9000 -p 9001:9001 --name cqube_minio --restart=always --network cqube_net --ip 10.0.0.2 -d minio/minio:latest server /data --console-address ":9001"
 fi
   # Minio user creation
   # Download the mc binary
   wget https://dl.min.io/client/mc/release/linux-amd64/mc

   # Make the mc binary executable
   chmod +x mc

   # Move the mc binary to /usr/local/bin
   mv mc /usr/local/bin

   mc alias set myminio http://localhost:9000 minioadmin minioadmin
   mc mb myminio/cqube-minio-bucket
fi
