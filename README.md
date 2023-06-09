
# Daily Record

## Ubuntu18.04安装Docker
#### 方式1
```bash
apt -y install docker.io
systemctl start docker
systemctl enable docker
```

#### 方式2， wsl2中安装docker用这个方法.
```bash
apt -y update
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
service docker start

# 查看是否安装成功：
docker --version
```

#
## Docker Compose
```bash
# 下载 要安装其他版本的 Compose，请替换 1.29.1。
curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# 权限
chmod +x /usr/local/bin/docker-compose
# 创建软链：
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

#
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

#
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
#
## 代码行数统计
```bash
docker run --rm -v 代码所在目录:/workdir hhatto/gocloc .
```

## Mysql
含有管理端 adminer
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
      MYSQL_ROOT_HOST: '%'
  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

```

含有管理端 adminer
```bash
docker run -d --name mysql --restart always -p 3306:3306 -e MYSQL_ROOT_HOST='%' -e MYSQL_ROOT_PASSWORD=root \
      mysql:5.7.31                                               \
      --character-set-server=utf8mb4        `# 设置字符编码`      \
      --collation-server=utf8mb4_unicode_ci `# 设置字符编码`      \
      --lower_case_table_names=1            `# 表名不区分大小写`

docker run --name mysql-adminer --link mysql_db_server:db -d -p 33306:8080 adminer:4.8.0
```

含有管理端 phpmyadmin
```bash
docker run -d --name mysql --restart always -p 3306:3306 -e MYSQL_ROOT_HOST='%' -e MYSQL_ROOT_PASSWORD=root \
       mysql:5.7.31                                              \
       --character-set-server=utf8mb4        `# 设置字符编码`      \
       --collation-server=utf8mb4_unicode_ci `# 设置字符编码`      \
       --lower_case_table_names=1            `# 表名不区分大小写`

docker run --name myadmin -d --link mysql_db_server:db -p 8080:80 phpmyadmin/phpmyadmin:5.1.0
```

单部署 mysql5
```bash
docker rm -f mysql5
docker run -d --name mysql5   \
      --restart always       \
      -p 3306:3306           \
      -e MYSQL_ROOT_HOST='%'         `# 开启root的远程访问`    \
      -e MYSQL_ROOT_PASSWORD=root    `# root用户的密码`        \
      -e TZ=Asia/Shanghai           `# 设置时区`               \
      -v /home/mysql/conf:/etc/mysql/conf.d `#配置文件挂载到当前宿主机的/home/mysql/conf` \
      -v /home/mysql/data:/var/lib/mysql    `#数据挂载到当前宿主机的 /home/mysql/data`    \
      mysql:5.7.31                                                \
      --character-set-server=utf8mb4        `# 设置字符编码`      \
      --collation-server=utf8mb4_unicode_ci `# 设置字符编码`      \
      --lower_case_table_names=1            `# 表名不区分大小写`

docker logs -f mysql
```

单部署 mysql8
```bash
docker rm -f mysql8
docker run -d --name mysql8   \
      --restart always       \
      -p 3306:3306           \
      -e MYSQL_ROOT_HOST='%'         `# 开启root的远程访问`    \
      -e MYSQL_ROOT_PASSWORD=root    `# root用户的密码`        \
      -e TZ=Asia/Shanghai           `# 设置时区`               \
      -v /home/mysql/conf:/etc/mysql/conf.d `#配置文件挂载到当前宿主机的/home/mysql/conf` \
      -v /home/mysql/data:/var/lib/mysql    `#数据挂载到当前宿主机的 /home/mysql/data`    \
      mysql:8.0.33                                                \
      --character-set-server=utf8mb4        `# 设置字符编码`      \
      --collation-server=utf8mb4_unicode_ci `# 设置字符编码`      \
      --lower_case_table_names=1            `# 表名不区分大小写`

docker logs -f mysql
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

docker run -it -d --name redis -p 6379:6379 redis:6.0.6

docker run -it -d --name redisAdmin --link redis:redis -p 16379:80 -e REDIS_1_HOST=redis -e REDIS_1_NAME=redis erikdubbelboer/phpredisadmin:v1.13.1

docker run -it -d --name redis-commander --link redis:redis -p 16379:8081 -e REDIS_HOSTS=redis rediscommander/redis-commander:latest

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

## JAVA 8 (openjdk)
```
docker run -it openjdk:8u292-jdk bash
```

## JAVA 8 (Oracle Jdk)
```
 
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

访问 http://localhost:8055/jenkins


修改交换空间 https://www.cnblogs.com/wang-yaz/p/9395005.html


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
docker run -it --rm            httpd:2.4.48 ab -v -r -n 100 -c 10 http://www.baidu.com/
docker run -it --rm --net=host httpd:2.4.48 ab -v -r -n 100 -c 10 http://localhost:8080/  #测试宿主机
```

-c 并发数量

-n 总请求数量

结果解析：https://www.cnblogs.com/gumuzi/p/5617232.html


## Nginx
```bash
docker run -d -p 7070:80 nginx:stable
```

发布当前目录
```bash
docker run --rm -v $PWD:/usr/share/nginx/html -p 9090:80 nginx:1.18
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
docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry:2.7.1
```

## Docker Registry-WEB https://hub.docker.com/r/hyper/docker-registry-web/
无搜索功能
```bash
docker run -d --restart always -p 5000:5000 --name registry-srv registry:2
docker run -d --restart always -p 9752:8080 --name registry-web --link registry-srv -e REGISTRY_URL=http://registry-srv:5000/v2 -e REGISTRY_NAME=localhost:5000 hyper/docker-registry-web 
```

有搜索功能 https://github.com/kwk/docker-registry-frontend
```bash
docker run -d --restart always -p 5000:5000 --name registry-srv registry:2
docker run -d --restart always -p 9753:80   --name docker-registry-frontend --link registry-srv -e ENV_DOCKER_REGISTRY_HOST=registry-srv -e ENV_DOCKER_REGISTRY_PORT=5000 konradkleine/docker-registry-frontend:v2
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


## elasticsearch
```bash
docker run -e ES_JAVA_OPTS="-Xms256m -Xmx256m" -d --name elasticsearch  -p 9200:9200 -p 9300:9300 elasticsearch:6.8.13
docker run -d -p 9100:9100 docker.io/mobz/elasticsearch-head:5
```

## gitlab 注意两个端口的映射，external_url要求内外一样，gitlab_shell_ssh_port内外不一样
```bash
docker pull gitlab/gitlab-ce:13.8.8-ce.0

mkdir /secondDisk
mkdir /secondDisk/gitlab

export GITLAB_HOME=/secondDisk/gitlab
docker rm -f gitlab
docker run -d --hostname "114.116.212.71" \
  -p 7443:443 \
  -p 7080:7080 \
  -p 7022:22 \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://114.116.212.71:7080'; gitlab_rails['lfs_enabled'] = true; gitlab_rails['gitlab_shell_ssh_port'] = 7022;" \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab   \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  gitlab/gitlab-ce:13.8.8-ce.0


git clone ssh://git@114.116.212.71:7022/root/23423.git
git clone http://username:password$@114.116.212.71:7080/root/23423.git
```
优化
https://blog.csdn.net/ouyang_peng/article/details/84066417

备份
https://www.cnblogs.com/breakering/p/9712040.html

## 网页版流程图 draw.io
```
docker run -it --rm --name="draw" -p 5647:8080 -p 8443:8443 fjudith/draw.io
```
http://localhost:5647



