FROM apache/nifi:1.12.1
USER root
RUN mkdir /generator_data /processing_data /archived_data

COPY clone-repo.sh .
COPY cqube-ingest.sh .
COPY cqube-ingest-install.sh .

RUN apt-get --allow-releaseinfo-change-suite update && apt-get update -y && apt-get install python3.7 -y && apt-get install python3-pip -y
RUN apt-get update -y && apt-get install curl -y && curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install nodejs -y && npm install --global yarn -y

RUN rm -rf conf/bootstrap.conf

COPY bootstrap.conf conf/bootstrap.conf
