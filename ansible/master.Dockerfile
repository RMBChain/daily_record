FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y install openssh-server

RUN mkdir ~/.ssh && cd ~/.ssh             && \
    ssh-keygen -t rsa -N '' -f id_rsa -q

RUN cd ~/.ssh                             && \
    cat id_rsa.pub >> authorized_keys     && \
    cat authorized_keys

RUN apt-get -y install software-properties-common
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get -y install ansible
RUN ansible --version

EXPOSE 22
