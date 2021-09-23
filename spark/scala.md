
docker run -it -p 8080:8080 -p  openjdk:8u292-jdk bash

apt-get -y update
apt-get -y install zip

curl -s "https://get.sdkman.io" | bash
source "/root/.sdkman/bin/sdkman-init.sh"
sdk install scala 2.13.6

scala
