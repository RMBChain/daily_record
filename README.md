## Docker 镜像源
vi /etc/docker/daemon.json
```bash
{
    "registry-mirrors": [
      "https://registry.docker-cn.com", 
      "http://hub-mirror.c.163.com", 
      "https://docker.mirrors.ustc.edu.cn",       
      "http://hub-mirror.c.163.com", 
      "https://qern3h2q.mirror.aliyuncs.com"
    ]
}
```
service docker restart

## Docker In Docker
```bash
docker run -it --rm --name dind-sample --privileged --name dind-sample docker:19.03.12-dind
```
or
```bash
docker run -it --rm --name dind-sample -v /var/run/docker.sock:/var/run/docker.sock docker:19.03.12-dind "/bin/sh"
```
or
```bash
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock docker:19.03.12-dind "/bin/sh"
```

## 代码行数统计
```bash
docker run --rm -v 代码所在目录:/workdir hhatto/gocloc .
```
## Mysql
含有管理端
```bash
# docker stack deploy -c mysql.yml mysql
version: '3.1'
services:
  db:
    image: mysql:5.7.31
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    volumes: 
      - C:/Users/Administrator/.mysql:/var/lib/mysql
    ports:
      - 3306:3306
    environment:
      MYSQL_ROOT_PASSWORD: root

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

```

单部署
```bash
docker run --name mysql-rouyi --restart always -e MYSQL_ROOT_PASSWORD=root -v %USERPROFILE%/.mysql:/var/lib/mysql -d mysql:5.7.31
```

Prometheus

```bash
https://www.cnblogs.com/myzony/p/10253986.html
docker-compose -f ./docker-compose.yml -p MySQL-Monitor down
docker-compose -f ./docker-compose.yml -p MySQL-Monitor up -d
docker exec -it test-mysql mysql -u root -p 
GRANT ALL PRIVILEGES ON *.* to 'root'@'localhost' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'         IDENTIFIED BY 'root';
flush privileges;
http://localhost:20002
http://prometheus:9090
```

## Redis
```bash
docker run -it -d --name redis --restart always -p 6379:6379 redis:6.0.6

docker run -it -d --name redisAdmin --restart always -p 16379:80 -e REDIS_1_HOST=192.168.199.144 -e REDIS_1_NAME=localhost erikdubbelboer/phpredisadmin:v1.13.1

docker run -it -d --name redis-commander --restart always -p 16379:8081 -e REDIS_HOSTS=192.168.199.144 rediscommander/redis-commander:latest

```

## ELK(java 日志)
ELK集成
https://www.cnblogs.com/tchua/p/11049589.html
```bash
docker run -dit --name elk -p 5601:5601 -p 9200:9200 -p 5044:5044 sebp/elk:660
```
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.0-x86_64.rpm

## linux
```bash
docker run -it -d --name centos7.7.1908 centos:centos7.7.1908
docker run -it -d --name ubuntu:16.04   ubuntu:16.04
docker run -it -d --name ubuntu:18.04   ubuntu:18.04
docker run -it -d --name ubuntu:20.04   ubuntu:20.04
```
## Jenkins Blueocean
## Jenkins
```bash
docker run -p 8080:8080 -p 50000:50000 jenkins
```
## Maven(含java8)
```bash
docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.3-jdk-8 mvn clean install
```
## Jenkins、Git、Maven
Jenkins.DockerFile
```bash
FROM jenkins/jenkins:alpine
USER root
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.10/main > /etc/apk/repositories && \
echo http://mirrors.ustc.edu.cn/alpine/v3.10/community >> /etc/apk/repositories
ADD apache-maven-3.6.3-bin.tar.gz /usr/local
RUN apk add git
RUN cd /usr/local && rm -rf *.gz
ENV MAVEN_HOME=/usr/local/apache-maven-3.6.3
ENV PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin
ENTRYPOINT ["/sbin/tini","--","/usr/local/bin/jenkins.sh"]
```
创建镜像
```shell
curl -o apache-maven-3.6.3-bin.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

docker build -f Jenkins.DockerFile -t jenkins-all-in-one .
```
部署
```yaml
   jenkins:
     image: jenkins-all-in-one
     environment:
        JENKINS_OPTS: '--prefix=/jenkins'
     ports:
      - "8055:8080"
      - "50000:50000"
     volumes:
      - /home/jenkins-home:/var/jenkins_home
      - /home/settings.xml:/usr/local/apache-maven-3.6.3/conf/settings.xml
      - /root/.m2/:/root/.m2/
      - /var/run/docker.sock:/var/run/docker.sock
     deploy:
      replicas: 1
```

