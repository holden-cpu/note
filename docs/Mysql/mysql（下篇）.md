# 变量

**代码中被[]包含的表示可选，|符号分开的表示可选其一。**

我们在使用mysql的过程中，变量也会经常用到，比如查询系统的配置，可以通过查看系统变量来了解，当我们需要修改系统的一些配置的时候，也可以通过修改系统变量的值来进行。

我们需要做一些批处理脚本的时候，可以使用自定义变量，来做到数据的复用。所以变量这块也挺重要，希望大家能够掌握。

### 本文内容

- 详解系统变量的使用
- 详解自定义变量的使用

### 变量分类

- 系统变量
- 自定义变量

### 系统变量

#### 概念

系统变量由系统定义的，不是用户定义的，属于mysql服务器层面的。

#### 系统变量分类

- 全局变量
- 会话变量

#### 使用步骤

##### 查看系统变量

```
//1.查看系统所有变量
show [global | session] variables;
//查看全局变量
show global variables;
//查看会话变量
show session variables;
show variables;
```

> 上面使用了show关键字

##### 查看满足条件的系统变量

> 通过like模糊匹配指定的变量

```
//查看满足条件的系统变量(like模糊匹配)
show [global|session] like '%变量名%';
```

> 上面使用了show和like关键字。

##### 查看指定的系统变量

```
//查看指定的系统变量的值
select @@[global.|session.]系统变量名称;
```

> 注意`select`和`@@`关键字，global和session后面有个.符号。

##### 赋值

```
//方式1
set [global|session] 系统变量名=值;

//方式2
set @@[global.|session.]系统变量名=值;
```

> 注意：
>
> 上面使用中介绍的，全局变量需要添加global关键字，会话变量需要添加session关键字，如果不写，默认为session级别。
>
> 全局变量的使用中用到了`@@`关键字，后面会介绍自定义变量，自定义变量中使用了一个`@`符号，这点需要和全局变量区分一下。

### 全局变量

#### 作用域

mysql服务器每次启动都会为所有的系统变量设置初始值。

我们为系统变量赋值，针对所有会话（连接）有效，可以跨连接，但不能跨重启，重启之后，mysql服务器会再次为所有系统变量赋初始值。

#### 示例

##### 查看所有全局变量

```
/*查看所有全局变量*/
show global variables;
```

##### 查看包含'tx'字符的变量

```
/*查看包含`tx`字符的变量*/
mysql> show global variables like '%tx%';
+---------------+-----------------+
| Variable_name | Value           |
+---------------+-----------------+
| tx_isolation  | REPEATABLE-READ |
| tx_read_only  | OFF             |
+---------------+-----------------+
2 rows in set, 1 warning (0.00 sec)

/*查看指定名称的系统变量的值，如查看事务默认自动提交设置*/
mysql> select @@global.autocommit;
+---------------------+
| @@global.autocommit |
+---------------------+
|                   0 |
+---------------------+
1 row in set (0.00 sec)
```

##### 为某个变量赋值

```
/*为某个系统变量赋值*/
set global autocommit=0;
set @@global.autocommit=1;
mysql> set global autocommit=0;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.autocommit;
+---------------------+
| @@global.autocommit |
+---------------------+
|                   0 |
+---------------------+
1 row in set (0.00 sec)

mysql> set @@global.autocommit=1;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.autocommit;
+---------------------+
| @@global.autocommit |
+---------------------+
|                   1 |
+---------------------+
1 row in set (0.00 sec)
```

### 会话变量

#### 作用域

针对当前会话（连接）有效，不能跨连接。

会话变量是在连接创建时由mysql自动给当前会话设置的变量。

#### 示例

##### 查看所有会话变量

```
/*①查看所有会话变量*/
show session variables;
```

##### 查看满足条件的会话变量

```
/*②查看满足条件的步伐会话变量*/
/*查看包含`char`字符变量名的会话变量*/
show session variables like '%char%';
```

##### 查看指定的会话变量的值

```
/*③查看指定的会话变量的值*/
/*查看事务默认自动提交的设置*/
select @@autocommit;
select @@session.autocommit;
/*查看事务隔离级别*/
select @@tx_isolation;
select @@session.tx_isolation;
```

##### 为某个会话变量赋值

```
/*④为某个会话变量赋值*/
set @@session.tx_isolation='read-uncommitted';
set @@tx_isolation='read-committed';
set session tx_isolation='read-committed';
set tx_isolation='read-committed';
```

效果：

```
mysql> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| READ-COMMITTED |
+----------------+
1 row in set, 1 warning (0.00 sec)

mysql> set tx_isolation='read-committed';
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| READ-COMMITTED |
+----------------+
1 row in set, 1 warning (0.00 sec)
```

### 自定义变量

#### 概念

变量由用户自定义的，而不是系统提供的。

#### 使用

```
使用步骤：
1. 声明
2. 赋值
3. 使用（查看、比较、运算）
```

#### 分类

- 用户变量
- 局部变量

### 用户变量

#### 作用域

针对当前会话（连接）有效，作用域同会话变量。

用户变量可以在任何地方使用也就是既可以在begin end里面使用，也可以在他外面使用。

#### 使用

##### 声明并初始化(要求声明时必须初始化)

```
/*方式1*/
set @变量名=值;
/*方式2*/
set @变量名:=值;
/*方式3*/
select @变量名:=值;
```

> 注意：
>
> 上面使用了`@`符合，而上面介绍全局变量使用了2个`@`符号，这点注意区分一下。
>
> set中=号前面冒号是可选的，select方式=前面必须有冒号

##### 赋值（更新变量的值）

```
/*方式1：这块和变量的声明一样*/
set @变量名=值;
set @变量名:=值;
select @变量名:=值;

/*方式2*/
select 字段 into @变量名 from 表;
```

> 注意上面select的两种方式。

##### 使用

```
select @变量名;
```

#### 综合示例

```
/*set方式创建变量并初始化*/
set @username='路人甲java';
/*select into方式创建变量*/
select 'javacode2018' into @gzh;
select count(*) into @empcount from employees;

/*select :=方式创建变量*/
select @first_name:='路人甲Java',@email:='javacode2018@163.com';
/*使用变量*/
insert into employees (first_name,email) values (@first_name,@email);
```

### 局部变量

#### 作用域

declare用于定义局部变量变量，在存储过程和函数中通过declare定义变量在begin…end中，且在语句之前。并且可以通过重复定义多个变量

declare变量的作用范围同编程里面类似，在这里一般是在对应的begin和end之间。在end之后这个变量就没有作用了，不能使用了。这个同编程一样。

#### 使用

##### 声明

```
declare 变量名 变量类型;
declare 变量名 变量类型 [default 默认值];
```

##### 赋值

```
/*方式1*/
set 局部变量名=值;
set 局部变量名:=值;
select 局部变量名:=值;

/*方式2*/
select 字段 into 局部变量名 from 表;
```

> 注意：局部变量前面没有`@`符号

##### 使用（查看变量的值）

```
select 局部变量名;
```

#### 示例

```
/*创建表test1*/
drop table IF EXISTS test1;
create table test1(a int PRIMARY KEY,b int);

/*声明脚本的结束符为$$*/
DELIMITER $$
DROP PROCEDURE IF EXISTS proc1;
CREATE PROCEDURE proc1()
BEGIN
  /*声明了一个局部变量*/
  DECLARE v_a int;

  select ifnull(max(a),0)+1 into v_a from test1;
  select @v_b:=v_a*2;
  insert into test1(a,b) select v_a,@v_b;
end $$

/*声明脚本的结束符为;*/
DELIMITER ;

/*调用存储过程*/
call proc1();
/*查看结果*/
select * from test1;
```

> 代码中使用到了存储过程，关于存储过程的详解下章节介绍。

##### delimiter关键字

我们写sql的时候，mysql怎么判断sql是否已经结束了，可以去执行了？

需要一个结束符，当mysql看到这个结束符的时候，表示可以执行前面的语句了，mysql默认以分号为结束符。

当我们创建存储过程或者自定义函数的时候，写了很大一片sql，里面包含了很多分号，整个创建语句是一个整体，需要一起执行，此时我们就不可用用分号作为结束符了。

那么我们可以通过`delimiter`关键字来自定义结束符。

**用法：**

```
delimiter 分隔符
```

##### 上面示例的效果

```
mysql> /*创建表test1*/
mysql> drop table IF EXISTS test1;
Query OK, 0 rows affected (0.01 sec)

mysql> create table test1(a int PRIMARY KEY,b int);
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> /*声明脚本的结束符为$$*/
mysql> DELIMITER $$
mysql> DROP PROCEDURE IF EXISTS proc1;
    -> CREATE PROCEDURE proc1()
    -> BEGIN
    ->   /*声明了一个局部变量*/
    ->   DECLARE v_a int;
    ->
    ->   select ifnull(max(a),0)+1 into v_a from test1;
    ->   select @v_b:=v_a*2;
    ->   insert into test1(a,b) select v_a,@v_b;
    -> end $$
Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql>
mysql> /*声明脚本的结束符为;*/
mysql> DELIMITER ;
mysql>
mysql> /*调用存储过程*/
mysql> call proc1();
+-------------+
| @v_b:=v_a*2 |
+-------------+
|           2 |
+-------------+
1 row in set (0.00 sec)

Query OK, 1 row affected (0.01 sec)

mysql> /*查看结果*/
mysql> select * from test1;
+---+------+
| a | b    |
+---+------+
| 1 |    2 |
+---+------+
1 row in set (0.00 sec)
```

### 用户变量和局部变量对比

|          | 作用域                | 定义位置              | 语法                    |
| :------- | :-------------------- | :-------------------- | :---------------------- |
| 用户变量 | 当前会话              | 会话的任何地方        | 加`@`符号，不用指定类型 |
| 局部变量 | 定义他的begin end之间 | begin end中的第一句话 | 不加`@`符号，要指定类型 |

### 总结

- **本文对系统变量和自定义变量的使用做了详细的说明，知识点比较细，可以多看几遍，加深理解**
- **系统变量可以设置系统的一些配置信息，数据库重启之后会被还原**
- **会话变量可以设置当前会话的一些配置信息，对当前会话起效**
- **declare创建的局部变量常用于存储过程和函数的创建中**
- **作用域：全局变量对整个系统有效、会话变量作用于当前会话、用户变量作用于当前会话、局部变量作用于begin end之间**
- **注意全局变量中用到了`@@`，用户变量变量用到了`@`，而局部变量没有这个符号**
- **`delimiter`关键字用来声明脚本的结束符**

# 存储过程&自定义函数详解

### 需求背景介绍

线上程序有时候出现问题导致数据错误的时候，如果比较紧急，我们可以写一个存储来快速修复这块的数据，然后再去修复程序，这种方式我们用到过不少。

存储过程相对于java程序对于java开发来说，可能并不是太好维护以及阅读，所以不建议在程序中去调用存储过程做一些业务操作。

关于自定义函数这块，若mysql内部自带的一些函数无法满足我们的需求的时候，我们可以自己开发一些自定义函数来使用。

所以建议大家掌握mysql中存储过程和自定义函数这块的内容。

### 本文内容

- 详解存储过程的使用
- 详解自定义函数的使用

### 准备数据

```
/*建库javacode2018*/
drop database if exists javacode2018;
create database javacode2018;

/*切换到javacode2018库*/
use javacode2018;

/*建表test1*/
DROP TABLE IF EXISTS t_user;
CREATE TABLE t_user (
  id   INT NOT NULL PRIMARY KEY COMMENT '编号',
  age  SMALLINT UNSIGNED NOT NULL COMMENT '年龄',
  name VARCHAR(16) NOT NULL COMMENT '姓名'
) COMMENT '用户表';
```

### 存储过程

#### 概念

一组预编译好的sql语句集合，理解成批处理语句。

好处：

- 提高代码的重用性
- 简化操作
- 减少编译次数并且减少和数据库服务器连接的次数，提高了效率。

#### 创建存储过程

```
create procedure 存储过程名([参数模式] 参数名 参数类型)
begin
    存储过程体
end
```

> 参数模式有3种：
>
> in：该参数可以作为输入，也就是该参数需要调用方传入值。
>
> out：该参数可以作为输出，也就是说该参数可以作为返回值。
>
> inout：该参数既可以作为输入也可以作为输出，也就是说该参数需要在调用的时候传入值，又可以作为返回值。
>
> 参数模式默认为IN。
>
> 一个存储过程可以有多个输入、多个输出、多个输入输出参数。

#### 调用存储过程

```
call 存储过程名称(参数列表);
```

> 注意：调用存储过程关键字是`call`。

#### 删除存储过程

```
drop procedure [if exists] 存储过程名称;
```

> 存储过程只能一个个删除，不能批量删除。
>
> if exists：表示存储过程存在的情况下删除。

#### 修改存储过程

存储过程不能修改，若涉及到修改的，可以先删除，然后重建。

#### 查看存储过程

```
show create procedure 存储过程名称;
```

> 可以查看存储过程详细创建语句。

#### 示例

##### 示例1：空参列表

创建存储过程

```
/*设置结束符为$*/
DELIMITER $
/*如果存储过程存在则删除*/
DROP PROCEDURE IF EXISTS proc1;
/*创建存储过程proc1*/
CREATE PROCEDURE proc1()
  BEGIN
    INSERT INTO t_user VALUES (1,30,'路人甲Java');
    INSERT INTO t_user VALUES (2,50,'刘德华');
  END $

/*将结束符置为;*/
DELIMITER ;
```

