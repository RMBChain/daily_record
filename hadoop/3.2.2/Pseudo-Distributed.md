# 参考
- https://blog.csdn.net/l1682686/article/details/107713274
- https://hadoop.apache.org/docs/stable/index.html

# 1. 构建基础镜像
```
docker build -f Pseudo-Distributed.dockerfile -t openjdk8_hadoop_pseudo-distributed:3.2.2 .
```

# 2. 启动
```
docker run --rm --name hadoop331_pseudo-distributed -w /hadoop-3.2.2 --net host -it openjdk8_hadoop_pseudo-distributed:3.2.2
```

# 3. 查看hadoop版本
在容器内执行
```
cd /hadoop-3.2.2
bin/hadoop version
```


# 4. 使用jps查看服务
```
jps
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
cd /hadoop-3.2.2
/hadoop-3.2.2/bin/hdfs dfs -mkdir /input                   # 添加目录
/hadoop-3.2.2/bin/hdfs dfs -put   etc/hadoop/*.xml /input  # 添加文件到新建的目录中
```

运行测试程序
```
/hadoop-3.2.2/bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.2.jar wordcount /input /output
```

查看结果
```
/hadoop-3.2.2/bin/hdfs dfs -cat /output/*
```

清理目录
```
/hadoop-3.2.2/bin/hdfs dfs -rm -r /output
```
