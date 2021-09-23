FROM openjdk:8u292-jdk
RUN apt-get -y update
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz  &&\
    tar -xvf hadoop-3.2.2.tar.gz                                                  &&\
    rm hadoop-3.2.2.tar.gz