> delimiter用来设置结束符，当mysql执行脚本的时候，遇到结束符的时候，会把结束符前面的所有语句作为一个整体运行，存储过程中的脚本有多个sql，但是需要作为一个整体运行，所以此处用到了delimiter。
>
> mysql默认结束符是分号。
>
> 上面存储过程中向t_user表中插入了2条数据。

调用存储过程：

```
CALL proc1();
```

验证效果：

```
mysql> select * from t_user;
+----+-----+---------------+
| id | age | name          |
+----+-----+---------------+
|  1 |  30 | 路人甲Java    |
|  2 |  50 | 刘德华        |
+----+-----+---------------+
2 rows in set (0.00 sec)
```

> 存储过程调用成功，test1表成功插入了2条数据。

##### 示例2：带in参数的存储过程

创建存储过程：

```
/*设置结束符为$*/
DELIMITER $
/*如果存储过程存在则删除*/
DROP PROCEDURE IF EXISTS proc2;
/*创建存储过程proc2*/
CREATE PROCEDURE proc2(id int,age int,in name varchar(16))
  BEGIN
    INSERT INTO t_user VALUES (id,age,name);
  END $

/*将结束符置为;*/
DELIMITER ;
```

调用存储过程：

```
/*创建了3个自定义变量*/
SELECT @id:=3,@age:=56,@name:='张学友';
/*调用存储过程*/
CALL proc2(@id,@age,@name);
```

验证效果：

```
mysql> select * from t_user;
+----+-----+---------------+
| id | age | name          |
+----+-----+---------------+
|  1 |  30 | 路人甲Java    |
|  2 |  50 | 刘德华        |
|  3 |  56 | 张学友        |
+----+-----+---------------+
3 rows in set (0.00 sec)
```

> 张学友插入成功。

##### 示例3：带out参数的存储过程

创建存储过程：

```
delete a from t_user a where a.id = 4;
/*如果存储过程存在则删除*/
DROP PROCEDURE IF EXISTS proc3;
/*设置结束符为$*/
DELIMITER $
/*创建存储过程proc3*/
CREATE PROCEDURE proc3(id int,age int,in name varchar(16),out user_count int,out max_id INT)
  BEGIN
    INSERT INTO t_user VALUES (id,age,name);
    /*查询出t_user表的记录，放入user_count中,max_id用来存储t_user中最小的id*/
    SELECT COUNT(*),max(id) into user_count,max_id from t_user;
  END $

/*将结束符置为;*/
DELIMITER ;
```

> proc3中前2个参数，没有指定参数模式，默认为in。

调用存储过程：

```
/*创建了3个自定义变量*/
SELECT @id:=4,@age:=55,@name:='郭富城';
/*调用存储过程*/
CALL proc3(@id,@age,@name,@user_count,@max_id);
```

验证效果：

```
mysql> select @user_count,@max_id;
+-------------+---------+
| @user_count | @max_id |
+-------------+---------+
|           4 |       4 |
+-------------+---------+
1 row in set (0.00 sec)
```

##### 示例4：带inout参数的存储过程

创建存储过程：

```
/*如果存储过程存在则删除*/
DROP PROCEDURE IF EXISTS proc4;
/*设置结束符为$*/
DELIMITER $
/*创建存储过程proc4*/
CREATE PROCEDURE proc4(INOUT a int,INOUT b int)
  BEGIN
    SET a = a*2;
    select b*2 into b;
  END $

/*将结束符置为;*/
DELIMITER ;
```

调用存储过程：

```
/*创建了2个自定义变量*/
set @a=10,@b:=20;
/*调用存储过程*/
CALL proc4(@a,@b);
```

验证效果：

```
mysql> SELECT @a,@b;
+------+------+
| @a   | @b   |
+------+------+
|   20 |   40 |
+------+------+
1 row in set (0.00 sec)
```

> 上面的两个自定义变量@a、@b作为入参，然后在存储过程内部进行了修改，又作为了返回值。

##### 示例5：查看存储过程

```
mysql> show create procedure proc4;
+-------+-------+-------+-------+-------+-------+
| Procedure | sql_mode | Create Procedure | character_set_client | collation_connection | Database Collation |
+-------+-------+-------+-------+-------+-------+
| proc4     | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION | CREATE DEFINER=`root`@`localhost` PROCEDURE `proc4`(INOUT a int,INOUT b int)
BEGIN
    SET a = a*2;
    select b*2 into b;
  END | utf8                 | utf8_general_ci      | utf8_general_ci    |
+-------+-------+-------+-------+-------+-------+
1 row in set (0.00 sec)
```

### 函数

#### 概念

一组预编译好的sql语句集合，理解成批处理语句。类似于java中的方法，但是必须有返回值。

#### 创建函数

```
create function 函数名(参数名称 参数类型)
returns 返回值类型
begin
    函数体
end
```

> 参数是可选的。
>
> 返回值是必须的。

#### 调用函数

```
select 函数名(实参列表);
```

#### 删除函数

```
drop function [if exists] 函数名;
```

#### 查看函数详细

```
show create function 函数名;
```

#### 示例

##### 示例1：无参函数

创建函数：

```
/*删除fun1*/
DROP FUNCTION IF EXISTS fun1;
/*设置结束符为$*/
DELIMITER $
/*创建函数*/
CREATE FUNCTION fun1()
  returns INT
  BEGIN
    DECLARE max_id int DEFAULT 0;
    SELECT max(id) INTO max_id FROM t_user;
    return max_id;
  END $
/*设置结束符为;*/
DELIMITER ;
```

调用看效果：

```
mysql> SELECT fun1();
+--------+
| fun1() |
+--------+
|      4 |
+--------+
1 row in set (0.00 sec)
```

##### 示例2：有参函数

创建函数：

```
/*删除函数*/
DROP FUNCTION IF EXISTS get_user_id;
/*设置结束符为$*/
DELIMITER $
/*创建函数*/
CREATE FUNCTION get_user_id(v_name VARCHAR(16))
  returns INT
  BEGIN
    DECLARE r_id int;
    SELECT id INTO r_id FROM t_user WHERE name = v_name;
    return r_id;
  END $
/*设置结束符为;*/
DELIMITER ;
```

运行看效果：

```
mysql> SELECT get_user_id(name) from t_user;
+-------------------+
| get_user_id(name) |
+-------------------+
|                 1 |
|                 2 |
|                 3 |
|                 4 |
+-------------------+
4 rows in set (0.00 sec)
```

### 存储过程和函数的区别

存储过程的关键字为**procedure**，返回值可以有多个，调用时用**call**，**一般用于执行比较复杂的的过程体、更新、创建等语句**。

函数的关键字为**function**，**返回值必须有一个**，调用用**select**，一般用于查询单个值并返回。

|          | 存储过程          | 函数       |
| :------- | :---------------- | :--------- |
| 返回值   | 可以有0个或者多个 | 必须有一个 |
| 关键字   | procedure         | function   |
| 调用方式 | call              | select     |

# 流程控制

**代码中被[]包含的表示可选，|符号分开的表示可选其一。**

