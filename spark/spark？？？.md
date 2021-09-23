
docker run -it -p 8080:8080 -p  openjdk:8u292-jdk bash

apt-get -y update
apt-get -y install zip

curl -s "https://get.sdkman.io" | bash
source "/root/.sdkman/bin/sdkman-init.sh"
sdk install scala 2.13.6

wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
tar xvf spark-3.1.2-bin-hadoop3.2.tgz

cd spark-3.1.2-bin-hadoop3.2/bin
./spark-shell


