# ��ȫ�ֲ�ʽ �ο�
- https://blog.csdn.net/l1682686/article/details/107814620
- https://hadoop.apache.org/docs/stable/index.html

�ɿ�: �ڵ���������Ʋ�Ҫ���κο������ر���ַ������ȫӢ�� *Сд* ��ĸ�����֣�ǧ��Ҫ�С�-������_������%���ȵȡ�


# 1. ������������
```
docker build -f spark-cluster.dockerfile -t spark-3.1.2-bin-hadoop3.2:v1 .
# docker build --no-cache -f spark-cluster.dockerfile -t openjdk8_hadoop_cluster:3.3.1 .
```

# 2. �������ڵ�
*name������master���������ļ���һ��*
```
docker rm -f master
docker rm -f work1
docker rm -f work2
docker rm -f work3

docker network create -d bridge hadoop_network
docker run -it --rm -w /hadoop-3.3.1 --name master --hostname master    \
       --network hadoop_network                                         \
       -p 9870:9870 -p 9000:9000 -p 9864:9864 -p 9866:9866 -p 8088:8088 \
       openjdk8_hadoop_cluster:3.3.1

```


# 2. ����worker�ڵ�
```
docker run -it --rm -w /hadoop-3.3.1 --name work1 --hostname work1 --network hadoop_network openjdk8_hadoop_cluster:3.3.1
docker run -it --rm -w /hadoop-3.3.1 --name work2 --hostname work2 --network hadoop_network openjdk8_hadoop_cluster:3.3.1
docker run -it --rm -w /hadoop-3.3.1 --name work3 --hostname work3 --network hadoop_network openjdk8_hadoop_cluster:3.3.1
```


# 3. �鿴hadoop�汾
��������ִ��
```
cd /hadoop-3.3.1
bin/hadoop version
```


# 4. ʹ��jps�鿴����
```
jsp
```

Ӧ��������6��:
```
NameNode
DataNode
Jps
NodeManager
SecondaryNameNode
ResourceManager
```


# 5. ����WEB
http://localhost:9870/


# 6. ���ԣ�

```
cd /hadoop-3.3.1
/hadoop-3.3.1/bin/hdfs dfs -mkdir /input                   # ���Ŀ¼
/hadoop-3.3.1/bin/hdfs dfs -put   etc/hadoop/*.xml /input  # ����ļ����½���Ŀ¼��
/hadoop-3.3.1/bin/hdfs dfs -put   share/ /input            # ����ļ����½���Ŀ¼��
```

�� http://localhost:9870/ �� Utilities->Browse the file system �в鿴

���в��Գ���
```
/hadoop-3.3.1/bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar wordcount /input /output
```

�鿴���
```
/hadoop-3.3.1/bin/hdfs dfs -cat /output/*
```

����Ŀ¼
```
/hadoop-3.3.1/bin/hdfs dfs -rm -r /output
```
