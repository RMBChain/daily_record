# 使用 dind 镜像，用docker jenkins 构建docker 镜像
- https://blog.csdn.net/freewebsys/article/details/79756488

# DOC
- https://hub.docker.com/_/docker

# DIND
docker rm -f dind
export CertDir=/vmdata/catchfly/tmp/cert
docker run -d   -e DOCKER_TLS_CERTDIR=/certs -v $CertDir/client:/certs/client    -v $CertDir/ca:/certs/ca --privileged       --name dind --restart always docker:20.10.12-dind
docker run --rm -e DOCKER_TLS_CERTDIR=/certs -v $CertDir/client:/certs/client:ro                          --link dind:docker                              docker:20.10.12 version
docker run -it  -e DOCKER_TLS_CERTDIR=/certs -v $CertDir/client:/certs/client:ro                          --link dind:docker                              docker:20.10.12 sh



jdk8      
  wget https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u292-b10/openlogic-openjdk-8u292-b10-linux-x64.tar.gz
jenkins
  wget https://get.jenkins.io/war-stable/2.319.2/jenkins.war -O jenkins_2.319.2.war
maven
  wget https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
git
  wget https://www.kernel.org/pub/software/scm/git/git-2.34.1.tar.gz
node
  wget https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz
verdaccio 


docker rmi cicd:v1
docker build -f cicd.dockerfile -t cicd:v1 .

docker run --rm -it -w /software cicd:v1 sh

