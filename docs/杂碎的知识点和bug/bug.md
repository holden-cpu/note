# VUE

## vue-element-template嵌套路由失效

进入layout/component/Appmain.vue

取消绑定key值

![image-20210823201847788](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210823201847788.png)

# Mysql

## concat函数连接字符串为null

使用concat_ws(分隔符，字符串1，字符串2…..)

## 字符串分割成”数组“模糊匹配

参考：https://www.cnblogs.com/gered/p/10797012.html

实现：

```sql
select distinct
	字段值
from 表名 a
join mysql.help_topic b
on b.help_topic_id < (length(a.字符串字段) - length(replace(a.字符串字段,"分隔符",""))+1)
where substring_index(substring_index(a.字符串字段,"分隔符",b.help_topic_id),'^',-1) like 
concat("%%")
```

