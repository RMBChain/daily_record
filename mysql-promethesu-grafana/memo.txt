原文：https://www.cnblogs.com/myzony/p/10253986.html

卸载：
    docker-compose -f ./docker-compose.yml -p MySQL-Monitor down
安装：
    docker-compose -f ./docker-compose.yml -p MySQL-Monitor up -d

进入mysql：
    docker exec -it test-mysql mysql -u root -p 

进入mysql后，给root赋权远程连接：
    GRANT ALL PRIVILEGES ON *.* to 'root'@'localhost' IDENTIFIED BY 'root';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'         IDENTIFIED BY 'root';
    flush privileges;

稍等一会（如果grafana挺掉了，启动一下），然后访问：
    http://localhost:20002

需要输入的内容:
    prometheus
    http://prometheus:9090
