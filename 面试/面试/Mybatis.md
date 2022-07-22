## Mybatis

> 题目：https://blog.csdn.net/a745233700/article/details/80977133

### 1.MyBatis 是什么框架?

MyBatis 是一款优秀的持久层框架。

- 支持自定义 SQL、存储过程以及高级映射
- 免除了几乎所有的 JDBC 代码以及设置参数和获取结果集的工作
- 通过简单的 XML 或注解来配置和映射原始类型、接口和 Java POJO（Plain Old Java Objects，普通老式 Java 对象）为数据库中的记录

### 2.MyBatis 和 ORM的区别?

ORM（Object Relational Mapping）：对象关系映射，简单点说就是将数据库中的表和java中的对象建立映射关系，可以让我们操作对象来间接的操作数据库。

mybatis属于半自动orm，因为sql语句需要自己写。

与其他比较标准的 ORM 框架（比如 Hibernate ）不同， mybatis 并没有将 java 对象与数据库关联起来，而是将 java 方法与 sql语句关联起来，mybatis 允许用户充分利用数据库的各种功能，例如存储、视图、各种复杂的查询以及某些数据库的专有特性。

自己写 sql 语句的好处是，可以根据自己的需求，写出最优的 sql 语句。灵活性高。但是，由于是自己写 sql 语句，导致平台可移植性不高。MySQL 语句和 Oracle 语句不同

### 3.MyBatis为什么是半自动ORM映射?

Hibernate 属于全自动 ORM 映射工具，使用 Hibernate 查询关联对象或者关联集合对象时，可以根据对象关系模型直接获取，所以它是全自动的。而 Mybatis 在查询关联对象或关联集合对象时，需要手动编写 sql 来完成，所以，称之为半自动 ORM 映射工具。

### 4.MyBatis 框架的应用场景?

MyBatis 专注于 SQL 本身，是一个足够灵活的 DAO 层解决方案。
对性能的要求很高，或者需求变化较多的项目，如互联网项目，

### 5.MyBatis 有哪些优点?

1.与JDBC相比，减少了50%以上的代码量。

2.MyBatis是最简单的持久化框架，小巧并且简单易学。

3.MyBatis相当灵活，不会对应用程序或者数据库的现有设计强加任何影响，SQL写在XML里，从程序代码中彻底分离，降低耦合度，便于统一管理和优化，并可重用。

4.提供XML标签，支持编写动态SQL语句。

5.提供映射标签，支持对象与数据库的ORM字段关系映射。

### 6.MyBatis 有哪些缺点?

1.SQL语句的编写工作量较大，尤其是字段多、关联表多时，更是如此，对开发人员编写SQL语句的功底有一定要求。

2.SQL语句依赖于数据库，导致数据库移植性差，不能随意更换数据库。

### 7.MyBatis 和 Hibernate 的区别?

- MyBatis 不完全是一个 ORM 框架，它需要程序员自己编写 SQL；Hibernate 可以做到无 SQL 对数据库进行操作
- MyBatis 直接编写原生 SQL，可以严格控制 SQL 执行性能，灵活度高，快速响应需求变化；Hibernate 会根据模型配置自动生成和执行 SQL 语句，面对多变的需求，灵活度没那么高
- MyBatis 书写 SQL 可能依赖数据库特性，导致应用程序数据库可移植性差；Hibernate 可以屏蔽掉数据库差异，数据库可移植性好
- MyBatis 考验程序编写 SQL 的功底，编写大量 SQL，效率可能不高；Hibernate 对象关系映射能力强，可以节省很多代码，提高开发效率
- MyBatis 没法根据模型自动初始化数据库中的表；Hibernate 是根据模型的配置生成 DDL 语句在数据库中自动初始化对应表、索引、序列等

### 8.MyBatis 和 JPA的区别?

jpa（Java Persistence API）是java持久化规范，是orm框架的标准，主流orm框架都实现了这个标准。

- ORM是一种思想，是插入在应用程序与JDBC API之间的一个中间层，JDBC并不能很好地支持面向对象的程序设计，ORM解决了这个问题，通过JDBC将字段高效的与对象进行映射。具体实现有**hibernate、spring data jpa、open jpa。**

mybatis也是一个持久化框架，但不完全是一个orm框架，不是依照的jpa规范

- 可以进行更细致的SQL优化,查询必要的字段,但是需要维护SQL和查询结果集的映射,而且数据库的移植性较差,针对不同的数据库编写不同的SQL

### 9.MyBatis有哪几种SQL编写形式?

- xml
- 注解

### 10.MyBatis支持哪些传参数的方法?

1. 顺序传参
2. @Param 传参
3. Map 传参
4. Java Bean 传参

> https://blog.csdn.net/moakun/article/details/80057181

### 11.MyBatis的$和#传参的区别?

${}是字符串替换，#{}是预处理；

Mybatis在处理${}时，就是把${}直接替换成变量的值。而Mybatis在处理#{}时，会对sql语句进行预处理，将sql中的#{}替换为?号，调用PreparedStatement的set方法来赋值；

使用#{}可以有效的防止SQL注入，提高系统安全性，预编译还能提高性能。但不是一定会防止 SQL 注入

预编译本质上使用转义符号，但是并不会对 **%** 进行转义，所以当模糊匹配时有可能发生 SQL 注入问题。正确写法：` select * from t_user where name like concat('%', #{name}, '%')`

> https://blog.csdn.net/a745233700/article/details/80977133

### 12.MyBatis 可以映射到枚举类吗?