上一篇[存储过程&自定义函数](https://mp.weixin.qq.com/s?__biz=MzA5MTkxMDQ4MQ==&mid=2648933382&idx=1&sn=4cf80b4f50c80dcc8171d2128b47cf63&chksm=88621c38bf15952e193177a0ba3e03beeaeed996553ce6900f91518310332e99c915e8be2566&token=971638773&lang=zh_CN&scene=21#wechat_redirect)，对存储过程和自定义函数做了一个简单的介绍，但是如何能够写出复杂的存储过程和函数呢？

这需要我们熟练掌握流程控制语句才可以，本文主要介绍mysql中流程控制语句的使用，上干货。

### 本篇内容

- if函数
- case语句
- if结构
- while循环
- repeat循环
- loop循环
- 循环体控制语句

### 准备数据

```
/*建库javacode2018*/
drop database if exists javacode2018;
create database javacode2018;

/*切换到javacode2018库*/
use javacode2018;

/*创建表：t_user*/
DROP TABLE IF EXISTS t_user;
CREATE TABLE t_user(
  id int PRIMARY KEY COMMENT '编号',
  sex TINYINT not null DEFAULT 1 COMMENT '性别,1:男,2:女',
  name VARCHAR(16) not NULL DEFAULT '' COMMENT '姓名'
)COMMENT '用户表';

/*插入数据*/
INSERT INTO t_user VALUES
(1,1,'路人甲Java'),(2,1,'张学友'),(3,2,'王祖贤'),(4,1,'郭富城'),(5,2,'李嘉欣');

SELECT * FROM t_user;

DROP TABLE IF EXISTS test1;
CREATE TABLE test1 (a int not null);

DROP TABLE IF EXISTS test2;
CREATE TABLE test2 (a int not null,b int NOT NULL );
```

### if函数

#### 语法

```
if(条件表达式,值1,值2);
```

> if函数有3个参数。
>
> 当参数1为true的时候，返回`值1`，否则返回`值2`。

#### 示例

> 需求：查询`t_user`表数据，返回：编号、性别（男、女）、姓名。
>
> 分析一下：数据库中性别用数字表示的，我们需要将其转换为（男、女），可以使用if函数。

```
mysql> SELECT id 编号,if(sex=1,'男','女') 性别,name 姓名 FROM t_user;
+--------+--------+---------------+
| 编号   | 性别   | 姓名          |
+--------+--------+---------------+
|      1 | 男     | 路人甲Java    |
|      2 | 男     | 张学友        |
|      3 | 女     | 王祖贤        |
|      4 | 男     | 郭富城        |
|      5 | 女     | 李嘉欣        |
+--------+--------+---------------+
5 rows in set (0.00 sec)
```

### CASE结构

2种用法。

#### 第1种用法

> 类似于java中的switch语句。

```
case 表达式
when 值1 then 结果1或者语句1（如果是语句需要加分号）
when 值2 then 结果2或者语句2
...
else 结果n或者语句n
end [case] （如果是放在begin end之间需要加case，如果在select后则不需要）
```

##### 示例1：select中使用

> 查询`t_user`表数据，返回：编号、性别（男、女）、姓名。

```
/*写法1：类似于java中的if else*/
SELECT id 编号,(CASE sex WHEN 1 THEN '男' ELSE '女' END) 性别,name 姓名 FROM t_user;
/*写法2：类似于java中的if else if*/
SELECT id 编号,(CASE sex WHEN 1 then '男' WHEN 2 then '女' END) 性别,name 姓名 FROM t_user;
```

##### 示例2：begin end中使用

> 写一个存储过程，接受3个参数：id，性别（男、女），姓名，然后插入到t_user表

创建存储过程：

```
/*删除存储过程proc1*/
DROP PROCEDURE IF EXISTS proc1;
/*s删除id=6的记录*/
DELETE FROM t_user WHERE id=6;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程proc1*/
CREATE PROCEDURE proc1(id int,sex_str varchar(8),name varchar(16))
  BEGIN
    /*声明变量v_sex用于存放性别*/
    DECLARE v_sex TINYINT UNSIGNED;
    /*根据sex_str的值来设置性别*/
    CASE sex_str
      when '男' THEN
      SET v_sex = 1;
    WHEN '女' THEN
      SET v_sex = 2;
    END CASE ;
    /*插入数据*/
    INSERT INTO t_user VALUES (id,v_sex,name);
  END $
/*结束符置为;*/
DELIMITER ;
```

调用存储过程：

```
CALL proc1(6,'男','郭富城');
```

查看效果：

```
mysql> select * from t_user;
+----+-----+---------------+
| id | sex | name          |
+----+-----+---------------+
|  1 |   1 | 路人甲Java    |
|  2 |   1 | 张学友        |
|  3 |   2 | 王祖贤        |
|  4 |   1 | 郭富城        |
|  5 |   2 | 李嘉欣        |
|  6 |   1 | 郭富城        |
+----+-----+---------------+
6 rows in set (0.00 sec)
```

#### 示例3：函数中使用

> 需求：写一个函数，根据t_user表sex的值，返回男女

创建函数：

```
/*删除存储过程proc1*/
DROP FUNCTION IF EXISTS fun1;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程proc1*/
CREATE FUNCTION fun1(sex TINYINT UNSIGNED)
  RETURNS varchar(8)
  BEGIN
    /*声明变量v_sex用于存放性别*/
    DECLARE v_sex VARCHAR(8);
    CASE sex
    WHEN 1 THEN
      SET v_sex:='男';
    ELSE
      SET v_sex:='女';
    END CASE;
    RETURN v_sex;
  END $
/*结束符置为;*/
DELIMITER ;
```

看一下效果：

```
mysql> select sex, fun1(sex) 性别,name FROM t_user;
+-----+--------+---------------+
| sex | 性别   | name          |
+-----+--------+---------------+
|   1 | 男     | 路人甲Java    |
|   1 | 男     | 张学友        |
|   2 | 女     | 王祖贤        |
|   1 | 男     | 郭富城        |
|   2 | 女     | 李嘉欣        |
|   1 | 男     | 郭富城        |
+-----+--------+---------------+
6 rows in set (0.00 sec)
```

### 第2种用法

> 类似于java中多重if语句。

```
case
when 条件1 then 结果1或者语句1（如果是语句需要加分号）
when 条件2 then 结果2或者语句2
...
else 结果n或者语句n
end [case] （如果是放在begin end之间需要加case，如果是在select后面case可以省略）
```

**这种写法和1中的类似，大家用上面这种语法实现第1中用法中的3个示例，贴在留言中。**

### if结构

if结构类似于java中的 if..else if…else的语法，如下：

```
if 条件语句1 then 语句1;
elseif 条件语句2 then 语句2;
...
else 语句n;
end if;
```

> 只能使用在begin end之间。

#### 示例

> 写一个存储过程，实现用户数据的插入和新增，如果id存在，则修改，不存在则新增，并返回结果

```
/*删除id=7的记录*/
DELETE FROM t_user WHERE id=7;
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc2;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc2(v_id int,v_sex varchar(8),v_name varchar(16),OUT result TINYINT)
  BEGIN
    DECLARE v_count TINYINT DEFAULT 0;/*用来保存user记录的数量*/
    /*根据v_id查询数据放入v_count中*/
    select count(id) into v_count from t_user where id = v_id;
    /*v_count>0表示数据存在，则修改，否则新增*/
    if v_count>0 THEN
      BEGIN
        DECLARE lsex TINYINT;
        select if(lsex='男',1,2) into lsex;
        update t_user set sex = lsex,name = v_name where id = v_id;
        /*获取update影响行数*/
        select ROW_COUNT() INTO result;
      END;
    else
      BEGIN
        DECLARE lsex TINYINT;
        select if(lsex='男',1,2) into lsex;
        insert into t_user VALUES (v_id,lsex,v_name);
        select 0 into result;
      END;
    END IF;
  END $
/*结束符置为;*/
DELIMITER ;
```

看效果：

```
mysql> SELECT * FROM t_user;
+----+-----+---------------+
| id | sex | name          |
+----+-----+---------------+
|  1 |   1 | 路人甲Java    |
|  2 |   1 | 张学友        |
|  3 |   2 | 王祖贤        |
|  4 |   1 | 郭富城        |
|  5 |   2 | 李嘉欣        |
|  6 |   1 | 郭富城        |
+----+-----+---------------+
6 rows in set (0.00 sec)

mysql> CALL proc2(7,'男','黎明',@result);
Query OK, 1 row affected (0.00 sec)

mysql> SELECT @result;
+---------+
| @result |
+---------+
|       0 |
+---------+
1 row in set (0.00 sec)

mysql> SELECT * FROM t_user;
+----+-----+---------------+
| id | sex | name          |
+----+-----+---------------+
|  1 |   1 | 路人甲Java    |
|  2 |   1 | 张学友        |
|  3 |   2 | 王祖贤        |
|  4 |   1 | 郭富城        |
|  5 |   2 | 李嘉欣        |
|  6 |   1 | 郭富城        |
|  7 |   2 | 黎明          |
+----+-----+---------------+
7 rows in set (0.00 sec)

mysql> CALL proc2(7,'男','梁朝伟',@result);
Query OK, 1 row affected (0.00 sec)

mysql> SELECT @result;
+---------+
| @result |
+---------+
|       1 |
+---------+
1 row in set (0.00 sec)

mysql> SELECT * FROM t_user;
+----+-----+---------------+
| id | sex | name          |
+----+-----+---------------+
|  1 |   1 | 路人甲Java    |
|  2 |   1 | 张学友        |
|  3 |   2 | 王祖贤        |
|  4 |   1 | 郭富城        |
|  5 |   2 | 李嘉欣        |
|  6 |   1 | 郭富城        |
|  7 |   2 | 梁朝伟        |
+----+-----+---------------+
7 rows in set (0.00 sec)
```

### 循环

#### mysql中循环有3种写法

1. while：类似于java中的while循环
2. repeat：类似于java中的do while循环
3. loop：类似于java中的while(true)死循环，需要在内部进行控制。

#### 循环控制

对循环内部的流程进行控制，如：

##### 结束本次循环

> 类似于java中的`continue`

```
iterate 循环标签;
```

##### 退出循环

> 类似于java中的`break`

```
leave 循环标签;
```

下面我们分别介绍3种循环的使用。

### while循环

类似于java中的while循环。

#### 语法

```
[标签:]while 循环条件 do
循环体
end while [标签];
```

> 标签：是给while取个名字，标签和`iterate`、`leave`结合用于在循环内部对循环进行控制：如：跳出循环、结束本次循环。
>
> 注意：这个循环先判断条件，条件成立之后，才会执行循环体，每次执行都会先进行判断。

#### 示例1：无循环控制语句

> 根据传入的参数v_count向test1表插入指定数量的数据。

```
/*删除test1表记录*/
DELETE FROM test1;
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc3;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc3(v_count int)
  BEGIN
    DECLARE i int DEFAULT 1;
    a:WHILE i<=v_count DO
      INSERT into test1 values (i);
      SET i=i+1;
    END WHILE;
  END $
/*结束符置为;*/
DELIMITER ;
```

见效果：

```
mysql> CALL proc3(5);
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * from test1;
+---+
| a |
+---+
| 1 |
| 2 |
| 3 |
| 4 |
| 5 |
+---+
5 rows in set (0.00 sec)
```

#### 示例2：添加leave控制语句

> 根据传入的参数v_count向test1表插入指定数量的数据，当插入超过10条，结束。

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc4;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc4(v_count int)
  BEGIN
    DECLARE i int DEFAULT 1;
    a:WHILE i<=v_count DO
      INSERT into test1 values (i);
      /*判断i=10，离开循环a*/
      IF i=10 THEN
        LEAVE a;
      END IF;

      SET i=i+1;
    END WHILE;
  END $
/*结束符置为;*/
DELIMITER ;
```

见效果：

```
mysql> DELETE FROM test1;
Query OK, 20 rows affected (0.00 sec)

mysql> CALL proc4(20);
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * from test1;
+----+
| a  |
+----+
|  1 |
|  2 |
|  3 |
|  4 |
|  5 |
|  6 |
|  7 |
|  8 |
|  9 |
| 10 |
+----+
10 rows in set (0.00 sec)
```

#### 示例3：添加iterate控制语句

> 根据传入的参数v_count向test1表插入指定数量的数据，只插入偶数数据。

```
/*删除test1表记录*/
DELETE FROM test1;
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc5;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc5(v_count int)
  BEGIN
    DECLARE i int DEFAULT 0;
    a:WHILE i<=v_count DO
      SET i=i+1;
      /*如果i不为偶数，跳过本次循环*/
      IF i%2!=0 THEN
        ITERATE a;
      END IF;
      /*插入数据*/
      INSERT into test1 values (i);
    END WHILE;
  END $
/*结束符置为;*/
DELIMITER ;
```

见效果：

```
mysql> DELETE FROM test1;
Query OK, 5 rows affected (0.00 sec)

mysql> CALL proc5(10);
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * from test1;
+----+
| a  |
+----+
|  2 |
|  4 |
|  6 |
|  8 |
| 10 |
+----+
5 rows in set (0.00 sec)
```

#### 示例4：嵌套循环

> test2表有2个字段（a,b），写一个存储过程（2个参数：v_a_count，v_b_count)，使用双重循环插入数据，数据条件：a的范围[1,v_a_count]、b的范围[1,v_b_count]所有偶数的组合。

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc8;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc8(v_a_count int,v_b_count int)
  BEGIN
    DECLARE v_a int DEFAULT 0;
    DECLARE v_b int DEFAULT 0;

    a:WHILE v_a<=v_a_count DO
      SET v_a=v_a+1;
      SET v_b=0;

      b:WHILE v_b<=v_b_count DO

        SET v_b=v_b+1;
        IF v_a%2!=0 THEN
          ITERATE a;
        END IF;

        IF v_b%2!=0 THEN
          ITERATE b;
        END IF;

        INSERT INTO test2 VALUES (v_a,v_b);

      END WHILE b;

    END WHILE a;
  END $
/*结束符置为;*/
DELIMITER ;
```

> 代码中故意将`ITERATE a;`放在内层循环中，主要让大家看一下效果。

见效果：

```
mysql> DELETE FROM test2;
Query OK, 6 rows affected (0.00 sec)

mysql> CALL proc8(4,6);
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * from test2;
+---+---+
| a | b |
+---+---+
| 2 | 2 |
| 2 | 4 |
| 2 | 6 |
| 4 | 2 |
| 4 | 4 |
| 4 | 6 |
+---+---+
6 rows in set (0.00 sec)
```

### repeat循环

#### 语法

```
[标签:]repeat
循环体;
until 结束循环的条件 end repeat [标签];
```

> repeat循环类似于java中的do…while循环，不管如何，循环都会先执行一次，然后再判断结束循环的条件，不满足结束条件，循环体继续执行。这块和while不同，while是先判断条件是否成立再执行循环体。

#### 示例1：无循环控制语句

> 根据传入的参数v_count向test1表插入指定数量的数据。

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc6;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc6(v_count int)
  BEGIN
    DECLARE i int DEFAULT 1;
    a:REPEAT
      INSERT into test1 values (i);
      SET i=i+1;
    UNTIL i>v_count END REPEAT;
  END $
/*结束符置为;*/
DELIMITER ;
```

见效果：

```
mysql> DELETE FROM test1;
Query OK, 1 row affected (0.00 sec)

mysql> CALL proc6(5);
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * from test1;
+---+
| a |
+---+
| 1 |
| 2 |
| 3 |
| 4 |
| 5 |
+---+
5 rows in set (0.00 sec)
```

**repeat中`iterate`和`leave`用法和while中类似，这块的示例算是给大家留的作业，写好的发在留言区，谢谢。**

### loop循环

#### 语法

```
[标签:]loop
循环体;
end loop [标签];
```

> loop相当于一个死循环，需要在循环体中使用`iterate`或者`leave`来控制循环的执行。

#### 示例1：无循环控制语句

> 根据传入的参数v_count向test1表插入指定数量的数据。

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc7;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc7(v_count int)
  BEGIN
    DECLARE i int DEFAULT 0;
    a:LOOP
      SET i=i+1;
      /*当i>v_count的时候退出循环*/
      IF i>v_count THEN
        LEAVE a;
      END IF;
      INSERT into test1 values (i);
    END LOOP a;
  END $
/*结束符置为;*/
DELIMITER ;
```

见效果：

```
mysql> DELETE FROM test1;
Query OK, 5 rows affected (0.00 sec)

mysql> CALL proc7(5);
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * from test1;
+---+
| a |
+---+
| 1 |
| 2 |
| 3 |
| 4 |
| 5 |
+---+
5 rows in set (0.00 sec)
```

**loop中`iterate`和`leave`用法和while中类似，这块的示例算是给大家留的作业，写好的发在留言区，谢谢。**

### 总结

1. 本文主要介绍了mysql中控制流语句的使用，请大家下去了多练习，熟练掌握
2. if函数常用在select中
3. case语句有2种写法，主要用在select、begin end中，select中end后面可以省略case，begin end中使用不能省略case
4. if语句用在begin end中
5. 3种循环体的使用，while类似于java中的while循环，repeat类似于java中的do while循环，loop类似于java中的死循环，都用于begin end中
6. 循环中体中的控制依靠`leave`和`iterate`，`leave`类似于java中的`break`可以退出循环，`iterate`类似于java中的continue可以结束本次循环

# 异常处理

**代码中被[]包含的表示可选，|符号分开的表示可选其一。**

### 需求背景

我们在写存储过程的时候，可能会出现下列一些情况：

1. 插入的数据违反唯一约束，导致插入失败
2. 插入或者更新数据超过字段最大长度，导致操作失败
3. update影响行数和期望结果不一致

遇到上面各种异常情况的时，可能需要我们能够捕获，然后可能需要回滚当前事务。

本文主要围绕异常处理这块做详细的介绍。

此时我们需要使用游标，通过游标的方式来遍历select查询的结果集，然后对每行数据进行处理。

### 本篇内容

- 异常分类详解
- 内部异常详解
- 外部异常详解
- 掌握乐观锁解决并发修改数据出错的问题
- update影响行数和期望结果不一致时的处理

### 准备数据

创建库：`javacode2018`

创建表：test1，test1表中的a字段为主键。

```
/*建库javacode2018*/
drop database if exists javacode2018;
create database javacode2018;

/*切换到javacode2018库*/
use javacode2018;

DROP TABLE IF EXISTS test1;
CREATE TABLE test1(a int PRIMARY KEY);
```

### 异常分类

我们将异常分为mysql内部异常和外部异常

#### mysql内部异常

当我们执行一些sql的时候，可能违反了mysql的一些约束，导致mysql内部报错，如插入数据违反唯一约束，更新数据超时等，此时异常是由mysql内部抛出的，**我们将这些由mysql抛出的异常统称为内部异常。**

#### 外部异常

当我们执行一个update的时候，可能我们期望影响1行，但是实际上影响的不是1行数据，这种情况：sql的执行结果和期望的结果不一致，这种情况也我们也把他作为外部异常处理，**我们将sql执行结果和期望结果不一致的情况统称为外部异常。**

### Mysql内部异常

#### 示例1

> test1表中的a字段为主键，我们向test1表同时插入2条数据，并且放在一个事务中执行，最终要么都插入成功，要么都失败。

##### 创建存储过程：

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc1;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc1(a1 int,a2 int)
  BEGIN
    START TRANSACTION;
    INSERT INTO test1(a) VALUES (a1);
    INSERT INTO test1(a) VALUES (a2);
    COMMIT;
  END $
/*结束符置为;*/
DELIMITER ;
```

> 上面存储过程插入了两条数据，a的值都是1。

##### 验证结果：

```
mysql> DELETE FROM test1;
Query OK, 0 rows affected (0.00 sec)

mysql> CALL proc1(1,1);
ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
mysql> SELECT * from test1;
+---+
| a |
+---+
| 1 |
+---+
1 row in set (0.00 sec)
```

> 上面先删除了test1表中的数据，然后调用存储过程`proc1`，由于test1表中的a字段是主键，插入第二条数据时违反了a字段的主键约束，mysql内部抛出了异常，导致第二条数据插入失败，最终只有第一条数据插入成功了。
>
> 上面的结果和我们期望的不一致，我们希望要么都插入成功，要么失败。

那我们怎么做呢？我们需要捕获上面的主键约束异常，然后发现有异常的时候执行`rollback`回滚操作，改进上面的代码，看下面示例2。

#### 示例2

> 我们对上面示例进行改进，捕获上面主键约束异常，然后进行回滚处理，如下：

##### 创建存储过程：

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc2;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc2(a1 int,a2 int)
  BEGIN
    /*声明一个变量，标识是否有sql异常*/
    DECLARE hasSqlError int DEFAULT FALSE;
    /*在执行过程中出任何异常设置hasSqlError为TRUE*/
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET hasSqlError=TRUE;

    /*开启事务*/
    START TRANSACTION;
    INSERT INTO test1(a) VALUES (a1);
    INSERT INTO test1(a) VALUES (a2);

    /*根据hasSqlError判断是否有异常，做回滚和提交操作*/
    IF hasSqlError THEN
      ROLLBACK;
    ELSE
      COMMIT;
    END IF;
  END $
/*结束符置为;*/
DELIMITER ;
```

##### 上面重点是这句：

```
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET hasSqlError=TRUE;
```

> 当有sql异常的时候，会将变量`hasSqlError`的值置为`TRUE`。

##### 模拟异常情况：

```
mysql> DELETE FROM test1;
Query OK, 2 rows affected (0.00 sec)

mysql> CALL proc2(1,1);
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * from test1;
Empty set (0.00 sec)
```

> 上面插入了2条一样的数据，插入失败，可以看到上面`test1`表无数据，和期望结果一致，插入被回滚了。

##### 模拟正常情况：

```
mysql> DELETE FROM test1;
Query OK, 0 rows affected (0.00 sec)

mysql> CALL proc2(1,2);
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * from test1;
+---+
| a |
+---+
| 1 |
| 2 |
+---+
2 rows in set (0.00 sec)
```

> 上面插入了2条不同的数据，最终插入成功。

### 外部异常

外部异常不是由mysql内部抛出的错误，而是由于sql的执行结果和我们期望的结果不一致的时候，我们需要对这种情况做一些处理，如回滚操作。

#### 示例1

我们来模拟电商中下单操作，按照上面的步骤来更新账户余额。

##### 电商中有个账户表和订单表，如下：

```
DROP TABLE IF EXISTS t_funds;
CREATE TABLE t_funds(
  user_id INT PRIMARY KEY COMMENT '用户id',
  available DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '账户余额'
) COMMENT '用户账户表';
DROP TABLE IF EXISTS t_order;
CREATE TABLE t_order(
  id int PRIMARY KEY AUTO_INCREMENT COMMENT '订单id',
  price DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '订单金额'
) COMMENT '订单表';
delete from t_funds;
/*插入一条数据，用户id为1001，余额为1000*/
INSERT INTO t_funds (user_id,available) VALUES (1001,1000);
```

##### 下单操作涉及到操作上面的账户表，我们用存储过程来模拟实现：

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc3;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc3(v_user_id int,v_price decimal(10,2),OUT v_msg varchar(64))
  a:BEGIN
    DECLARE v_available DECIMAL(10,2);

    /*1.查询余额，判断余额是否够*/
    select a.available into v_available from t_funds a where a.user_id = v_user_id;
    if v_available<=v_price THEN
      SET v_msg='账户余额不足!';
      /*退出*/
      LEAVE a;
    END IF;

    /*模拟耗时5秒*/
    SELECT sleep(5);

    /*2.余额减去price*/
    SET v_available = v_available - v_price;

    /*3.更新余额*/
    START TRANSACTION;
    UPDATE t_funds SET available = v_available WHERE user_id = v_user_id;

    /*插入订单明细*/
    INSERT INTO t_order (price) VALUES (v_price);

    /*提交事务*/
    COMMIT;
    SET v_msg='下单成功!';
  END $
/*结束符置为;*/
DELIMITER ;
```

> 上面过程主要分为3步骤：验证余额、修改余额变量、更新余额。

##### 开启2个cmd窗口，连接mysql，同时执行下面操作：

```
USE javacode2018;
CALL proc3(1001,100,@v_msg);
select @v_msg;
```

##### 然后执行：

```
mysql> SELECT * FROM t_funds;
+---------+-----------+
| user_id | available |
+---------+-----------+
|    1001 |    900.00 |
+---------+-----------+
1 row in set (0.00 sec)

mysql> SELECT * FROM t_order;
+----+--------+
| id | price  |
+----+--------+
|  1 | 100.00 |
|  2 | 100.00 |
+----+--------+
2 rows in set (0.00 sec)
```

**上面出现了非常严重的错误：下单成功了2次，但是账户只扣了100。**

**上面过程是由于2个操作并发导致的，2个窗口同时执行第一步的时候看到了一样的数据（看到的余额都是1000），然后继续向下执行，最终导致结果出问题了。**

上面操作我们可以使用乐观锁来优化。

> 乐观锁的过程：用期望的值和目标值进行比较，如果相同，则更新目标值，否则什么也不做。

乐观锁类似于java中的cas操作，这块需要了解的可以点击：[详解CAS](https://mp.weixin.qq.com/s?__biz=MzA5MTkxMDQ4MQ==&mid=2648933166&idx=1&sn=15e614500676170b76a329efd3255c12&chksm=88621b10bf1592064befc5c9f0d78c56cda25c6d003e1711b85e5bfeb56c9fd30d892178db87&token=1033016931&lang=zh_CN&scene=21#wechat_redirect)

我们可以在资金表`t_funds`添加一个`version`字段，表示版本号，每次更新数据的时候+1，更新数据的时候将version作为条件去执行update，根据update影响行数来判断执行是否成功，优化上面的代码，见**示例2**。

#### 示例2

> 对示例1进行优化。

##### 创建表：

```
DROP TABLE IF EXISTS t_funds;
CREATE TABLE t_funds(
  user_id INT PRIMARY KEY COMMENT '用户id',
  available DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '账户余额',
  version INT DEFAULT 0 COMMENT '版本号，每次更新+1'
) COMMENT '用户账户表';

DROP TABLE IF EXISTS t_order;
CREATE TABLE t_order(
  id int PRIMARY KEY AUTO_INCREMENT COMMENT '订单id',
  price DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '订单金额'
)COMMENT '订单表';
delete from t_funds;
/*插入一条数据，用户id为1001，余额为1000*/
INSERT INTO t_funds (user_id,available) VALUES (1001,1000);
```

##### 创建存储过程：

```
/*删除存储过程*/
DROP PROCEDURE IF EXISTS proc4;
/*声明结束符为$*/
DELIMITER $
/*创建存储过程*/
CREATE PROCEDURE proc4(v_user_id int,v_price decimal(10,2),OUT v_msg varchar(64))
    a:BEGIN
    /*保存当前余额*/
    DECLARE v_available DECIMAL(10,2);
    /*保存版本号*/
    DECLARE v_version INT DEFAULT 0;
    /*保存影响的行数*/
    DECLARE v_update_count INT DEFAULT 0;


    /*1.查询余额，判断余额是否够*/
    select a.available,a.version into v_available,v_version from t_funds a where a.user_id = v_user_id;
    if v_available<=v_price THEN
      SET v_msg='账户余额不足!';
      /*退出*/
      LEAVE a;
    END IF;

    /*模拟耗时5秒*/
    SELECT sleep(5);

    /*2.余额减去price*/
    SET v_available = v_available - v_price;

    /*3.更新余额*/
    START TRANSACTION;
    UPDATE t_funds SET available = v_available WHERE user_id = v_user_id AND version = v_version;
    /*获取上面update影响行数*/
    select ROW_COUNT() INTO v_update_count;

    IF v_update_count=1 THEN
      /*插入订单明细*/
      INSERT INTO t_order (price) VALUES (v_price);
      SET v_msg='下单成功!';
      /*提交事务*/
      COMMIT;
    ELSE
      SET v_msg='下单失败,请重试!';
      /*回滚事务*/
      ROLLBACK;
    END IF;
  END $
/*结束符置为;*/
DELIMITER ;
```

> `ROW_COUNT()`可以获取更新或插入后获取受影响行数。将受影响行数放在`v_update_count`中。
>
> 然后根据`v_update_count`是否等于1判断更新是否成功，如果成功则记录订单信息并提交事务，否则回滚事务。

##### 验证结果：开启2个cmd窗口，连接mysql，执行下面操作：

```
use javacode2018;
CALL proc4(1001,100,@v_msg);
select @v_msg;
```

##### 窗口1结果：

```
mysql> CALL proc4(1001,100,@v_msg);
+----------+
| sleep(5) |
+----------+
|        0 |
+----------+
1 row in set (5.00 sec)

Query OK, 0 rows affected (5.00 sec)

mysql> select @v_msg;
+---------------+
| @v_msg        |
+---------------+
| 下单成功!     |
+---------------+
1 row in set (0.00 sec)
```

##### 窗口2结果：

```
mysql> CALL proc4(1001,100,@v_msg);
+----------+
| sleep(5) |
+----------+
|        0 |
+----------+
1 row in set (5.00 sec)

Query OK, 0 rows affected (5.01 sec)

mysql> select @v_msg;
+-------------------------+
| @v_msg                  |
+-------------------------+
| 下单失败,请重试!        |
+-------------------------+
1 row in set (0.00 sec)
```

**可以看到第一个窗口下单成功了，窗口2下单失败了。**

**再看一下2个表的数据：**

```
mysql> SELECT * FROM t_funds;
+---------+-----------+---------+
| user_id | available | version |
+---------+-----------+---------+
|    1001 |    900.00 |       0 |
+---------+-----------+---------+
1 row in set (0.00 sec)

mysql> SELECT * FROM t_order;
+----+--------+
| id | price  |
+----+--------+
|  1 | 100.00 |
+----+--------+
1 row in set (0.00 sec)
```

也正常。

### 总结

1. 异常分为Mysql内部异常和外部异常

2. 内部异常由mysql内部触发，外部异常是sql的执行结果和期望结果不一致导致的错误

3. sql内部异常捕获方式

   ```
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET hasSqlError=TRUE;
   ```

4. `ROW_COUNT()`可以获取mysql中insert或者update影响的行数

5. 掌握使用乐观锁（添加版本号）来解决并发修改数据可能出错的问题

6. `begin end`前面可以加标签，`LEAVE 标签`可以退出对应的begin end，可以使用这个来实现return的效果

# 什么是索引

本文为索引第一篇：我们来了解一下什么是索引？

路人在搞计算机之前，是负责小区建设规划的，上级领导安排路人负责一个万人小区建设规划，并提了一个要求：可以快速通过户主姓名找到户主的房子；让路人出个好的解决方案。

### 方案1

刚开始路人没什么经验，实在想不到什么好办法。

路人告诉领导：你可以去敲每户的门，然后开门之后再去询问房主姓名，是否和需要找的人姓名一致。

领导一听郁闷了：我敲你的头，1万户，我一个个找，找到什么时候了？你明天不用来上班了。

> 这里面涉及到的时间有：走到每户的门口耗时、敲门等待开门耗时、询问户主获取户主姓名耗时、将户主姓名和需要查找的姓名对比是否一致耗时。
>
> 加入要找的人刚好在最后一户，领导岂不是要疯掉了，需要重复1万次上面的操作。

上面是最原始，最耗时的做法，可能要找的人根本不在这个小区，白费力的找了1万次，岂不是要疯掉。

### 方案2

路人灵机一动，想到了一个方案：

1. 给所有的户主制定一个编号，从1-10000，户主将户号贴在自家的门口
2. 路人自己制作了一个户主和户号对应的表格，我们叫做：`户主目录表`，共1万条记录，如下：

| 户主姓名   | 房屋编号 |
| :--------- | :------- |
| 刘德华     | 00001    |
| 张学友     | 00002    |
| 路人       | 00888    |
| 路人甲java | 10000    |

此时领导要查找`路人甲Java`时，过程如下：

1. 按照姓名在`户主目录表`查找`路人甲Java`，找到对应的编号：`10000`
2. 然后从第一户房子开始找，查看其门口户号是否是10000，直到找到为止

路人告诉领导，这个方案比方案1有以下好处：

1. 如果要找的人不在这个小区，通过`户主目录表`就确定，不需要第二步了
2. 步骤2中不需要再去敲每户的门以及询问户主的姓名了，只需对比一下门口的户号就可以了，比方案1省了不少时间。

领导笑着说，不错不错，有进步，不过我找`路人甲Java`还是需要挨家挨户看门牌号1万次啊！。。。。。你再去想想吧，看看是否还有更好的办法来加快查找速度。

路人下去了苦思冥想，想出了方案3。

### 方案3

方案2中第2步最坏的情况还是需要找1万次。

路人去上海走了一圈，看了那边小区搞的不错，很多小区都是搞成一栋一栋的，每栋楼里面有100户，路人也决定这么搞。

路人告诉领导：

1. 将1万户划分为100栋楼，每栋楼有25层，每层有4户人家，总共1万户
2. 给每栋楼一个编号，范围是[001,100]，将栋号贴在每栋楼最显眼的位置
3. 给每栋楼中的每层一个编号，编号范围是[01,25]，将层号贴在每层楼最显眼的位置
4. 户号变为：栋号-楼层-层中编号，如`路人甲Java`户号是：100-20-04，贴在每户门口

`户主目录表`还是有1万条记录，如下：

| 户主姓名   | 房屋编号  |
| :--------- | :-------- |
| 刘德华     | 001-08-04 |
| 张学友     | 022-18-01 |
| 路人       | 088-25-04 |
| 路人甲java | 100-25-04 |

此时领导要查找`路人甲Java`时，过程如下：

1. 按照姓名在`户主目录表`查找`路人甲Java`，找到对应的编号是`100-25-04`，将编号分解，得到：栋号（100）、楼层（25）、楼号（04）
2. 从第一栋开始找，看其栋号是否是100，直到找到编号为100为止，这个过程需要找100次，然后到了第100栋楼下
3. 从100栋的第一层开始向上走，走到每层看其编号是否为25，直到走到第25层，这个过程需要匹配25次
4. 在第25层依次看看户号是否为`100-25-04`，匹配了4次，找到了`路人甲Java`

此方案分析：

1. 查找`户主目录表`1万次，不过这个是在表格中，不用动身走路去找，只需要动动眼睛对比一下数字，速度还是比较快的
2. 将方案2中的第2步优化为上面的`2/3/4`步骤，上面最坏需要匹配129次（栋100+层25+楼号4次），相对于方案2的1万次好多了

领导拍拍路人的肩膀：小伙子，去过上海的人确实不一样啊，这次方案不错，不过第一步还是需要很多次，能否有更好的方案呢？

路人下去了又想了好几天，突然想到了我们常用的字典，可以按照字典的方式对方案3中第一步做优化，然后提出了方案4。

### 方案4

对户主表进行改造，按照姓的首字母(a-z)制作26个表格，叫做：**姓氏户主表**，每个表格中保存对应姓氏首字母及所有户主和户号。如下：

| 姓首字母：A |           |
| :---------- | :-------- |
| 姓名        | 户号      |
| 阿三        | 010-16-01 |
| 阿郎        | 017-11-04 |
| 啊啊        | 008-08-02 |



| 姓首字母：L |           |
| :---------- | :-------- |
| 姓名        | 户号      |
| 刘德华      | 011-16-01 |
| 路人        | 057-11-04 |
| 路人甲Java  | 048-08-02 |

#### 现在查找户号步骤如下：

1. 通过姓名获取姓对应的首字母
2. 在26个表格中找到对应姓的表格，如`路人甲Java`，对应`L表`
3. 在L表中循环遍历，找到`路人甲Java`的户号
4. 根据户号按照方案3中的(2/3/4)步骤找对应的户主

#### 理想情况：

1万户主的姓氏分配比较均衡，那么每个姓氏下面分配385户（10000/26） ，那么找到某个户主，最多需要:26次+385次 = 410次，相对于1万次少了很多。

#### 最坏的情况：

1万个户主的姓氏都是一样的，导致这1万个户主信息都位于同一个姓氏户主表，此时查询又变为了1万多次。不过出现姓氏一样的情况比较低。

如果担心姓氏不足以均衡划分户主信息，那么也可以通过户主姓名的笔画数来划分，或者其他方法，主要是将用户信息划分为不同的区，可以快速过滤一些不相关的户主。

上面几个方案为了快速检索到户主，用到了一些数据结构，通过这些数据结构对户主的信息进行组织，从而可以快速过滤掉一些不相关的户主，减少查找次数，快速定位到户主的房子。

### 索引是什么？

通过上面的示例，我们可以概况一下索引的定义：索引是依靠某些数据结构和算法来组织数据，最终引导用户快速检索出所需要的数据。

索引有2个特点：

1. 通过数据结构和算法来对原始的数据进行一些有效的组织
2. 通过这些有效的组织，可以引导使用者对原始数据进行快速检索

**mysql为了快速检索数据，也用到了一些好的数据结构和算法，来组织表中的数据，加快检索效率。**

# 索引原理

### 背景

使用mysql最多的就是查询，我们迫切的希望mysql能查询的更快一些，我们经常用到的查询有：

1. 按照id查询唯一一条记录
2. 按照某些个字段查询对应的记录
3. 查找某个范围的所有记录（between and）
4. 对查询出来的结果排序

**mysql的索引的目的是使上面的各种查询能够更快。**

### 预备知识

#### 什么是索引？

上一篇中有详细的介绍，可以过去看一下：[什么是索引？](https://mp.weixin.qq.com/s?__biz=MzA5MTkxMDQ4MQ==&mid=2648933400&idx=1&sn=61af771f10342ee4956efea6749abd71&chksm=88621c26bf15953041a6bc65734edf788af711ff176ad36884fe6411e5c4cfd0bf967e0e33fc&token=1781447741&lang=zh_CN&scene=21#wechat_redirect)

索引的本质：**通过不断地缩小想要获取数据的范围来筛选出最终想要的结果，同时把随机的事件变成顺序的事件，也就是说，有了这种索引机制，我们可以总是用同一种查找方式来锁定数据。**

#### 磁盘中数据的存取

以机械硬盘来说，先了解几个概念。

**扇区**：磁盘存储的最小单位，扇区一般大小为512Byte。

**磁盘块**：文件系统与磁盘交互的的最小单位（计算机系统读写磁盘的最小单位），一个磁盘块由连续几个（2^n）扇区组成，块一般大小一般为4KB。

**磁盘读取数据**：磁盘读取数据靠的是机械运动，每次读取数据花费的时间可以分为**寻道时间、旋转延迟、传输时间**三个部分，寻道时间指的是磁臂移动到指定磁道所需要的时间，主流磁盘一般在5ms以下；旋转延迟就是我们经常听说的磁盘转速，比如一个磁盘7200转，表示每分钟能转7200次，也就是说1秒钟能转120次，旋转延迟就是1/120/2 = 4.17ms；传输时间指的是从磁盘读出或将数据写入磁盘的时间，一般在零点几毫秒，相对于前两个时间可以忽略不计。那么访问一次磁盘的时间，即一次磁盘IO的时间约等于5+4.17 = 9ms左右，听起来还挺不错的，但要知道一台500 -MIPS的机器每秒可以执行5亿条指令，因为指令依靠的是电的性质，换句话说执行一次IO的时间可以执行40万条指令，数据库动辄十万百万乃至千万级数据，每次9毫秒的时间，显然是个灾难。

#### mysql中的页

mysql中和磁盘交互的最小单位称为页，页是mysql内部定义的一种数据结构，默认为16kb，相当于4个磁盘块，也就是说mysql每次从磁盘中读取一次数据是16KB，要么不读取，要读取就是16KB，此值可以修改的。

#### 数据检索过程

我们对数据存储方式不做任何优化，直接将数据库中表的记录存储在磁盘中，假如某个表只有一个字段，为int类型，int占用4个byte，每个磁盘块可以存储1000条记录，100万的记录需要1000个磁盘块，如果我们需要从这100万记录中检索所需要的记录，需要读取1000个磁盘块的数据（需要1000次io），每次io需要9ms，那么1000次需要9000ms=9s，100条数据随便一个查询就是9秒，这种情况我们是无法接受的，显然是不行的。

### 我们迫切的需求是什么？

我们迫切需要这样的数据结构和算法：

1. 需要一种数据存储结构：当从磁盘中检索数据的时候能，够减少磁盘的io次数，最好能够降低到一个稳定的常量值
2. 需要一种检索算法：当从磁盘中读取磁盘块的数据之后，这些块中可能包含多条记录，这些记录被加载到内存中，那么需要一种算法能够快速从内存多条记录中快速检索出目标数据

我们来找找，看是否能够找到这样的算法和数据结构。

我们看一下常见的检索算法和数据结构。

### 循环遍历查找

从一组无序的数据中查找目标数据，常见的方法是遍历查询，n条数据，时间复杂度为O(n)，最快需要1次，最坏的情况需要n次，查询效率不稳定。

### 二分法查找

二分法查找也称为折半查找，用于在一个有序数组中快速定义某一个需要查找的数据。

**原理是：**

先将一组无序的数据排序（升序或者降序）之后放在数组中，此处用升序来举例说明：用数组中间位置的数据A和需要查找的数据F对比，如果A=F，则结束查找；如果A<F，则将查找的范围缩小至数组中A数据右边的部分；如果A>F，则将查找范围缩小至数组中A数据左边的部分，继续按照上面的方法直到找到F为止。

**示例：**

> 从下列有序数字中查找数字9，过程如下

[1,2,3,4,5,6,7,8,9]

第1次查找：[1,2,3,4,5,6,7,8,9]中间位置值为5，9>5，将查找范围缩小至5右边的部分：[6、7、8、9]

第2次查找：[6、7、8、9]中间值为8，9>8 ，将范围缩小至8右边部分：[9]

第3次查找：在[9]中查找9，找到了。

可以看到查找速度是相当快的，每次查找都会使范围减半，如果我们采用顺序查找，上面数据最快需要1次，最多需要9次，而二分法查找最多只需要3次，耗时时间也比较稳定。

二分法查找时间复杂度是:**O(logN)(N为数据量)**，100万数据查找最多只需要20次（2^20=1048576‬）

**二分法查找数据的优点：定位数据非常快，前提是：目标数组是有序的。**

### 有序数组

如果我们将mysql中表的数据以有序数组的方式存储在磁盘中，那么我们定位数据步骤是：

1. 取出目标表的所有数据，存放在一个有序数组中
2. 如果目标表的数据量非常大，从磁盘中加载到内存中需要的内存也非常大

步骤取出所有数据耗费的io次数太多，步骤2耗费的内存空间太大，还有新增数据的时候，为了保证数组有序，插入数据会涉及到数组内部数据的移动，也是比较耗时的，显然用这种方式存储数据是不可取的。

### 链表

链表相当于在每个节点上增加一些指针，可以和前面或者后面的节点连接起来，就像一列火车一样，每节车厢相当于一个节点，车厢内部可以存储数据，每个车厢和下一节车厢相连。

**链表分为单链表和双向链表。**

#### 单链表

> 每个节点中有持有指向下一个节点的指针，只能按照一个方向遍历链表，结构如下：

```
//单项链表
class Node1{
    private Object data;//存储数据
    private Node1 nextNode;//指向下一个节点
}
```

#### 双向链表

> 每个节点中两个指针，分别指向当前节点的上一个节点和下一个节点，结构如下：

```
//双向链表
class Node2{
    private Object data;//存储数据
    private Node1 prevNode;//指向上一个节点
    private Node1 nextNode;//指向下一个节点
}
```

#### 链表的优点：

1. **可以快速定位到上一个或者下一个节点**
2. **可以快速删除数据，只需改变指针的指向即可，这点比数组好**

#### 链表的缺点：

1. **无法向数组那样，通过下标随机访问数据**
2. **查找数据需从第一个节点开始遍历，不利于数据的查找，查找时间和无需数据类似，需要全遍历，最差时间是O(N)**

### 二叉查找树

二叉树是每个结点最多有两个子树的树结构，通常子树被称作“左子树”（left subtree）和“右子树”（right subtree）。二叉树常被用于实现二叉查找树和二叉堆。二叉树有如下特性：

> 1、每个结点都包含一个元素以及n个子树，这里0≤n≤2。
> 2、左子树和右子树是有顺序的，次序不能任意颠倒，左子树的值要小于父结点，右子树的值要大于父结点。

数组[20,10,5,15,30,25,35]使用二叉查找树存储如下：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iawsv8OJN7hibW3lpgicibacvpt7FiaFoEuhicHIWpQWAzO66AOp5Bg10E9vQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

每个节点上面有两个指针（left,rigth），可以通过这2个指针快速访问左右子节点，检索任何一个数据最多只需要访问3个节点，相当于访问了3次数据，时间为O(logN)，和二分法查找效率一样，查询数据还是比较快的。

但是如果我们插入数据是有序的，如[5,10,15,20,30,25,35]，那么结构就变成下面这样：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iaUFkHCAzws0JBkEZ5icF6FAlicvomFfZ2oDrQcMt6kNBJbltkOjfq5LjQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

二叉树退化为了一个链表结构，查询数据最差就变为了O(N)。

**二叉树的优缺点：**

1. **查询数据的效率不稳定，若树左右比较平衡的时，最差情况为O(logN)，如果插入数据是有序的，退化为了链表，查询时间变成了O(N)**
2. **数据量大的情况下，会导致树的高度变高，如果每个节点对应磁盘的一个块来存储一条数据，需io次数大幅增加，显然用此结构来存储数据是不可取的**

### 平衡二叉树（AVL树）

平衡二叉树是一种特殊的二叉树，所以他也满足前面说到的二叉查找树的两个特性，同时还有一个特性：

> 它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树。

平衡二叉树相对于二叉树来说，树的左右比较平衡，不会出现二叉树那样退化成链表的情况，不管怎么插入数据，最终通过一些调整，都能够保证树左右高度相差不大于1。

这样可以让查询速度比较稳定，查询中遍历节点控制在O(logN)范围内

如果数据都存储在内存中，采用AVL树来存储，还是可以的，查询效率非常高。不过我们的数据是存在磁盘中，用过采用这种结构，每个节点对应一个磁盘块，数据量大的时候，也会和二叉树一样，会导致树的高度变高，增加了io次数，显然用这种结构存储数据也是不可取的。

### B-树

`B杠树`，千万不要读作B减树了，B-树在是平衡二叉树上进化来的，前面介绍的几种树，每个节点上面只有一个元素，而B-树节点中可以放多个元素，主要是为了降低树的高度。

一棵m阶的B-Tree有如下特性【特征描述的有点绕，看不懂的可以跳过，看后面的图】：

> 1. 每个节点最多有m个孩子，m称为b树的阶
> 2. 除了根节点和叶子节点外，其它每个节点至少有Ceil(m/2)个孩子
> 3. 若根节点不是叶子节点，则至少有2个孩子
> 4. 所有叶子节点都在同一层，且不包含其它关键字信息
> 5. 每个非终端节点包含n个关键字（健值）信息
> 6. 关键字的个数n满足：ceil(m/2)-1 <= n <= m-1
> 7. ki(i=1,…n)为关键字，且关键字升序排序
> 8. Pi(i=1,…n)为指向子树根节点的指针。P(i-1)指向的子树的所有节点关键字均小于ki，但都大于k(i-1)

B-Tree结构的数据可以让系统高效的找到数据所在的磁盘块。为了描述B-Tree，首先定义一条记录为一个二元组[key, data] ，key为记录的键值，对应表中的主键值，data为一行记录中除主键外的数据。对于不同的记录，key值互不相同。

B-Tree中的每个节点根据实际情况可以包含大量的关键字信息和分支，如下图所示为一个3阶的B-Tree：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iaJVWDLI8Q0vSf6nVWFhhvo9LBlRkhL0edChQeAaLPQ3euCqTdHnpZeA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

每个节点占用一个盘块的磁盘空间，一个节点上有两个升序排序的关键字和三个指向子树根节点的指针，指针存储的是子节点所在磁盘块的地址。两个键将数据划分成的三个范围域，对应三个指针指向的子树的数据的范围域。以根节点为例，关键字为17和35，P1指针指向的子树的数据范围为小于17，P2指针指向的子树的数据范围为17~35，P3指针指向的子树的数据范围为大于35。

模拟查找关键字29的过程：

1. 根据根节点找到磁盘块1，读入内存。【磁盘I/O操作第1次】
2. 比较关键字29在区间（17,35），找到磁盘块1的指针P2
3. 根据P2指针找到磁盘块3，读入内存。【磁盘I/O操作第2次】
4. 比较关键字29在区间（26,30），找到磁盘块3的指针P2
5. 根据P2指针找到磁盘块8，读入内存。【磁盘I/O操作第3次】
6. 在磁盘块8中的关键字列表中找到关键字29

分析上面过程，发现需要3次磁盘I/O操作，和3次内存查找操作，由于内存中的关键字是一个有序表结构，可以利用二分法快速定位到目标数据，而3次磁盘I/O操作是影响整个B-Tree查找效率的决定因素。

B-树相对于avl树，通过在节点中增加节点内部数据的个数来减少磁盘的io操作。

上面我们说过mysql是采用页方式来读写数据，每页是16KB，我们用B-树来存储mysql的记录，每个节点对应mysql中的一页（16KB），假如每行记录加上树节点中的1个指针占160Byte，那么每个节点可以存储1000（16KB/160byte）条数据，树的高度为3的节点大概可以存储（第一层1000+第二层1000^2+第三层1000^3）10亿条记录，是不是非常惊讶，一个高度为3个B-树大概可以存储10亿条记录，我们从10亿记录中查找数据只需要3次io操作可以定位到目标数据所在的页，而页内部的数据又是有序的，然后将其加载到内存中用二分法查找，是非常快的。

可以看出使用B-树定位某个值还是很快的(10亿数据中3次io操作+内存中二分法)，但是也是有缺点的：**B-不利于范围查找，比如上图中我们需要查找[15,36]区间的数据，需要访问7个磁盘块（1/2/7/3/8/4/9），io次数又上去了，范围查找也是我们经常用到的，所以b-树也不太适合在磁盘中存储需要检索的数据。**

### b+树

先看个b+树结构图：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iaA8QQKibSGNB3sz5MibNnlIyoiatTkqEibyqZCTTlhnjfNzSKCEyDXicsvRA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

#### b+树的特征

1. 每个结点至多有m个子女
2. 除根结点外,每个结点至少有[m/2]个子女，根结点至少有两个子女
3. 有k个子女的结点必有k个关键字
4. 父节点中持有访问子节点的指针
5. 父节点的关键字在子节点中都存在（如上面的1/20/35在每层都存在），要么是最小值，要么是最大值，如果节点中关键字是升序的方式，父节点的关键字是子节点的最小值
6. 最底层的节点是叶子节点
7. 除叶子节点之外，其他节点不保存数据，只保存关键字和指针
8. 叶子节点包含了所有数据的关键字以及data，叶子节点之间用链表连接起来，可以非常方便的支持范围查找

#### b+树与b-树的几点不同

1. b+树中一个节点如果有k个关键字，最多可以包含k个子节点（k个关键字对应k个指针）；而b-树对应k+1个子节点（多了一个指向子节点的指针）
2. b+树除叶子节点之外其他节点值存储关键字和指向子节点的指针，而b-树还存储了数据，这样同样大小情况下，b+树可以存储更多的关键字
3. b+树叶子节点中存储了所有关键字及data，并且多个节点用链表连接，从上图中看子节点中数据从左向右是有序的，这样快速可以支撑范围查找（先定位范围的最大值和最小值，然后子节点中依靠链表遍历范围数据）

#### B-Tree和B+Tree该如何选择？

1. B-Tree因为非叶子结点也保存具体数据，所以在查找某个关键字的时候找到即可返回。而B+Tree所有的数据都在叶子结点，每次查找都得到叶子结点。所以在同样高度的B-Tree和B+Tree中，B-Tree查找某个关键字的效率更高。
2. 由于B+Tree所有的数据都在叶子结点，并且结点之间有指针连接，在找大于某个关键字或者小于某个关键字的数据的时候，B+Tree只需要找到该关键字然后沿着链表遍历就可以了，而B-Tree还需要遍历该关键字结点的根结点去搜索。
3. 由于B-Tree的每个结点（这里的结点可以理解为一个数据页）都存储主键+实际数据，而B+Tree非叶子结点只存储关键字信息，而每个页的大小有限是有限的，所以同一页能存储的B-Tree的数据会比B+Tree存储的更少。这样同样总量的数据，B-Tree的深度会更大，增大查询时的磁盘I/O次数，进而影响查询效率。

### Mysql的存储引擎和索引

mysql内部索引是由不同的引擎实现的，主要说一下InnoDB和MyISAM这两种引擎中的索引，这两种引擎中的索引都是使用b+树的结构来存储的。

#### InnoDB中的索引

**Innodb中有2种索引：****主键索引（聚集索引）、辅助索引（非聚集索引）**。

**主键索引：****每个表只有一个主键索引，叶子节点同时保存了主键的值也数据记录。**

**辅助索引：****叶子节点保存了索引字段的值以及主键的值。**

#### MyISAM引擎中的索引

不管是主键索引还是辅助索引结构都是一样的，叶子节点保存了索引字段的值以及数据记录的地址。

如下图：

> 有一张表，Id作为主索引，Name作为辅助索引。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5ia3YYibg7WsaRjZictOic4G5fD8ROtHuG3bjM9JjjrDfCEgtHWZGUE3QS3A/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

#### InnoDB数据检索过程

如果需要查询id=14的数据，只需要在左边的主键索引中检索就可以了。

如果需要搜索name='Ellison'的数据，需要2步：

1. 先在辅助索引中检索到name='Ellison'的数据，获取id为14
2. 再到主键索引中检索id为14的记录

辅助索引这个查询过程在mysql中叫做**回表**。

#### MyISAM数据检索过程

1. 在索引中找到对应的关键字，获取关键字对应的记录的地址
2. 通过记录的地址查找到对应的数据记录

我们用的最多的是innodb存储引擎，所以此处主要说一下innodb索引的情况，innodb中最好是采用主键查询，这样只需要一次索引，如果使用辅助索引检索，涉及到回表操作，比主键查询要耗时一些。

innodb中辅助索引为什么不像myisam那样存储记录的地址？

表中的数据发生变更的时候，会影响其他记录地址的变化，如果辅助索引中记录数据的地址，此时会受影响，而主键的值一般是很少更新的，当页中的记录发生地址变更的时候，对辅助索引是没有影响的。

我们来看一下mysql中页的结构，页是真正存储记录的地方，对应B+树中的一个节点，也是mysql中读写数据的最小单位，页的结构设计也是相当有水平的，能够加快数据的查询。

### 页结构

mysql中页是innodb中存储数据的基本单位，也是mysql中管理数据的最小单位，和磁盘交互的时候都是以页来进行的，默认是16kb，mysql中采用b+树存储数据，页相当于b+树中的一个节点。

页的结构如下图：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5ia7hFP1KmbNuZibTbrAkTUvZibGRFGL93wHRsh7lYE8y7J19DiaNhibeaicZA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

每个Page都有通用的头和尾，但是中部的内容根据Page的类型不同而发生变化。Page的头部里有我们关心的一些数据，下图把Page的头部详细信息显示出来：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iaw093TmG8IQIaLI1Ah0XIBcBIIkSKJ9SqvYfc2Yj8o2oVCOrDicMfHpA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

我们重点关注和数据组织结构相关的字段：Page的头部保存了两个指针，分别指向前一个Page和后一个Page，根据这两个指针我们很容易想象出Page链接起来就是一个双向链表的结构，如下图：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iaicnWHQjvibfwatdQzppAR0S2tNSMFGViaOoDHjHU2zIO32rBB1QTO2y4g/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

再看看Page的主体内容，我们主要关注行数据和索引的存储，他们都位于Page的User Records部分，User Records占据Page的大部分空间，User Records由一条一条的Record组成。在一个Page内部，单链表的头尾由固定内容的两条记录来表示，字符串形式的"Infimum"代表开头，"Supremum"代表结尾，这两个用来代表开头结尾的Record存储在System Records的，Infinum、Supremum和User Records组成了一个单向链表结构。最初数据是按照插入的先后顺序排列的，但是随着新数据的插入和旧数据的删除，数据物理顺序会变得混乱，但他们依然通过链表的方式保持着逻辑上的先后顺序，如下图：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iamXiat7T5My0obPsPbVY7KF8OkkwyYLBv5J66W0chSc63kciaxgUhVSIw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

把User Record的组织形式和若干Page组合起来，就看到了稍微完整的形式。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iaDkaZ5vmop9vac2V87HUaLYbeibvXKBWtPstptnOk0CMcSibk8n6rs3ibA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

innodb为了快速查找记录，在页中定义了一个称之为page directory的目录槽（slots）,每个槽位占用两个字节（用于保存指向记录的地址），page directory中的多个slot组成了一个有序数组（可用于二分法快速定位记录，向下看），行记录被Page Directory逻辑的分成了多个块，块与块之间是有序的，能够加速记录的查找，如下图：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06DpcdWiadWZPKkg3cp7iaWp5iaqnH90C2I8Otjic3yyGA6cV1s9Nw9Wj79fFSJGMBdV6VLTW9wd7picKpA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

看上图，每个行记录的都有一个n_owned的区域（图中粉色区域），n_owned标识所属的slot这个这个块有多少条数据，伪记录Infimum的n_owned值总是1，记录Supremum的n_owned的取值范围为[1,8]，其他用户记录n_owned的取值范围[4,8]，并且只有每个块中最大的那条记录的n_owned才会有值，其他的用户记录的n_owned为0。

#### 数据检索过程

在page中查询数据的时候，先通过b+树中查询方法定位到数据所在的页，然后将页内整体加载到内存中，通过二分法在page directory中检索数据，缩小范围，比如需要检索7，通过二分法查找到7位于slot2和slot3所指向的记录中间，然后从slot3指向的记录5开始向后向后一个个找，可以找到记录7，如果里面没有7，走到slot2向的记录8结束。

n_owned范围控制在[4,8]内，能保证每个slot管辖的范围内数据量控制在[4,8]个，能够加速目标数据的查找，当有数据插入的时候，page directory为了控制每个slot对应块中记录的个数（[4,8]），此时page directory中会对slot的数量进行调整。

#### 对page的结构总结一下

1. **b+树中叶子页之间用双向链表连接的，能够实现范围查找**
2. **页内部的记录之间是采用单向链表连接的，方便访问下一条记录**
3. **为了加快页内部记录的查询，对页内记录上加了个有序的稀疏索引，叫页目录（page directory）**

**整体上来说mysql中的索引用到了b+树，链表，二分法查找，做到了快速定位目标数据，快速范围查找。**

**下篇文章介绍：**

1. 一个表应该创建哪些索引？
2. 有索引时sql应该怎么写？
3. 我的sql为什么不走索引？需要知道内部原理
4. where条件涉及多个字段多个索引时怎么走？
5. 多表连接查询、子查询，怎么去利用索引，内部过程是什么样的？
6. like查询中前面有%的时候为何不走索引？
7. 字段中使用函数的时候为什么不走索引？
8. 字符串查询使用数字作为条件的时候为什么不走索引？、
9. 索引区分度、索引覆盖、最左匹配、索引排序又是什么？原理是什么？

关于上面各种索引选择的问题，我们会深入其原理，让大家知道为什么是这样？而不是只去记一些优化规则，而不知道其原因，知道其原理用的时候更加得心应手一些。

# 正确使用索引

### 先来回顾一些知识

本篇文章我们以innodb存储引擎为例来做说明。

mysql采用b+树的方式存储索引信息。

#### b+树结构如下：

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06BdfH1b6BVvJwicCkVNNGPUKgHJ5GGic4uAeFnlGhdZ0MMHJAS2nia0sLT1cI5ftibxVFm2SIWWQWPuIg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

> 说一下b+树的几个特点：
>
> 1. 叶子节点（最下面的一层）存储关键字（索引字段的值）信息及对应的data，叶子节点存储了所有记录的关键字信息
> 2. 其他非叶子节点只存储关键字的信息及子节点的指针
> 3. 每个叶子节点相当于mysql中的一页，同层级的叶子节点以双向链表的形式相连
> 4. 每个节点（页）中存储了多条记录，记录之间用单链表的形式连接组成了一条有序的链表，顺序是按照索引字段排序的
> 5. b+树中检索数据时：每次检索都是从根节点开始，一直需要搜索到叶子节点

InnoDB 的数据是按数据页为单位来读写的。也就是说，当需要读取一条记录的时候，并不是将这个记录本身从磁盘读取出来，而是以页为单位，将整个也加载到内存中，一个页中可能有很多记录，然后在内存中对页进行检索。在innodb中，每个页的大小默认是16kb。

#### Mysql中索引分为

##### 聚集索引（主键索引）

> 每个表一定会有一个聚集索引，整个表的数据存储以b+树的方式存在文件中，b+树叶子节点中的key为主键值，data为完整记录的信息；非叶子节点存储主键的值。
>
> 通过聚集索引检索数据只需要按照b+树的搜索过程，即可以检索到对应的记录。

##### 非聚集索引

> 每个表可以有多个非聚集索引，b+树结构，叶子节点的key为索引字段字段的值，data为主键的值；非叶子节点只存储索引字段的值。
>
> 通过非聚集索引检索记录的时候，需要2次操作，先在非聚集索引中检索出主键，然后再到聚集索引中检索出主键对应的记录，该过程比聚集索引多了一次操作。

索引怎么走，为什么有些查询不走索引？为什么使用函数了数据就不走索引了？

这些问题可以先放一下，我们先看一下b+树检索数据的过程，这个属于原理的部分，理解了b+树各种数据检索过程，上面的问题就都可以理解了。

#### 通常说的这个查询走索引了是什么意思？

当我们对某个字段的值进行某种检索的时候，如果这个检索过程中，我们能够快速定位到目标数据所在的页，有效的降低页的io操作，而不需要去扫描所有的数据页的时候，我们认为这种情况能够有效的利用索引，也称这个检索可以走索引，如果这个过程中不能够确定数据在那些页中，我们认为这种情况下索引对这个查询是无效的，此查询不走索引。

### b+树中数据检索过程

#### 唯一记录检索

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06BdfH1b6BVvJwicCkVNNGPUKbC5e9kNyP3IZQhrKu8Ysibr0Lnt8F0NZsxGKaIAwpVk3zJoImIJwtEw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

如上图，所有的数据都是唯一的，查询105的记录，过程如下：

1. 将P1页加载到内存
2. 在内存中采用二分法查找，可以确定105位于[100,150)中间，所以我们需要去加载100关联P4页
3. 将P4加载到内存中，采用二分法找到105的记录后退出

#### 查询某个值的所有记录

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06BdfH1b6BVvJwicCkVNNGPUKL1pUianQTrDEsuNZ6QpV6bnuaMA4hwWicDhicxd7Zy0BcwxkWGL0ibLroA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

如上图，查询105的所有记录，过程如下：

1. 将P1页加载到内存
2. 在内存中采用二分法查找，可以确定105位于[100,150)中间，100关联P4页
3. 将P4加载到内存中，采用二分法找到最有一个小于105的记录，即100，然后通过链表从100开始向后访问，找到所有的105记录，直到遇到第一个大于100的值为止

#### 范围查找

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06BdfH1b6BVvJwicCkVNNGPUKL1pUianQTrDEsuNZ6QpV6bnuaMA4hwWicDhicxd7Zy0BcwxkWGL0ibLroA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

数据如上图，查询[55,150]所有记录，由于页和页之间是双向链表升序结构，页内部的数据是单项升序链表结构，所以只用找到范围的起始值所在的位置，然后通过依靠链表访问两个位置之间所有的数据即可，过程如下：

1. 将P1页加载到内存
2. 内存中采用二分法找到55位于50关联的P3页中，150位于P5页中
3. 将P3加载到内存中，采用二分法找到第一个55的记录，然后通过链表结构继续向后访问P3中的60、67，当P3访问完毕之后，通过P3的nextpage指针访问下一页P4中所有记录，继续遍历P4中的所有记录，直到访问到P5中所有的150为止。

#### 模糊匹配

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06BdfH1b6BVvJwicCkVNNGPUKXAy1p09QIXSVBDSsabzcMvkHIby7R01yKiasiaYicve7EnDnicyMwE8Xlg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

数据如上图。

##### 查询以`f`开头的所有记录

过程如下：

1. 将P1数据加载到内存中
2. 在P1页的记录中采用二分法找到最后一个小于等于f的值，这个值是f，以及第一个大于f的，这个值是z，f指向叶节点P3，z指向叶节点P6，此时可以断定以f开头的记录可能存在于[P3,P6)这个范围的页内，即P3、P4、P5这三个页中
3. 加载P3这个页，在内部以二分法找到第一条f开头的记录，然后以链表方式继续向后访问P4、P5中的记录，即可以找到所有已f开头的数据

##### 查询包含`f`的记录

包含的查询在sql中的写法是`%f%`，通过索引我们还可以快速定位所在的页么？

可以看一下上面的数据，f在每个页中都存在，我们通过P1页中的记录是无法判断包含f的记录在那些页的，只能通过io的方式加载所有叶子节点，并且遍历所有记录进行过滤，才可以找到包含f的记录。

所以如果使用了`%值%`这种方式，索引对查询是无效的。

#### 最左匹配原则

> 当b+树的数据项是复合的数据结构，比如(name,age,sex)的时候，b+树是按照从左到右的顺序来建立搜索树的，比如当(张三,20,F)这样的数据来检索的时候，b+树会优先比较name来确定下一步的所搜方向，如果name相同再依次比较age和sex，最后得到检索的数据；但当(20,F)这样的没有name的数据来的时候，b+树就不知道下一步该查哪个节点，因为建立搜索树的时候name就是第一个比较因子，必须要先根据name来搜索才能知道下一步去哪里查询。比如当(张三,F)这样的数据来检索时，b+树可以用name来指定搜索方向，但下一个字段age的缺失，所以只能把名字等于张三的数据都找到，然后再匹配性别是F的数据了， 这个是非常重要的性质，即索引的最左匹配特性。

来一些示例我们体验一下。

下图中是3个字段(a,b,c)的联合索引，索引中数据的顺序是以`a asc,b asc,c asc`这种排序方式存储在节点中的，索引先以a字段升序，如果a相同的时候，以b字段升序，b相同的时候，以c字段升序，节点中每个数据认真看一下。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06BdfH1b6BVvJwicCkVNNGPUKtSZibmVvMIYF1P3wkLqwfzVAPsANbN9ql2lcNvXpiamY3Vl70Xa60UnA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

##### 查询a=1的记录

由于页中的记录是以`a asc,b asc,c asc`这种排序方式存储的，所以a字段是有序的，可以通过二分法快速检索到，过程如下：

1. 将P1加载到内存中
2. 在内存中对P1中的记录采用二分法找，可以确定a=1的记录位于{1,1,1}和{1,5,1}关联的范围内，这两个值子节点分别是P2、P4
3. 加载叶子节点P2，在P2中采用二分法快速找到第一条a=1的记录，然后通过链表向下一条及下一页开始检索，直到在P4中找到第一个不满足a=1的记录为止

##### 查询a=1 and b=5的记录

方法和上面的一样，可以确定a=1 and b=5的记录位于{1,1,1}和{1,5,1}关联的范围内，查找过程和a=1查找步骤类似。

##### 查询b=1的记录

这种情况通过P1页中的记录，是无法判断b=1的记录在那些页中的，只能加锁索引树所有叶子节点，对所有记录进行遍历，然后进行过滤，此时索引是无效的。

##### 按照c的值查询

这种情况和查询b=1也一样，也只能扫描所有叶子节点，此时索引也无效了。

##### 按照b和c一起查

这种也是无法利用索引的，也只能对所有数据进行扫描，一条条判断了，此时索引无效。

##### 按照[a,c]两个字段查询

这种只能利用到索引中的a字段了，通过a确定索引范围，然后加载a关联的所有记录，再对c的值进行过滤。

##### 查询a=1 and b>=0 and c=1的记录

这种情况只能先确定a=1 and b>=0所在页的范围，然后对这个范围的所有页进行遍历，c字段在这个查询的过程中，是无法确定c的数据在哪些页的，此时我们称c是不走索引的，只有a、b能够有效的确定索引页的范围。

**类似这种的还有>、<、between and，多字段索引的情况下，mysql会一直向右匹配直到遇到范围查询(>、<、between、like)就停止匹配。**

上面说的各种情况，大家都多看一下图中数据，认真分析一下查询的过程，基本上都可以理解了。

**上面这种查询叫做最左匹配原则。**

### 索引区分度

我们看2个有序数组

[1,2,3,4,5,6,7,8,8,9,10]

[1,1,1,1,1,8,8,8,8,8]

上面2个数组是有序的，都是10条记录，如果我需要检索值为8的所有记录，那个更快一些？

咱们使用二分法查找包含8的所有记录过程如下：先使用二分法找到最后一个小于8的记录，然后沿着这条记录向后获取下一个记录，和8对比，知道遇到第一个大于8的数字结束，或者到达数组末尾结束。

采用上面这种方法找到8的记录，第一个数组中更快的一些。因为第二个数组中含有8的比例更多的，需要访问以及匹配的次数更多一些。

这里就涉及到数据的区分度问题：

**索引区分度 = count(distint 记录) / count(记录)**。

当索引区分度高的时候，检索数据更快一些，索引区分度太低，说明重复的数据比较多，检索的时候需要访问更多的记录才能够找到所有目标数据。

当索引区分度非常小的时候，基本上接近于全索引数据的扫描了，此时查询速度是比较慢的。

第一个数组索引区分度为1，第二个区分度为0.2，所以第一个检索更快的一些。

**所以我们创建索引的时候，尽量选择区分度高的列作为索引。**

### 正确使用索引

#### 准备400万测试数据

```
/*建库javacode2018*/
DROP DATABASE IF EXISTS javacode2018;
CREATE DATABASE javacode2018;
USE javacode2018;
/*建表test1*/
DROP TABLE IF EXISTS test1;
CREATE TABLE test1 (
  id     INT NOT NULL COMMENT '编号',
  name   VARCHAR(20) NOT NULL COMMENT '姓名',
  sex TINYINT NOT NULL COMMENT '性别,1：男，2：女',
  email  VARCHAR(50)
);

/*准备数据*/
DROP PROCEDURE IF EXISTS proc1;
DELIMITER $
CREATE PROCEDURE proc1()
  BEGIN
    DECLARE i INT DEFAULT 1;
    START TRANSACTION;
    WHILE i <= 4000000 DO
      INSERT INTO test1 (id, name, sex, email) VALUES (i,concat('javacode',i),if(mod(i,2),1,2),concat('javacode',i,'@163.com'));
      SET i = i + 1;
      if i%10000=0 THEN
        COMMIT;
        START TRANSACTION;
      END IF;
    END WHILE;
    COMMIT;
  END $

DELIMITER ;
CALL proc1();
```

> 上面插入的400万数据，除了sex列，其他列的值都是没有重复的。

#### 无索引检索效果

> 400万数据，我们随便查询几个记录看一下效果。

按照id查询记录

```
mysql> select * from test1 where id = 1;
+----+-----------+-----+-------------------+
| id | name      | sex | email             |
+----+-----------+-----+-------------------+
|  1 | javacode1 |   1 | javacode1@163.com |
+----+-----------+-----+-------------------+
1 row in set (1.91 sec)
```

> id=1的数据，表中只有一行，耗时近2秒，由于id列无索引，只能对400万数据进行全表扫描。

#### 主键检索

> test1表中没有明确的指定主键，我们将id设置为主键：

```
mysql> alter table test1 modify id int not null primary key;
Query OK, 0 rows affected (10.93 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> show index from test1;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| test1 |          0 | PRIMARY  |            1 | id          | A         |     3980477 |     NULL | NULL   |      | BTREE      |         |               |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
1 row in set (0.00 sec)
```

> id被置为主键之后，会在id上建立聚集索引，随便检索一条我们看一下效果：

```
mysql> select * from test1 where id = 1000000;
+---------+-----------------+-----+-------------------------+
| id      | name            | sex | email                   |
+---------+-----------------+-----+-------------------------+
| 1000000 | javacode1000000 |   2 | javacode1000000@163.com |
+---------+-----------------+-----+-------------------------+
1 row in set (0.00 sec)
```

##### 这个速度很快，这个走的是上面介绍的`唯一记录检索`。

#### between and范围检索

```
mysql> select count(*) from test1 where id between 100 and 110;
+----------+
| count(*) |
+----------+
|       11 |
+----------+
1 row in set (0.00 sec)
```

> 速度也很快，id上有主键索引，这个采用的上面介绍的`范围查找`可以快速定位目标数据。
>
> 但是如果范围太大，跨度的page也太多，速度也会比较慢，如下：

```
mysql> select count(*) from test1 where id between 1 and 2000000;
+----------+
| count(*) |
+----------+
|  2000000 |
+----------+
1 row in set (1.17 sec)
```

> 上面id的值跨度太大，1所在的页和200万所在页中间有很多页需要读取，所以比较慢。
>
> **所以使用between and的时候，区间跨度不要太大。**

#### in的检索

> in方式检索数据，我们还是经常用的。
>
> 平时我们做项目的时候，建议少用表连接，比如电商中需要查询订单的信息和订单中商品的名称，可以先查询查询订单表，然后订单表中取出商品的id列表，采用in的方式到商品表检索商品信息，由于商品id是商品表的主键，所以检索速度还是比较快的。
>
> 通过id在400万数据中检索100条数据，看看效果：

```
mysql> select * from test1 a where a.id in (100000, 100001, 100002, 100003, 100004, 100005, 100006, 100007, 100008, 100009, 100010, 100011, 100012, 100013, 100014, 100015, 100016, 100017, 100018, 100019, 100020, 100021, 100022, 100023, 100024, 100025, 100026, 100027, 100028, 100029, 100030, 100031, 100032, 100033, 100034, 100035, 100036, 100037, 100038, 100039, 100040, 100041, 100042, 100043, 100044, 100045, 100046, 100047, 100048, 100049, 100050, 100051, 100052, 100053, 100054, 100055, 100056, 100057, 100058, 100059, 100060, 100061, 100062, 100063, 100064, 100065, 100066, 100067, 100068, 100069, 100070, 100071, 100072, 100073, 100074, 100075, 100076, 100077, 100078, 100079, 100080, 100081, 100082, 100083, 100084, 100085, 100086, 100087, 100088, 100089, 100090, 100091, 100092, 100093, 100094, 100095, 100096, 100097, 100098, 100099);
+--------+----------------+-----+------------------------+
| id     | name           | sex | email                  |
+--------+----------------+-----+------------------------+
| 100000 | javacode100000 |   2 | javacode100000@163.com |
| 100001 | javacode100001 |   1 | javacode100001@163.com |
| 100002 | javacode100002 |   2 | javacode100002@163.com |
.......
| 100099 | javacode100099 |   1 | javacode100099@163.com |
+--------+----------------+-----+------------------------+
100 rows in set (0.00 sec)
```

> 耗时不到1毫秒，还是相当快的。
>
> 这个相当于多个分解为多个`唯一记录检索`，然后将记录合并。

#### 多个索引时查询如何走？

> 我们在name、sex两个字段上分别建个索引

```
mysql> create index idx1 on test1(name);
Query OK, 0 rows affected (13.50 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> create index idx2 on test1(sex);
Query OK, 0 rows affected (6.77 sec)
Records: 0  Duplicates: 0  Warnings: 0
```

看一下查询：

```
mysql> select * from test1 where name='javacode3500000' and sex=2;
+---------+-----------------+-----+-------------------------+
| id      | name            | sex | email                   |
+---------+-----------------+-----+-------------------------+
| 3500000 | javacode3500000 |   2 | javacode3500000@163.com |
+---------+-----------------+-----+-------------------------+
1 row in set (0.00 sec)
```

> 上面查询速度很快，name和sex上各有一个索引，觉得上面走哪个索引？
>
> 有人说name位于where第一个，所以走的是name字段所在的索引，过程可以解释为这样：
>
> 1. 走name所在的索引找到`javacode3500000`对应的所有记录
> 2. 遍历记录过滤出sex=2的值

我们看一下`name='javacode3500000'`检索速度，确实很快，如下：

```
mysql> select * from test1 where name='javacode3500000';
+---------+-----------------+-----+-------------------------+
| id      | name            | sex | email                   |
+---------+-----------------+-----+-------------------------+
| 3500000 | javacode3500000 |   2 | javacode3500000@163.com |
+---------+-----------------+-----+-------------------------+
1 row in set (0.00 sec)
```

走name索引，然后再过滤，确实可以，速度也很快，果真和where后字段顺序有关么？我们把name和sex的顺序对调一下，如下：

```
mysql> select * from test1 where sex=2 and name='javacode3500000';
+---------+-----------------+-----+-------------------------+
| id      | name            | sex | email                   |
+---------+-----------------+-----+-------------------------+
| 3500000 | javacode3500000 |   2 | javacode3500000@163.com |
+---------+-----------------+-----+-------------------------+
1 row in set (0.00 sec)
```

速度还是很快，这次是不是先走`sex`索引检索出数据，然后再过滤name呢？我们先来看一下`sex=2`查询速度：

```
mysql> select count(id) from test1 where sex=2;
+-----------+
| count(id) |
+-----------+
|   2000000 |
+-----------+
1 row in set (0.36 sec)
```

看上面，查询耗时360毫秒，200万数据，如果走sex肯定是不行的。

我们使用explain来看一下：

```
mysql> explain select * from test1 where sex=2 and name='javacode3500000';
+----+-------------+-------+------------+------+---------------+------+---------+-------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref   | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | test1 | NULL       | ref  | idx1,idx2     | idx1 | 62      | const |    1 |    50.00 | Using where |
+----+-------------+-------+------------+------+---------------+------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)
```

> possible_keys：列出了这个查询可能会走两个索引（idx1、idx2）
>
> 实际上走的却是idx1（key列：实际走的索引）。

**当多个条件中有索引的时候，并且关系是and的时候，会走索引区分度高的**，显然name字段重复度很低，走name查询会更快一些。

#### 模糊查询

> 看两个查询

```
mysql> select count(*) from test1 a where a.name like 'javacode1000%';
+----------+
| count(*) |
+----------+
|     1111 |
+----------+
1 row in set (0.00 sec)

mysql> select count(*) from test1 a where a.name like '%javacode1000%';
+----------+
| count(*) |
+----------+
|     1111 |
+----------+
1 row in set (1.78 sec)
```

> 上面第一个查询可以利用到name字段上面的索引，下面的查询是无法确定需要查找的值所在的范围的，只能全表扫描，无法利用索引，所以速度比较慢，这个过程上面有说过。

#### 回表

> 当需要查询的数据在索引树中不存在的时候，需要再次到聚集索引中去获取，这个过程叫做回表，如查询：

```
mysql> select * from test1 where name='javacode3500000';
+---------+-----------------+-----+-------------------------+
| id      | name            | sex | email                   |
+---------+-----------------+-----+-------------------------+
| 3500000 | javacode3500000 |   2 | javacode3500000@163.com |
+---------+-----------------+-----+-------------------------+
1 row in set (0.00 sec)
```

> 上面查询是`*`，由于name列所在的索引中只有`name、id`两个列的值，不包含`sex、email`，所以上面过程如下：
>
> 1. 走name索引检索`javacode3500000`对应的记录，取出id为`3500000`
> 2. 在主键索引中检索出`id=3500000`的记录，获取所有字段的值

#### 索引覆盖

> 查询中采用的索引树中包含了查询所需要的所有字段的值，不需要再去聚集索引检索数据，这种叫索引覆盖。

我们来看一个查询：

```
select id,name from test1 where name='javacode3500000';
```

> name对应idx1索引，id为主键，所以idx1索引树叶子节点中包含了name、id的值，这个查询只用走idx1这一个索引就可以了，如果select后面使用`*`，还需要一次回表获取sex、email的值。
>
> 所以写sql的时候，尽量避免使用`*`，`*`可能会多一次回表操作，需要看一下是否可以使用索引覆盖来实现，效率更高一些。

#### 索引下推

> 简称ICP，Index Condition Pushdown(ICP)是MySQL 5.6中新特性，是一种在存储引擎层使用索引过滤数据的一种优化方式，ICP可以减少存储引擎访问基表的次数以及MySQL服务器访问存储引擎的次数。

举个例子来说一下：

> 我们需要查询name以`javacode35`开头的，性别为1的记录数，sql如下：

```
mysql> select count(id) from test1 a where name like 'javacode35%' and sex = 1;
+-----------+
| count(id) |
+-----------+
|     55556 |
+-----------+
1 row in set (0.19 sec)
```

过程：

> 1. 走name索引检索出以javacode35的第一条记录，得到记录的id
> 2. 利用id去主键索引中查询出这条记录R1
> 3. 判断R1中的sex是否为1，然后重复上面的操作，直到找到所有记录为止。
>
> 上面的过程中需要走name索引以及需要回表操作。

如果采用ICP的方式，我们可以这么做，创建一个(name,sex)的组合索引，查询过程如下：

> 1. 走(name,sex)索引检索出以javacode35的第一条记录，可以得到(name,sex,id)，记做R1
> 2. 判断R1.sex是否为1，然后重复上面的操作，知道找到所有记录为止
>
> 这个过程中不需要回表操作了，通过索引的数据就可以完成整个条件的过滤，速度比上面的更快一些。

#### 数字使字符串类索引失效

```
mysql> insert into test1 (id,name,sex,email) values (4000001,'1',1,'javacode2018@163.com');
Query OK, 1 row affected (0.00 sec)

mysql> select * from test1 where name = '1';
+---------+------+-----+----------------------+
| id      | name | sex | email                |
+---------+------+-----+----------------------+
| 4000001 | 1    |   1 | javacode2018@163.com |
+---------+------+-----+----------------------+
1 row in set (0.00 sec)

mysql> select * from test1 where name = 1;
+---------+------+-----+----------------------+
| id      | name | sex | email                |
+---------+------+-----+----------------------+
| 4000001 | 1    |   1 | javacode2018@163.com |
+---------+------+-----+----------------------+
1 row in set, 65535 warnings (3.30 sec)
```

> 上面3条sql，我们插入了一条记录。
>
> 第二条查询很快，第三条用name和1比较，name上有索引，name是字符串类型，字符串和数字比较的时候，会将字符串强制转换为数字，然后进行比较，所以第二个查询变成了全表扫描，只能取出每条数据，将name转换为数字和1进行比较。

数字字段和字符串比较什么效果呢？如下：

```
mysql> select * from test1 where id = '4000000';
+---------+-----------------+-----+-------------------------+
| id      | name            | sex | email                   |
+---------+-----------------+-----+-------------------------+
| 4000000 | javacode4000000 |   2 | javacode4000000@163.com |
+---------+-----------------+-----+-------------------------+
1 row in set (0.00 sec)

mysql> select * from test1 where id = 4000000;
+---------+-----------------+-----+-------------------------+
| id      | name            | sex | email                   |
+---------+-----------------+-----+-------------------------+
| 4000000 | javacode4000000 |   2 | javacode4000000@163.com |
+---------+-----------------+-----+-------------------------+
1 row in set (0.00 sec)
```

> id上面有主键索引，id是int类型的，可以看到，上面两个查询都非常快，都可以正常利用索引快速检索，所以如果字段是数组类型的，查询的值是字符串还是数组都会走索引。

#### 函数使索引无效

```
mysql> select a.name+1 from test1 a where a.name = 'javacode1';
+----------+
| a.name+1 |
+----------+
|        1 |
+----------+
1 row in set, 1 warning (0.00 sec)

mysql> select * from test1 a where concat(a.name,'1') = 'javacode11';
+----+-----------+-----+-------------------+
| id | name      | sex | email             |
+----+-----------+-----+-------------------+
|  1 | javacode1 |   1 | javacode1@163.com |
+----+-----------+-----+-------------------+
1 row in set (2.88 sec)
```

> name上有索引，上面查询，第一个走索引，第二个不走索引，第二个使用了函数之后，name所在的索引树是无法快速定位需要查找的数据所在的页的，只能将所有页的记录加载到内存中，然后对每条数据使用函数进行计算之后再进行条件判断，此时索引无效了，变成了全表数据扫描。

**结论：索引字段使用函数查询使索引无效。**

#### 运算符使索引无效

```
mysql> select * from test1 a where id = 2 - 1;
+----+-----------+-----+-------------------+
| id | name      | sex | email             |
+----+-----------+-----+-------------------+
|  1 | javacode1 |   1 | javacode1@163.com |
+----+-----------+-----+-------------------+
1 row in set (0.00 sec)

mysql> select * from test1 a where id+1 = 2;
+----+-----------+-----+-------------------+
| id | name      | sex | email             |
+----+-----------+-----+-------------------+
|  1 | javacode1 |   1 | javacode1@163.com |
+----+-----------+-----+-------------------+
1 row in set (2.41 sec)
```

> id上有主键索引，上面查询，第一个走索引，第二个不走索引，第二个使用运算符，id所在的索引树是无法快速定位需要查找的数据所在的页的，只能将所有页的记录加载到内存中，然后对每条数据的id进行计算之后再判断是否等于1，此时索引无效了，变成了全表数据扫描。

**结论：索引字段使用了函数将使索引无效。**

#### 使用索引优化排序

我们有个订单表t_order(id,user_id,addtime,price)，经常会查询某个用户的订单，并且按照addtime升序排序，应该怎么创建索引呢？我们来分析一下。

在user_id上创建索引，我们分析一下这种情况，数据检索的过程：

1. 走user_id索引，找到记录的的id
2. 通过id在主键索引中回表检索出整条数据
3. 重复上面的操作，获取所有目标记录
4. 在内存中对目标记录按照addtime进行排序

我们要知道当数据量非常大的时候，排序还是比较慢的，可能会用到磁盘中的文件，有没有一种方式，查询出来的数据刚好是排好序的。

我们再回顾一下mysql中b+树数据的结构，记录是按照索引的值排序组成的链表，如果将user_id和addtime放在一起组成联合索引(user_id,addtime)，这样通过user_id检索出来的数据自然就是按照addtime排好序的，这样直接少了一步排序操作，效率更好，如果需addtime降序，只需要将结果翻转一下就可以了。

### 总结一下使用索引的一些建议

1. 在区分度高的字段上面建立索引可以有效的使用索引，区分度太低，无法有效的利用索引，可能需要扫描所有数据页，此时和不使用索引差不多
2. 联合索引注意最左匹配原则：必须按照从左到右的顺序匹配，mysql会一直向右匹配直到遇到范围查询(>、<、between、like)就停止匹配，比如a = 1 and b = 2 and c > 3 and d = 4 如果建立(a,b,c,d)顺序的索引，d是用不到索引的，如果建立(a,b,d,c)的索引则都可以用到，a,b,d的顺序可以任意调整
3. 查询记录的时候，少使用*，尽量去利用索引覆盖，可以减少回表操作，提升效率
4. 有些查询可以采用联合索引，进而使用到索引下推（IPC），也可以减少回表操作，提升效率
5. 禁止对索引字段使用函数、运算符操作，会使索引失效
6. 字符串字段和数字比较的时候会使索引无效
7. 模糊查询'%值%'会使索引无效，变为全表扫描，但是'值%'这种可以有效利用索引
8. 排序中尽量使用到索引字段，这样可以减少排序，提升查询效率