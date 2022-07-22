## bug

### kibana启动失败

`docker logs 容器id`查看启动日志

报错：tags":["reporting","esqueue","queue-worker","error"],"pid":7,"message":"l426lv84000720f758ejv40x - job querying failed: Error: Request Timeout after 30000ms\n  

解决：

```
docker inspect elasticsearch |grep IPAddress
#不能使用公网ip，使用内网es分配的ip启动kibana
#启动kibana
docker run --name kibana -e ELASTICSEARCH_HOSTS=http://上一步查出来的ip:9200 -p 5601:5601 -d kibana:7.6.2
```

