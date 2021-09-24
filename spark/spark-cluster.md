https://blog.csdn.net/lukabruce/article/details/81741888

# 1. 构建基础镜像
```
docker build -f spark-cluster.dockerfile -t spark-3.1.2-bin-hadoop3.2:v1 .
# docker build --no-cache -f spark-cluster.dockerfile -t openjdk8_hadoop_cluster:3.3.1 .
```

# 2. 启动主节点
```
docker network create -d bridge spark_network

docker run -it --name master --hostname master -w /spark-3.1.2-bin-hadoop3.2 --rm --network spark_network -p 8080:8080 -p 7077:7077 spark-3.1.2-bin-hadoop3.2:v1 bash -c "./sbin/start-master.sh && bash"
```

# 2. 启动工作节点
```
docker run -it --name work1 --hostname work1 -w /spark-3.1.2-bin-hadoop3.2 --rm --network spark_network spark-3.1.2-bin-hadoop3.2:v1 bash -c "./sbin/start-worker.sh spark://master:7077 && bash"
docker run -it --name work2 --hostname work2 -w /spark-3.1.2-bin-hadoop3.2 --rm --network spark_network spark-3.1.2-bin-hadoop3.2:v1 bash -c "./sbin/start-worker.sh spark://master:7077 && bash"
docker run -it --name work3 --hostname work3 -w /spark-3.1.2-bin-hadoop3.2 --rm --network spark_network spark-3.1.2-bin-hadoop3.2:v1 bash -c "./sbin/start-worker.sh spark://master:7077 && bash"
```

# 3. 查看状态
http://localhost:8080


# 4. 进入spark-shell
/spark-3.1.2-bin-hadoop3.2/bin/spark-shell
