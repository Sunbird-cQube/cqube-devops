FROM apache/nifi:1.12.1
USER root
RUN mkdir /generator_data /archived_data /input_data /processing_data

RUN apt-get --allow-releaseinfo-change-suite update && apt-get update -y && apt-get install python3.7 -y && apt-get install python3-pip -y
