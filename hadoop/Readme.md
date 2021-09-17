# wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.1.tar.gz
# tar -zxvf hadoop-3.3.1.tar.gz

cd /hadoop

docker build -t hadoop3.3.1 . 

docker network create hadoop_network

# docker run -it --rm -v $PWD/hadoop-3.3.1:/hadoop -w /hadoop --hostname hadoop01 --net hadoop_network openjdk:8u292-jdk bash
# docker run -it --rm -v $PWD/hadoop-3.3.1:/hadoop -w /hadoop --hostname hadoop02 --net hadoop_network openjdk:8u292-jdk bash
# docker run -it --rm -v $PWD/hadoop-3.3.1:/hadoop -w /hadoop --hostname hadoop03 --net hadoop_network openjdk:8u292-jdk bash

docker run -it --rm -w /hadoop --hostname hadoop01 --net hadoop_network hadoop3.3.1 bash
docker run -it --rm -w /hadoop --hostname hadoop02 --net hadoop_network hadoop3.3.1 bash
docker run -it --rm -w /hadoop --hostname hadoop03 --net hadoop_network hadoop3.3.1 bash

apt-get -y update
apt-get -y install ssh pdsh vsftpd


# 创建hadoop用户，hadoopgroup组
groupadd -g 102 hadoopgroup  # 创建用户组
useradd -d /opt/hadoop -u 10201  -g 102  hadoop  #创建用户
passwd  hadoop  #给用户设置密码 hadoop/hadoop


service vsftpd start
service vsftpd stop

mkdir input
cp etc/hadoop/*.xml input
./bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar grep input output 'dfs[a-z.]+'
cat output/*


