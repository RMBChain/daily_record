# 1. 构建基础镜像
```
docker build -f SingleNode.dockerfile -t openjdk8_hadoop_singlenode:3.2.2 .
```

# 2. 启动单节点
```
docker run --rm --name hadoop322_singlenode -w /hadoop-3.2.2 --net host -it openjdk8_hadoop_singlenode:3.2.2 bash
```

# 3. 在容器内运行example
```
cd /hadoop-3.2.2
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.2.jar wordcount input output
cat output/*
```
