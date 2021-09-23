# 1. 构建基础镜像
```
docker build -f SingleNode.dockerfile -t openjdk8_hadoop_singlenode:3.3.1 .
```

# 2. 启动单节点
```
docker run --rm --name hadoop331_singlenode -w /hadoop-3.3.1 --net host -it openjdk8_hadoop_singlenode:3.3.1 bash
```

# 3. 在容器内运行example
```
cd /hadoop-3.3.1
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar wordcount input output
cat output/*
```
