FROM apache/nifi:1.12.1
USER root
RUN mkdir /python_files

RUN apt-get --allow-releaseinfo-change-suite update && apt-get update -y && apt-get install python3.7 -y && apt-get install python3-pip -y
