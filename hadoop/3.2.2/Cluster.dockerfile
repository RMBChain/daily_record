FROM openjdk:8u292-jdk
RUN apt-get -y update

# install and config ssh
RUN apt-get -y install openssh-server
RUN  mkdir ~/.ssh && cd ~/.ssh             && \
     ssh-keygen -t rsa -N '' -f id_rsa -q  && \
     cat id_rsa.pub >> authorized_keys     && \
     cat authorized_keys
ADD ./Cluster/sshd_config  /etc/ssh/sshd_config

# download and config hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz && \
    tar -xvf hadoop-3.2.2.tar.gz                                                && \
    rm hadoop-3.2.2.tar.gz
ENV HADOOP_HOME  /hadoop-3.2.2
ADD ./Cluster/hadoop_cfg/  /hadoop-3.2.2/etc/hadoop/


# setting user for hadoop
ENV HDFS_DATANODE_SECURE_USER   root
ENV HDFS_NAMENODE_USER          root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV YARN_RESOURCEMANAGER_USER   root
ENV YARN_NODEMANAGER_USER       root

# format namenode
RUN /hadoop-3.2.2/bin/hadoop namenode -format && rm -rf /tmp

# CMD
ADD ./Cluster/entyrpoint.sh  /
CMD /entyrpoint.sh

EXPOSE 9870 9000 9864
