FROM openjdk:8u292-jdk
RUN apt-get -y update

# install scala
RUN wget https://downloads.lightbend.com/scala/2.13.6/scala-2.13.6.tgz &&\
    tar -xvf scala-2.13.6.tgz                                          &&\
    rm  scala-2.13.6.tgz
  
ENV SCALA_HOME=/scala-2.13.6
ENV PATH=$PATH:$SCALA_HOME/bin

RUN wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz  &&\
    tar -xvf spark-3.1.2-bin-hadoop3.2.tgz                                         &&\
    rm  spark-3.1.2-bin-hadoop3.2.tgz
