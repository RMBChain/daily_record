FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y install openssh-server

RUN mkdir ~/.ssh && cd ~/.ssh             && \
    ssh-keygen -t rsa -N '' -f id_rsa -q

# 可以用其它证书的公钥替换掉 id_rsa.pub
RUN cd ~/.ssh                             && \
    cat id_rsa.pub >> authorized_keys     && \
    cat authorized_keys

EXPOSE 22
