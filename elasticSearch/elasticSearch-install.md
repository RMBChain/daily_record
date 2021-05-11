# ################################################################################################

官    网: https://www.elastic.co/cn/

下    载: https://www.elastic.co/cn/downloads/past-releases

jdbc下载: https://www.elastic.co/cn/downloads/past-releases#jdbc-client

dbViewer: https://download.dbeaver.com/community/21.0.0/dbeaver-ce-21.0.0-x86_64-setup.exe

# ################################################################################################

# 下载镜像

```
docker pull kibana:6.8.13
docker pull elasticsearch:6.8.13
docker pull mobz/elasticsearch-head:5
```

# 安装单节点es

```
docker rm -f es6
docker run -d --restart always                \
       --name es6                             \
       -p 9200:9200                           \
       -p 9300:9300                           \
       -e "discovery.type=single-node"   `# 配置单节点` \
       -e "http.cors.enabled=true"       `# 配置跨域`   \
       -e "http.cors.allow-origin=*"     `# 配置跨域`   \
       -v /home/es_data:/usr/share/elasticsearch/data  `# 配置数据路径` \
       elasticsearch:6.8.13

curl http://127.0.0.1:9200/_cat/health	
curl -H "Content-Type: application/json" -X POST 'http://localhost:9200/test_index/doc/11' -d '{ "txt": "just test"}'
curl 'http://localhost:9200/test_index/doc/11'
```

# 扩大虚拟内存空间
```
vim /etc/sysctl.conf
//在最后一行上加上
vm.max_map_count=262144
//保存退出，加载配置，启动容器，就能够访问了
// wsl2 重启: sysctl -p
```

# 设置允许跨域访问：在 /usr/share/elasticsearch/config/elasticsearch.yml里面添加如下代码： 
```
docker exec -it es6 bash 
echo "http.cors.enabled: true"    >> /usr/share/elasticsearch/config/elasticsearch.yml 
echo 'http.cors.allow-origin: "*"'>> /usr/share/elasticsearch/config/elasticsearch.yml

# 集群配置 begin
echo 'cluster.name: es-cluster'   >> /usr/share/elasticsearch/config/elasticsearch.yml
echo 'node.name: node02'          >> /usr/share/elasticsearch/config/elasticsearch.yml
echo 'node.master: true'          >> /usr/share/elasticsearch/config/elasticsearch.yml
echo 'node.data: true'            >> /usr/share/elasticsearch/config/elasticsearch.yml
echo 'network.host: 0.0.0.0'      >> /usr/share/elasticsearch/config/elasticsearch.yml
echo 'http.port: 9200'            >> /usr/share/elasticsearch/config/elasticsearch.yml
echo 'discovery.zen.ping.unicast.hosts: ["192.168.50.150","192.168.50.151"]' >> /usr/share/elasticsearch/config/elasticsearch.yml
echo 'discovery.zen.minimum_master_nodes: 2'                                 >> /usr/share/elasticsearch/config/elasticsearch.yml
# 集群配置 end
exit
docker restart es6
```

#### 下载 kibana
```
docker pull kibana:7.11.1

docker pull kibana:6.8.14

docker pull kibana:6.8.13

docker rm -f kibana

docker run -it --net=host -e ELASTICSEARCH_HOSTS=http://localhost:9200 -p 5601:5601 --name kibana -d kibana:6.8.14

docker run -it --link es6 -e ELASTICSEARCH_HOSTS=http://es6:9200 -p 5601:5601 --name kibana -d kibana:6.8.14
```

#### 下载 elasticsearch-head:5
```

docker pull mobz/elasticsearch-head:5

docker run -it -d --restart always --name es6_head -p 9100:9100 mobz/elasticsearch-head:5

## 修改 406 问题： 修改 /usr/src/app/_site/vendor.js 中的 contentType
# 将vendor.js拷贝出来

docker cp es6_head:/usr/src/app/_site/vendor.js .

# 修改 vendor.js 文件

vi vendor.js

// 将 6886行 contentType: "application/x-www-form-urlencoded"                           修改为 contentType: "application/json;charset=UTF-8"

// 将 7574行 var inspectData = s.contentType === "application/x-www-form-urlencoded" && 修改为 var inspectData = s.contentType === "application/json;charset=UTF-8" &&

# 将vendor.js放回去

docker cp vendor.js es6_head:/usr/src/app/_site/vendor.js

# ctrl + F5 强制刷新浏览器
```

