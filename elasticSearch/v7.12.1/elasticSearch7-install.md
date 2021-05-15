# ################################################################################################

官    网: https://www.elastic.co/cn/

下    载: https://www.elastic.co/cn/downloads/past-releases

jdbc下载: https://www.elastic.co/cn/downloads/past-releases#jdbc-client

dbViewer: https://download.dbeaver.com/community/21.0.0/dbeaver-ce-21.0.0-x86_64-setup.exe

# ################################################################################################

# 下载镜像

```
docker pull elasticsearch:7.11.2
docker pull kibana:7.11.2
docker pull mobz/elasticsearch-head:5

```

# 安装单节点es7

```
# mkdir es_data && chmod 777 es_data
# mkdir es_logs && chmod 777 es_logs

docker rm -f es7
docker run -d --restart always                \
       --name es7                             \
       -p 9200:9200                           \
       -p 9300:9300                           \
       -e "discovery.type=single-node"                 `# 配置单节点`           \
       -e "http.cors.enabled=true"                     `# 配置跨域`             \
       -e "http.cors.allow-origin=*"                   `# 配置跨域`             \
       -e "http.cors.allow-headers=Authorization"      `# 跨域允许设置的头信息` \
       -e "xpack.security.enabled=true"                `# 配置x-pack`           \
       -e "xpack.security.transport.ssl.enabled=true"  `# 配置x-pack`           \
       -e "xpack.security.transport.ssl.enabled=true"  `# 配置x-pack`           \
       -e "ES_JAVA_OPTS=-Xms512m -Xmx512m"             `# java配置`             \
       -v $PWD/es_data:/usr/share/elasticsearch/data  `# 配置数据路径` \
       -v $PWD/es_logs:/usr/share/elasticsearch/logs  `# 配置日志路径` \
       elasticsearch:7.12.1

docker logs -f es7

# 生成密码
docker exec -it es7 bash
cd /usr/share/elasticsearch/bin
./elasticsearch-setup-passwords interactive


# 通过 curl 进行访问
curl --user elastic:123456 'http://localhost:9200/?pretty'
curl --user elastic:123456  -XPUT 'http://localhost:9200/test1?pretty'
curl --user elastic:123456  -H "Content-Type: application/json" -X POST 'http://localhost:9200/test1/_doc/11' -d '{ "txt": "just test11", "age":121}'
curl --user elastic:123456  -H "Content-Type: application/json" -X POST 'http://localhost:9200/test1/_doc/12' -d '{ "txt": "just test12", "age":121}'
curl --user elastic:123456  -H "Content-Type: application/json" -X POST 'http://localhost:9200/test1/_doc/13' -d '{ "txt": "just test13", "age":123}'

curl --user elastic:123456  -H "Content-Type: application/json" -X POST 'http://localhost:9200/test1/_doc/_search?pretty' -d '{"query":{"bool":{"must":[{"match":{"age":121}}]}}}'


# 使用sql进行查询
curl --user elastic:123456  -H "Content-Type: application/json" -X POST 'http://localhost:9200/_sql?format=json&pretty' -d '{"query": "SELECT txt,age FROM test LIMIT 10"}'
curl --user elastic:123456  -H "Content-Type: application/json" -X POST 'http://localhost:9200/_sql?format=json&pretty' -d '{"query": "SELECT txt,age FROM test LIMIT 10 WHERE age=121"}'

# 使用sql cli
docker exec -it es7 bash
cd /usr/share/elasticsearch/bin
./elasticsearch-sql-cli http://elastic:123456@localhost:9200

```

# 安装集群es 注意 network.bind_host 和 network.publish_host 的作用
```
# run on ip____1
cd /chain_net
rm -r -f es_data && mkdir es_data && chmod 777 es_data
rm -r -f es_logs && mkdir es_logs && chmod 777 es_logs
docker rm -f esrepo_cluster_node_1
docker run -d --restart always                \
       --name esrepo_cluster_node_1           \
       --network host                         \
       -e "discovery.zen.ping.unicast.hosts=ip____2"  `# 配置其它节点` \
       -e cluster.name=esrepo-cluster                       `# 配置跨域`   \
       -e "network.bind_host=0.0.0.0"                       `# 配置跨域`   \
       -e "network.publish_host=ip____1"                       `# 配置跨域`   \
       -e "node.name=esrepo_cluster_node_1"                 `# 配置跨域`   \
       -e "http.cors.enabled=true"                          `# 配置跨域`   \
       -e "http.cors.allow-origin=*"                        `# 配置跨域`   \
       -e "ES_JAVA_OPTS=-Xms512m -Xmx512m"                  `# java配置`   \
       -v $PWD/es_data:/usr/share/elasticsearch/data  `# 配置数据路径` \
       -v $PWD/es_logs:/usr/share/elasticsearch/logs  `# 配置日志路径` \
       elasticsearch:6.8.13
docker logs -f esrepo_cluster_node_1

# run on ip____2
cd /chain_net
rm -r -f es_data && mkdir es_data && chmod 777 es_data
rm -r -f es_logs && mkdir es_logs && chmod 777 es_logs
docker rm -f esrepo_cluster_node_2
docker run -d --restart always                \
       --name esrepo_cluster_node_2           \
       --network host                         \
       -e "discovery.zen.ping.unicast.hosts=ip____1"  `# 配置其它节点` \
       -e cluster.name=esrepo-cluster                       `# 配置跨域`   \
       -e "network.bind_host=0.0.0.0"                       `# 配置跨域`   \
       -e "network.publish_host=ip____2"                       `# 配置跨域`   \
       -e "node.name=esrepo_cluster_node_2"                 `# 配置跨域`   \
       -e "http.cors.enabled=true"                          `# 配置跨域`   \
       -e "http.cors.allow-origin=*"                        `# 配置跨域`   \
       -e "ES_JAVA_OPTS=-Xms512m -Xmx512m"                  `# java配置`   \
       -v $PWD/es_data:/usr/share/elasticsearch/data  `# 配置数据路径` \
       -v $PWD/es_logs:/usr/share/elasticsearch/logs  `# 配置日志路径` \
       elasticsearch:6.8.13
docker logs -f esrepo_cluster_node_2

curl http://127.0.0.1:9200/_cat/health	
curl -H "Content-Type: application/json" -X POST 'http://localhost:9200/test_index/doc/11' -d '{ "txt": "just test"}'
curl 'http://localhost:9200/test_index/doc/11'


curl -X PUT -H "Content-Type: application/json" 'http://localhost:9200/test_index'     -d '{  "settings":{    "number_of_shards":5,    "number_of_replicas":2,    "max_result_window": "100000"  }}'
curl http://localhost:9200/_cluster/health?pretty
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

