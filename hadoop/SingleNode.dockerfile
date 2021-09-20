FROM openjdk:8u292-jdk
RUN apt-get -y update
RUN wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.1.tar.gz
RUN tar -zxvf hadoop-3.3.1.tar.gz
RUN rm hadoop-3.3.1.tar.gz
