# 伪分布式 参考
- https://blog.csdn.net/l1682686/article/details/107713274
- https://hadoop.apache.org/docs/stable/index.html

# 1. 构建基础镜像
## 运行镜像
```
docker run --rm --name openjdk8_hadoop331 -it openjdk:8u292-jdk bash
```

## 安装软件
```
apt-get -y update
apt-get -y install openssh-server vim
```

## 配置ssh
修改 /etc/ssh/sshd_config
```
vim /etc/ssh/sshd_config
```

修改完如下
```
PermitRootLogin yes
PubkeyAuthentication yes
AuthorizedKeysFile   .ssh/authorized_keys .ssh/authorized_keys2
```
重启服务
```
service ssh restart
```

## 生成证书，以便免密登录
```
mkdir ~/.ssh && cd ~/.ssh
ssh-keygen -t rsa -N '' -f id_rsa -q # 免交互
cat id_rsa.pub >> authorized_keys
cat authorized_keys

ssh localhost # 验证
```


## 下载hadoop
```
cd /
wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.1.tar.gz
tar -zxvf hadoop-3.3.1.tar.gz
rm hadoop-3.3.1.tar.gz
```


## 保存为基础镜像:openjdk8_hadoop:3.3.1
在宿主机另开一个窗口执行。
```
docker commit openjdk8_hadoop331 openjdk8_hadoop:3.3.1
docker rm -f openjdk8_hadoop331
```


# 2. 启动容器
```
docker run -it --rm -w /hadoop-3.3.1 --name hadoop --hostname hadoop -p 9870:9870 -p 9000:9000 -p 9864:9864 openjdk8_hadoop:3.3.1 bash
service ssh restart
```


# 3. 查看hadoop版本
在容器内执行
```
cd /hadoop-3.3.1
bin/hadoop version
```


# 4. 设置配置文件
在宿主机执行
```
docker cp Pseudo-Distributed/core-site.xml   hadoop:/hadoop-3.3.1/etc/hadoop/
docker cp Pseudo-Distributed/hdfs-site.xml   hadoop:/hadoop-3.3.1/etc/hadoop/
docker cp Pseudo-Distributed/mapred-site.xml hadoop:/hadoop-3.3.1/etc/hadoop/
docker cp Pseudo-Distributed/yarn-site.xml   hadoop:/hadoop-3.3.1/etc/hadoop/
docker cp Pseudo-Distributed/hadoop-env.sh   hadoop:/hadoop-3.3.1/etc/hadoop/
```

# 6. 启动hadoop
在容器内执行
```

mkdir -p /root/data/dfs/name
mkdir -p /root/data/data/dfs/data

export HADOOP_SECURE_DN_USER=root 
export HDFS_NAMENODE_USER=root 
export HDFS_SECONDARYNAMENODE_USER=root 
export YARN_RESOURCEMANAGER_USER=root 
export YARN_NODEMANAGER_USER=root

/hadoop-3.3.1/bin/hadoop namenode -format # 格式化namenode

/hadoop-3.3.1/sbin/start-all.sh
# /hadoop-3.3.1/sbin/stop-all.sh
```

使用jps查看服务
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


# 7. 访问WEB
http://localhost:9870/


# 8. 测试：
添加目录
```
/hadoop-3.3.1/bin/hdfs dfs -mkdir /data
```

添加文件到新建的目录中
```
echo "hello" >> test.txt
/hadoop-3.3.1/bin/hdfs dfs -put test.txt /data
```
