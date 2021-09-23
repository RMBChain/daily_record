FROM openjdk:8u292-jdk
RUN apt-get -y update

# install and config ssh
RUN apt-get -y install openssh-server
RUN  mkdir ~/.ssh && cd ~/.ssh             && \
     ssh-keygen -t rsa -N '' -f id_rsa -q  && \
     cat id_rsa.pub >> authorized_keys     && \
     cat authorized_keys
ADD ./Pseudo-Distributed/sshd_config  /etc/ssh/sshd_config

# download and config hadoop
RUN wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.1.tar.gz && \
    tar -zxvf hadoop-3.3.1.tar.gz                                          && \
    rm hadoop-3.3.1.tar.gz
ADD ./Pseudo-Distributed/hadoop_cfg/  /hadoop-3.3.1/etc/hadoop/

# setting user for hadoop
ENV HDFS_DATANODE_SECURE_USER   root
ENV HDFS_NAMENODE_USER          root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV YARN_RESOURCEMANAGER_USER   root
ENV YARN_NODEMANAGER_USER       root

# format namenode
RUN /hadoop-3.3.1/bin/hadoop namenode -format

# CMD
CMD sh -c "service ssh restart && /hadoop-3.3.1/sbin/start-all.sh && bash"

EXPOSE 9870 9000 9864
