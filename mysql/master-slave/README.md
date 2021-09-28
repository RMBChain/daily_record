# 参考
https://www.jianshu.com/p/ab20e835a73f

# 准备环境
```
docker network create -d bridge mysql_network
docker rm -f mysql-master mysql-slave1 mysql-slave2

docker build -f my-master.dockerfile -t mysql-5.7:master .
docker build -f my-slave1.dockerfile -t mysql-5.7:slave1 .
docker build -f my-slave2.dockerfile -t mysql-5.7:slave2 .
```

# 启动master
```
docker run -d -p 3340:3306 --name mysql-master --hostname mysql-master --network mysql_network -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_ROOT_HOST='%' mysql-5.7:master
docker logs -f mysql-master
```

# 在master上设置slave的账号
```
docker exec -it mysql-master mysql -u root -p
CREATE USER 'slave'@'%' IDENTIFIED BY '123456';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'slave'@'%';
show master status; # *记住 File 和 Position 对应的值，下面的 master_log_file 和 master_log_pos 有用到*
```

# slave1-启动
```
docker run -p 3341:3306 --name mysql-slave1 --hostname mysql-slave1 --network mysql_network -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_ROOT_HOST='%' -d mysql-5.7:slave1
docker logs -f mysql-slave1
```

# slave1-配置
```
docker exec -it mysql-slave1 mysql -u root -p
change master to master_host='mysql-master', master_user='slave', master_password='123456', master_port=3306, master_log_file='mysql-bin.000003', master_log_pos=617, master_connect_retry=30;
show slave status \G;
start slave;
show slave status \G;
```

# slave2-启动
```
docker run -p 3342:3306 --name mysql-slave2 --hostname mysql-slave2 --network mysql_network -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_ROOT_HOST='%' -d mysql-5.7:slave2
docker logs -f mysql-slave2
```

# slave2-配置
```
docker exec -it mysql-slave2 mysql -u root -p
change master to master_host='mysql-master', master_user='slave', master_password='123456', master_port=3306, master_log_file='mysql-bin.000003', master_log_pos=617, master_connect_retry=30;
show slave status \G;
start slave;
show slave status \G;
```

# 测试
```
docker exec -it mysql-master mysql -u root -p
create database aa;
show databases;
```
