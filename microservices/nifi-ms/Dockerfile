FROM apache/nifi:1.12.1
USER root

COPY program_files .
COPY cqube-ingest.sh .
COPY cqube-ingest-install.sh .

COPY oracle/file_moving.py oracle/file_moving.py
COPY oracle/oracle-connect.sh oracle/oracle-connect.sh

RUN apt-get --allow-releaseinfo-change-suite update && apt-get update -y && apt-get install python -y && apt-get install python3.7 -y && apt-get install python3-pip -y
RUN apt-get update -y && apt-get install curl -y && curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install nodejs -y && npm install --global yarn -y

RUN rm -rf conf/bootstrap.conf

COPY bootstrap.conf conf/bootstrap.conf
