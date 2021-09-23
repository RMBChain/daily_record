# 完全分布式 参考
- https://blog.csdn.net/l1682686/article/details/107814620
- https://hadoop.apache.org/docs/stable/index.html

采坑: 节点的网络名称不要有任何看起来特别的字符。最好全英文 *小写* 字母和数字，千万不要有“-”、“_”、“%”等等。


# 1. 构建基础镜像
```
docker build -f Cluster.dockerfile -t openjdk8_hadoop_cluster:3.3.1 .
```

# 2. 启动主节点
*name必须是master，和配置文件中一致*
```
docker network create -d bridge hadoop_network
docker run -it --rm -w /hadoop-3.3.1 --name master --hostname master    \
       --network hadoop_network                                         \
       -p 9870:9870 -p 9000:9000 -p 9864:9864 -p 9866:9866 -p 8088:8088 \
       openjdk8_hadoop_cluster:3.3.1

```


# 2. 启动worker节点
```
docker run -it --rm -w /hadoop-3.3.1 --name work1 --hostname work1 --network hadoop_network openjdk8_hadoop_cluster:3.3.1
docker run -it --rm -w /hadoop-3.3.1 --name work2 --hostname work2 --network hadoop_network openjdk8_hadoop_cluster:3.3.1
docker run -it --rm -w /hadoop-3.3.1 --name work3 --hostname work3 --network hadoop_network openjdk8_hadoop_cluster:3.3.1
```


# 3. 查看hadoop版本
在容器内执行
```
cd /hadoop-3.3.1
bin/hadoop version
```


# 4. 使用jps查看服务
```
jsp
```

应该有下面6项:
```
NameNode
DataNode
Jps
NodeManager
SecondaryNameNode
ResourceManager
```


# 5. 访问WEB
http://localhost:9870/


# 6. 测试：
添加目录
```
/hadoop-3.3.1/bin/hdfs dfs -mkdir /input
```

添加文件到新建的目录中
```
/hadoop-3.3.1/bin/hdfs dfs -put etc/hadoop/*.xml /input
```

在 http://localhost:9870/ 的 Utilities->Browse the file system 中查看


运行测试程序
```
/hadoop-3.3.1bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar wordcount /input /output
```

查看结果
```
/hadoop-3.3.1/bin/hdfs dfs -cat /output/*
```

清理目录
```
/hadoop-3.3.1/bin/hdfs dfs -rm -r /output
```
