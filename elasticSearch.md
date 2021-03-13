
查看集群健康状态
  curl -X GET 'http://localhost:9200/_cluster/health'

查看所有索引及状态
  curl -X GET 'http://localhost:9200/_cat/indices?v'

查看所有索引和字段
  curl 'localhost:9200/_mapping?pretty=true'

删除索引
  curl -X DELETE 'localhost:9200/person'

单节点 Elasticsearch 健康状态为 yellow 问题的解决
  curl -X PUT "localhost:9200/_settings" -H 'Content-Type: application/json' -d'{"number_of_replicas":0}'

创建索引并指定filed数据类型
  curl -X DELETE 'localhost:9200/person'  //先删除
  curl -X PUT "localhost:9200/person?pretty" -H 'Content-Type: application/json' -d'
  {
  "mappings": {
      "_doc": {
       "properties": {
          "userName": { "type":  "text" },
          "age":      { "type":  "long" },
          "birthDay": { "type":  "date" },
          "desc":     { "type":  "text" }
        }
      }
  }
  }'

创建初始数据
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p11' -d '{"userName": "1刘一", "age":6, "lesson": ["11","12","13"], "birthDay":"2015-06-01", "desc": "数据库管理"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p12' -d '{"userName": "2王二", "age":5, "lesson": ["12"],           "birthDay":"2016-06-02", "desc": "软件设计"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p13' -d '{"userName": "3张三", "age":4, "lesson": ["11","13"],      "birthDay":"2017-06-03", "desc": "java php"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p14' -d '{"userName": "5李四", "age":3, "lesson": ["12","13"],      "birthDay":"2018-06-04", "desc": "php"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/person/_doc/p15' -d '{"userName": "6赵五", "age":2, "lesson": ["13"],           "birthDay":"2019-06-05", "desc": "java"}' 

  curl -X PUT -H 'content-type: application/json' 'localhost:9200/lesson/_doc/l11' -d '{  "id": 11,  "title": "java"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/lesson/_doc/l12' -d '{  "id": 12,  "title": "php"}' 
  curl -X PUT -H 'content-type: application/json' 'localhost:9200/lesson/_doc/l13' -d '{  "id": 13,  "title": ".net"}' 

根据id取得数据
  // 返回数据
  curl -X GET 'localhost:9200/person/_doc/p11?pretty=true'
  // 返回数据是否存在
  curl -X GET 'localhost:9200/person/_doc/p11?_source=false&pretty=true'

取age的平均数
  curl -X GET 'localhost:9200/person/_search?pretty' -H 'Content-Type: application/json' -d '{"size": 0, "aggs": { "average_of_age": { "avg": { "field": "age" } } } }'

取age的最大数
  curl -X GET 'localhost:9200/person/_search?pretty' -H 'Content-Type: application/json' -d '{"size": 0, "aggs": { "max_age": { "max": { "field": "age" } } } }'

取age的最小数
  curl -X GET 'localhost:9200/person/_search?pretty' -H 'Content-Type: application/json' -d '{"size": 0, "aggs": { "max_age": { "min": { "field": "age" } } } }'

取age的总和
  curl -X GET 'localhost:9200/person/_search?pretty' -H 'Content-Type: application/json' -d '{"size": 0, "aggs": { "sum_age": {"sum": {"field": "age"}}}}'

取age>4的总和
  curl -X GET 'localhost:9200/person/_search?pretty' -H 'Content-Type: application/json' -d '{
    "size": 0,
    "query": {
      "bool":{
        "must":[{"range":{"age":{"gt":4}}}],
        "must_not":[],"should":[]      
      }
    },
    "aggs": { "sum_age": { "sum": { "field": "age" } } }
  }'

取"birthDay"<:"2017-06-03"的 age 的总和
  curl -X GET 'localhost:9200/person/_search?pretty' -H 'Content-Type: application/json' -d '{
    "size": 0,
    "query": {
      "bool":{
        "must":[{"range":{"birthDay":{"gt":"2016-06-03"}}}],
        "must_not":[],"should":[]      
      }
    },
    "aggs": { "sum_age": { "sum": { "field": "age" } } }
  }'

取"birthDay"<:"2017-06-03"的 age 的sum,max.min
  curl -X GET 'localhost:9200/person/_search?pretty' -H 'Content-Type: application/json' -d '{
    "size": 0,
    "query": {
      "bool":{
        "must":[{"range":{"birthDay":{"gt":"2016-06-03"}}}],
        "must_not":[],"should":[]      
      }
    },
    "aggs": {
      "sum_age": { "sum": { "field": "age" } },
      "max_age": { "max": { "field": "age" } },
      "min_age": { "min": { "field": "age" } }
    }
  }'

取得数据数量
  curl -X GET "localhost:9200/lesson/_count?pretty"
  curl -X GET "localhost:9200/lesson/_doc/_count?pretty"  

