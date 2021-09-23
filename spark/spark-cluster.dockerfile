FROM openjdk:8u292-jdk
RUN apt-get -y update

# install software
RUN apt-get -y install openssh-server zip

# config ssh
RUN  mkdir ~/.ssh && cd ~/.ssh             && \
     ssh-keygen -t rsa -N '' -f id_rsa -q  && \
     cat id_rsa.pub >> authorized_keys     && \
     cat authorized_keys
ADD ./spark-cluster/sshd_config  /etc/ssh/sshd_config

# download and config hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz && \
    tar -zxvf hadoop-3.2.2.tar.gz                                          && \
    rm hadoop-3.2.2.tar.gz
ENV HADOOP_HOME  hadoop-3.2.2
ADD ./spark-cluster/hadoop_cfg/  /hadoop-3.2.2/etc/hadoop/


# setting user for hadoop
ENV HDFS_DATANODE_SECURE_USER   root
ENV HDFS_NAMENODE_USER          root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV YARN_RESOURCEMANAGER_USER   root
ENV YARN_NODEMANAGER_USER       root

# format namenode
RUN /hadoop-3.2.2/bin/hadoop namenode -format && rm -rf /tmp

# install scala
RUN curl -s "https://get.sdkman.io" | bash
RUN source "/root/.sdkman/bin/sdkman-init.sh"
RUN sdk install scala 2.13.6

# install spark
RUN cd /   && \
    wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz  && \
    tar xvf spark-3.1.2-bin-hadoop3.2.tgz  && \
    rm  xvf spark-3.1.2-bin-hadoop3.2.tgz

# CMD
ADD ./Cluster/entyrpoint.sh  /
CMD /entyrpoint.sh

EXPOSE 9870 9000 9864 8080 8088
