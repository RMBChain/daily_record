FROM openjdk:8u292-jdk
RUN apt-get -y update
RUN wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.1.tar.gz && \
    tar -zxvf hadoop-3.3.1.tar.gz                                          && \
    rm hadoop-3.3.1.tar.gz

