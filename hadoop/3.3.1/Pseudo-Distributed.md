# 参考
- https://blog.csdn.net/l1682686/article/details/107713274
- https://hadoop.apache.org/docs/stable/index.html

# 1. 构建基础镜像
```
docker build -f Pseudo-Distributed.dockerfile -t openjdk8_hadoop_pseudo-distributed:3.3.1 .
```

# 2. 启动
```
docker run --rm --name hadoop331_pseudo-distributed -w /hadoop-3.3.1 --net host -it openjdk8_hadoop_pseudo-distributed:3.3.1
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
/hadoop-3.3.1/bin/hdfs dfs -mkdir /data
```

添加文件到新建的目录中
```
echo "hello" >> test.txt
/hadoop-3.3.1/bin/hdfs dfs -put test.txt /data
```

在 http://localhost:9870/ 的 Utilities->Browse the file system 中查看
