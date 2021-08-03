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