https://segmentfault.com/a/1190000010755321

https://cloud.tencent.com/developer/article/1407575

### 13.MyBatis怎么封装动态 SQL?



### 14.Mybatis trim标签有什么用?

### 15.MyBatis 怎么实现分页?

> https://xie.infoq.cn/article/0331e0f0107915b136ef79b34
>
> https://www.w3cschool.cn/mybatis/mybatis-ypsj3bpi.html

### 16.MyBatis 流式查询有什么用?

**流式查询**指的是查询成功后不是返回一个集合而是返回一个迭代器，应用每次从迭代器取一条查询结果。流式查询的好处是能够降低内存使用。

> https://segmentfault.com/a/1190000022478915

### 17.MyBatis 模糊查询 like 语句该怎么写?

方式1：$ 这种方式，简单，但是无法防止SQL注入，所以不推荐使用

`  LIKE '%${name}%'`

方式2：#

`  LIKE "%"#{name}"%"`

方式3：字符串拼接

`AND name LIKE CONCAT(CONCAT('%',#{name},'%'))`

方式4：bind标签

```xml
<select id="searchStudents" resultType="com.example.entity.StudentEntity"
  parameterType="com.example.entity.StudentEntity">
  <bind name="pattern1" value="'%' + _parameter.name + '%'" />
  <bind name="pattern2" value="'%' + _parameter.address + '%'" />
  SELECT * FROM test_student
  <where>
   <if test="age != null and age != '' and compare != null and compare != ''">
   age
    ${compare}
    #{age}
   </if>
   <if test="name != null and name != ''">
    AND name LIKE #{pattern1}
   </if>
  <if test="address != null and address != ''">
    AND address LIKE #{pattern2}
    </if>
  </where>
  ORDER BY id
 </select>
```

方式5：java代码里写

param.setUsername("%CD%"); 在 java 代码中传参的时候直接写上

```
           <if test="username!=null"> AND username LIKE #{username}</if>
```

然后 mapper 里面直接写 #{} 就可以了

> https://m.w3cschool.cn/mybatis/mybatis-ufvq3br0.html

### 18.MyBatis 配置文件中的 SQL id 是否能重复?

不同的 Xml 映射文件，如果配置了 `namespace`，那么 `id` 可以重复；如果没有配置 `namespace`，那么 `id` 不能重复。

原因就是 `namespace`+`id` 是作为 `Map<String, MapperStatement>`的 key使用的，如果没有 `namespace`，就剩下 `id`，那么，`id` 重复会导致数据互相覆盖。

有了 `namespace`，自然 `id` 就可以重复，`namespace` 不同，`namespace`+`id` 自然也就不同。

### 19.MyBatis 如何防止 SQL注入?

\#{}：相当于JDBC中的PreparedStatement

### 20.MyBatis 如何获取自动生成的主键id?

在 insert 语句添加 `useGeneratedKeys="true" keyProperty="id" ` ，返回的是行数，主键在插入对象中自动生成。

https://blog.csdn.net/bestfeng1020/article/details/60963948

### 21.MyBatis 使用了哪些设计模式?

### 22.MyBatis 中的缓存机制有啥用?

缓存就是存储数据的一个地方（称作：Cache），当程序要读取数据时，会首先从缓存中获取，有则直接返回，否则从其他存储设备中获取，**缓存最重要的一点就是从其内部获取数据的速度是非常快的，通过缓存可以加快数据的访问速度。比如我们从db中获取数据，中间需要经过网络传输耗时，db server从磁盘读取数据耗时等，如果这些数据直接放在jvm对应的内存中，访问是不是会快很多。**

通常情况下mybatis会访问数据库获取数据，中间涉及到网络通信，数据库从磁盘中读取数据，然后将数据返回给mybatis，总的来说耗时还是挺长的，mybatis为了加快数据查询的速度，在其内部引入了缓存来加快数据的查询速度。

https://tech.meituan.com/2018/01/19/mybatis-cache.html

### 23.MyBatis一级缓存和二级缓存的区别?

一级缓存是SqlSession级别的缓存，在操作数据库时需要构造 sqlSession对象，在对象中有一个数据结构（HashMap）用于存储缓存数据，不同的sqlSession之间的缓存数据区域（HashMap）是互相不影响的。

二级缓存是mapper级别的缓存，多个SqlSession去操作同一个Mapper的sql语句，多个SqlSession可以共用二级缓存，二级缓存是跨SqlSession的。

1. **一级缓存是SqlSession级别的，每个人SqlSession有自己的一级缓存，不同的SqlSession之间一级缓存是相互隔离的**
2. **mybatis中一级缓存默认是自动开启的**
3. **当在同一个SqlSession中执行同样的查询的时候，会先从一级缓存中查找，如果找到了直接返回，如果没有找到会去访问db，然后将db返回的数据丢到一级缓存中，下次查询的时候直接从缓存中获取**
4. **一级缓存清空的3种方式（1：SqlSession中执行增删改会使一级缓存失效；2：调用SqlSession.clearCache方法会使一级缓存失效；3：Mapper xml中的select元素的flushCache属性置为true，那么执行这个查询会使一级缓存失效）**

1. **对应的mapper中执行增删改查会清空二级缓存中数据**
2. **select元素的flushCache属性置为true，会先清空二级缓存中的数据，然后再去db中查询数据，然后将数据再放到二级缓存中**
3. **select元素的useCache属性置为true，可以使这个查询跳过二级缓存，然后去查询数据**

24.MyBatis-Plus是什么框架?