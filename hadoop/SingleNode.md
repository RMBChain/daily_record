# 1. 运行容器
```
docker run --rm --name openjdk8_hadoop331 -it openjdk:8u292-jdk bash
apt -y update
```

# 2. 在容器内下载hadoop
```
cd /
wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.1.tar.gz
tar -zxvf hadoop-3.3.1.tar.gz
rm hadoop-3.3.1.tar.gz
```

# 3. 在容器内运行example
```
cd hadoop-3.3.1
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar wordcount input output
cat output/*
```
