FROM openjdk:8u292-jdk
RUN apt-get -y update

# install and config ssh
RUN apt-get -y install openssh-server
RUN  mkdir ~/.ssh && cd ~/.ssh             && \
     ssh-keygen -t rsa -N '' -f id_rsa -q  && \
     cat id_rsa.pub >> authorized_keys     && \
     cat authorized_keys
ADD ./spark-cluster/sshd_config  /etc/ssh/sshd_config

# download and config hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz && \
    tar -xvf hadoop-3.2.2.tar.gz                                                 && \
    rm hadoop-3.2.2.tar.gz
ADD ./spark-cluster/hadoop_cfg/  /hadoop-3.2.2/etc/hadoop/

# format namenode
RUN /hadoop-3.2.2/bin/hadoop namenode -format && rm -rf /tmp

# install scala
RUN wget https://downloads.lightbend.com/scala/2.13.6/scala-2.13.6.tgz &&\
    tar -xvf scala-2.13.6.tgz                                          &&\
    rm  scala-2.13.6.tgz  

# install spark       
RUN wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz  &&\
    tar -xvf spark-3.1.2-bin-hadoop3.2.tgz                                         &&\
    mv  spark-3.1.2-bin-hadoop3.2 spark-3.1.2                                      &&\
    rm  spark-3.1.2-bin-hadoop3.2.tgz
ADD ./spark-cluster/spark_conf /spark-3.1.2/conf
ADD ./spark-cluster/spark_sbin /spark-3.1.2/sbin

# setting for java
ENV JAVA_HOME=/usr/local/openjdk-8
# setting for hadoop
ENV HADOOP_HOME=/hadoop-3.2.2
ENV HADOOP_CONF_DIR=/hadoop-3.2.2/etc/hadoop
# setting user for hadoop
ENV HDFS_DATANODE_SECURE_USER=root
ENV HDFS_NAMENODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root
# setting for scala
ENV SCALA_HOME=/scala-2.13.6
ENV PATH=$PATH:$SCALA_HOME/bin
# setting for spark
ENV SPARK_HOME=/spark-3.1.2

# CMD
ADD ./spark-cluster/entyrpoint-master.sh  /
ADD ./spark-cluster/entyrpoint-work.sh    /

EXPOSE 9870 9000 9864 8080 8088 7077 
