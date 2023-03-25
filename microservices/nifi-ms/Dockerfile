FROM apache/nifi:1.12.1
USER root
RUN mkdir /generator_data /processing_data /archived_data
RUN apt-get update -y
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash
RUN apt-get install nodejs

COPY cqube-ingest.sh .

RUN apt-get --allow-releaseinfo-change-suite update && apt-get update -y && apt-get install python3.7 -y && apt-get install python3-pip -y

RUN rm -rf conf/bootstrap.conf

COPY bootstrap.conf conf/bootstrap.conf
