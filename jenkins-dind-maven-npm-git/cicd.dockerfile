FROM docker:20.10.12

ADD . /software
WORKDIR /software
# install jdk
RUN tar -xvf openlogic-openjdk-8u292-b10-linux-x64.tar.gz && mv  openlogic-openjdk-8u292-b10-linux-x64 openjdk-8u292

RUN echo "JAVA_HOME=/software/openjdk-8u292" >> /etc/profile &&\
    echo "CLASSPATH=/software/openjdk-8u292/lib/"        >> /etc/profile &&\
    echo "PATH=\$PATH:/software/openjdk-8u292/bin"       >> /etc/profile &&\
    echo "export JAVA_HOME CLASSPATH PATH"   >> /etc/profile &&\
    source /etc/profile