## docker.github
docker 文档
```bash
docker run -d -p 4000:4000 docs/docker.github.io:v17.03
```

## sonatype/nexus3
```bash
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
```

## INFLUXDB
```bash
docker run –itd -p 8086:8086 -p 8083:8083 -e INFLUXDB_ADMIN_ENABLED=true --name influxdb influxdb:1.7.9
```

## Tomat:9.0.30-jdk8-openjdk

```bash
docker run -it -p 8080:8080 --name tomcat9.0.30_jdk8 tomat:9.0.30-jdk8-openjdk
```


## AB(apche) 并发测试
```bash
docker run -it --rm --name nginxtest -p 9999:80 nginx:1.19.0
docker run -it --rm --link nginxtest -w /usr/local/apache2/bin httpd:2.4.46-alpine sh
```

```bash
ping nginxtest
ab -n 1000 -c 1000 http://nginxtest/
```

## Nginx
```bash
docker run -d -p 7070:80 nginx:stable
```

## busybox(linux 工具集)
```bash
docker run -it busybox
```

## Docker管理-portainer/portainer 
https://portainer.readthedocs.io/en/latest/deployment.html
```bash
docker pull portainer/portainer:1.23.2
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
```

deploy in swarm cluster

```powershell
curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
docker stack deploy --compose-file=portainer-agent-stack.yml portainer
```

## Docker管理-Docker UI
```bash
docker run -d --name portainerUI -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
```
```bash
docker run -d -p 9000:9000 -v /var/run/docker.sock:/docker.sock --name dockerui abh1nav/dockerui:latest -e="/docker.sock“
```
## cadvisor（Docker 仪表盘）

```bash
docker run --volume=/var/run:/var/run:ro --volume=/sys:/sys:ro  --volume=/var/lib/docker/:/var/lib/docker:ro --volume=/dev/disk/:/dev/disk:ro --publish=38080:8080 --detach=true --privileged=true --name=cadvisor  google/cadvisor
```

## Docker Registry（本地docker hub）
```bash
docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry:latest
```

## Docker Registry-WEB
无搜索功能
```bash
https://hub.docker.com/r/hyper/docker-registry-web/
```

有搜索功能
```bash
https://github.com/kwk/docker-registry-frontend
```

## Rabbitmq
带管理端
```bash
docker run -d -p 15672:15672 -p 5672:5672 --hostname my-rabbit --restart always --name some-rabbit -e RABBITMQ_DEFAULT_USER=root -e RABBITMQ_DEFAULT_PASS=root rabbitmq:3.8.9-management-alpine
```

不带管理端
```bash
docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3.8.9
```

with prometheus
[https://www.rabbitmq.com/prometheus.html#quick-start](https://www.rabbitmq.com/prometheus.html#quick-start)


## prometheus
```bash
docker run -it -d -p 20001:9090 -v D:/_git/prometheus.yaml:/etc/prometheus/prometheus.yml --name prometheus prom/prometheus
```


## 使用openssl生成证书
```bash
docker run -it -d --name ubuntu16.04 ubuntu:16.04
docker exec -it ubuntu16.04 bash

apt -y install apt-utils gcc make wget net-tools iputils-ping clang-format shellcheck vim
wget https://www.openssl.org/source/openssl-1.1.1j.tar.gz
tar -xzvf openssl-1.1.1j.tar.gz

./config
make install
ln -sf /usr/local/ssl/bin/openssl /usr/local/bin/openssl
openssl version -v

openssl req -new -newkey rsa:2048 -sha256 -nodes -out example.csr -keyout example.key -subj "/C=CN/ST=Dalian/L=Dalian/O=example Inc./OU=Web Security/CN=cn"
docker cp ubuntu16.04:/home/ .
```


