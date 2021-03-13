
查看集群健康状态
  curl -X GET 'http://localhost:9200/_cluster/health'

查看所有索引及状态
  curl -X GET 'http://localhost:9200/_cat/indices?v'

查看所有索引和字段
  curl 'localhost:9200/_mapping?pretty=true'

删除索引
  curl -X DELETE 'localhost:9200/person1'

单节点 Elasticsearch 健康状态为 yellow 问题的解决
  curl -X PUT "localhost:9200/_settings" -H 'Content-Type: application/json' -d'{"number_of_replicas":0}'

创建初始数据
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p11' -d '{"user": "张1三", "lesson": "11", "birthDay":"2020-06-01", "desc": "数据库管理 "}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p12' -d '{"user": "张2三", "lesson": "11", "birthDay":"2020-06-02", "desc": "软件设计"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p13' -d '{"user": "张3三", "lesson": "12", "birthDay":"2020-06-03", "desc": "java php"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p14' -d '{"user": "张4三", "lesson": "12", "birthDay":"2020-06-04", "desc": "php"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p15' -d '{"user": "张5三", "lesson": "13", "birthDay":"2020-06-05", "desc": "java"}' 

  curl -X PUT -H 'content-type: application/json' 'localhost:9200/lesson/_doc/l11' -d '{  "id": 11,  "title": "java"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/lesson/_doc/l12' -d '{  "id": 12,  "title": "php"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/lesson/_doc/l13' -d '{  "id": 13,  "title": ".net"}' 










curl localhost:9200/lesson/_doc/l11?_source=false
curl localhost:9200/lesson/_doc/l11?_source_includes=id
curl localhost:9200/lesson/_doc/l11?_source_includes=id,title&_source_excludes=entities



curl -X POST "localhost:9200/lesson/_doc?pretty" -H 'Content-Type: application/json' -d'
{
   "mappings": {
      "_doc": {
         "properties": {
            "id": {
               "type": "integer",
               "store": false
            },
            "title": {
               "type": "keyword",
               "store": true
            }
         }
      }
   }
}'

curl GET localhost:9200/lesson/_doc/1?stored_fields=id,title

curl -X DELETE "localhost:9200/lesson/_doc/l11"


curl -X GET "localhost:9200/_mget?pretty" -H 'Content-Type: application/json' -d'
{
    "docs" : [
        {
            "_index" : "lesson",
            "_type" : "_doc",
            "_id" : "l12",
            "stored_fields" : ["id", "title"]
        }
    ]
}
'


curl -X GET "localhost:9200/lesson/_doc/_count" 

curl -X POST "localhost:9200/lesson/_search?size=0&pretty" -H 'Content-Type: application/json' -d'
{
    "aggs" : {
        "avg_grade" : { "avg" : { "field" : "id" } }
    }
}
'


curl -X POST "localhost:9200/lesson/_search?size=0&pretty" -H 'Content-Type: application/json' -d'
{
    "aggs" : {
        "avg_grade" : { "max" : { "field" : "id" } }
    }
}
'



