https://cdmana.com/2021/02/20210219135918048g.html
https://blog.csdn.net/lukabruce/article/details/81741888

# 1. 构建基础镜像
```
docker build -f spark-cluster.dockerfile -t spark-3.1.2-hadoop3.2.2:v1 .

# docker build --no-cache -f spark-cluster.dockerfile -t openjdk8_hadoop_cluster:3.3.1 .
```

# 2. 启动主节点
```
docker network create -d bridge spark_network
docker run -it --name master --hostname master -w /spark-3.1.2          \
       --rm --network spark_network                                     \
       -p 4040:4040 -p 7077:7077 -p 8042:8042 -p 8080:8080 -p 8081:8081 \
       -p 8088:8088 -p 9000:9000 -p 9864:9864 -p 9870:9870              \
       spark-3.1.2-hadoop3.2.2:v1 bash -c "/entyrpoint-master.sh"
```


# 2. 启动工作节点
```
docker run -it --name work1 --hostname work1 -w /spark-3.1.2 --rm -m 1G --network spark_network spark-3.1.2-hadoop3.2.2:v1 bash -c "/entyrpoint-work.sh"
docker run -it --name work2 --hostname work2 -w /spark-3.1.2 --rm -m 1G --network spark_network spark-3.1.2-hadoop3.2.2:v1 bash -c "/entyrpoint-work.sh"
docker run -it --name work3 --hostname work3 -w /spark-3.1.2 --rm -m 1G --network spark_network spark-3.1.2-hadoop3.2.2:v1 bash -c "/entyrpoint-work.sh"

```


# 3. 查看状态
http://localhost:9870  hadoop
http://localhost:8088  yarn
http://localhost:8080  spark


# 4. 测试1
```
/spark-3.1.2/bin/spark-submit --master "spark://master:7077" --class org.apache.spark.examples.SparkPi /spark-3.1.2/examples/jars/spark-examples_2.12-3.1.2.jar
```


# 5. 测试2
```
/hadoop-3.3.1/bin/hdfs dfs -mkdir /input                   # 添加目录
/hadoop-3.3.1/bin/hdfs dfs -put   etc/hadoop/*.xml /input  # 添加文件到新建的目录中
/spark-3.1.2-bin-hadoop3.2/bin/spark-shell                 # 进入spark-shell

待续......

```

