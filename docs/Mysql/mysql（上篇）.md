# 基本介绍

## 主要内容

1. 介绍mysql中常用的数据类型
2. mysql类型和java类型对应关系
3. 数据类型选择的一些建议

## MySQL的数据类型

**主要包括以下五大类**

- **整数类型**：`bit`、`bool`、`tinyint`、`smallint`、`mediumint`、`int`、`bigint`
- **浮点数类型**：`float`、`double`、`decimal`
- **字符串类型**：`char`、`varchar`、`tinyblob`、`blob`、`mediumblob`、`longblob`、`tinytext`、`text`、`mediumtext`、`longtext`
- **日期类型**：`Date`、`DateTime`、`TimeStamp`、`Time`、`Year`
- 其他数据类型：暂不介绍，用的比较少。

## 整数类型

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaIxGQgcI6eBlwnFEoydkwbmy5IFWUMqLEldOccODPIawPjlNT2Srqjg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

上面表格中有符号和无符号写反了，[]包含的内容是可选的，默认是无符号类型的，无符号的需要在类型后面跟上`unsigned`

### 示例1：有符号类型

```sql
mysql> create table demo1(
      c1 tinyint
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into demo1 values(-pow(2,7)),(pow(2,7)-1);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from demo1;
+------+
| c1   |
+------+
| -128 |
|  127 |
+------+
2 rows in set (0.00 sec)

mysql> insert into demo1 values(pow(2,7));
ERROR 1264 (22003): Out of range value for column 'c1' at row 1
```

demo1表中`c1`字段为tinyint有符号类型的，可以看一下上面的演示，有超出范围报错的。

关于数值对应的范围计算方式属于计算机基础的一些知识，可以去看一下计算机的二进制表示相关的文章。

### 示例2：无符号类型

```sql
mysql> create table demo2(
      c1 tinyint unsigned
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into demo2 values (-1);
ERROR 1264 (22003): Out of range value for column 'c1' at row 1
mysql> insert into demo2 values (pow(2,8)+1);
ERROR 1264 (22003): Out of range value for column 'c1' at row 1
mysql> insert into demo2 values (0),(pow(2,8));

mysql> insert into demo2 values (0),(pow(2,8)-1);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from demo2;
+------+
| c1   |
+------+
|    0 |
|  255 |
+------+
2 rows in set (0.00 sec)
```

c1是无符号的tinyint类型的，插入了负数会报错。

### 类型(n)说明

在开发中，我们会碰到有些定义整型的写法是int(11)，这种写法个人感觉在开发过程中没有什么用途，不过还是来说一下，`int(N)`我们只需要记住两点：

- 无论N等于多少，int永远占4个字节
- **N表示的是显示宽度，不足的用0补足，超过的无视长度而直接显示整个数字，但这要整型设置了unsigned zerofill才有效**

**看一下示例，理解更方便：**

```
mysql> CREATE TABLE test3 (
       `a` int,
       `b` int(5),
       `c` int(5) unsigned,
       `d` int(5) zerofill,
       `e` int(5) unsigned zerofill,
       `f` int    zerofill,
       `g` int    unsigned zerofill
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test3 values (1,1,1,1,1,1,1),(11,11,11,11,11,11,11),(12345,12345,12345,12345,12345,12345,12345);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from test3;
+-------+-------+-------+-------+-------+------------+------------+
| a     | b     | c     | d     | e     | f          | g          |
+-------+-------+-------+-------+-------+------------+------------+
|     1 |     1 |     1 | 00001 | 00001 | 0000000001 | 0000000001 |
|    11 |    11 |    11 | 00011 | 00011 | 0000000011 | 0000000011 |
| 12345 | 12345 | 12345 | 12345 | 12345 | 0000012345 | 0000012345 |
+-------+-------+-------+-------+-------+------------+------------+
3 rows in set (0.00 sec)

mysql> show create table test3;
| Table | Create Table                                                   
| test3 | CREATE TABLE `test3` (
  `a` int(11) DEFAULT NULL,
  `b` int(5) DEFAULT NULL,
  `c` int(5) unsigned DEFAULT NULL,
  `d` int(5) unsigned zerofill DEFAULT NULL,
  `e` int(5) unsigned zerofill DEFAULT NULL,
  `f` int(10) unsigned zerofill DEFAULT NULL,
  `g` int(10) unsigned zerofill DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)
```

`show create table test3;`输出了表`test3`的创建语句，和我们原始的创建语句不一致了，原始的`d`字段用的是无符号的，可以看出当使用了`zerofill`自动会将无符号提升为有符号。

**说明：**

> int(5)输出宽度不满5时，前面用0来进行填充
>
> int(n)中的n省略的时候，**宽度为对应类型无符号最大值的十进制的长度**，如bigint无符号最大值为2的64次方-1等于18,446,744,073,709,551,615‬；
>
> 长度是20位，来个bigint左边0填充的示例看一下

```
mysql> CREATE TABLE test4 (
       `a`  bigint    zerofill
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test4 values(1);
Query OK, 1 row affected (0.00 sec)

mysql> select *from test4;
+----------------------+
| a                    |
+----------------------+
| 00000000000000000001 |
+----------------------+
1 row in set (0.00 sec)
```

上面的结果中1前面补了19个0，和期望的结果一致。

## 浮点类型（容易懵，注意看）

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbasMiaONxNweQQObY92rp6n2JQRNMGj6y5uicg6jsWibiaQAIicpbxvVB6EOA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

float数值类型用于表示单精度浮点数值，而double数值类型用于表示双精度浮点数值，float和double都是浮点型，而decimal是定点型。

浮点型和定点型可以用类型名称后加（M，D）来表示，M表示该值的总共长度，D表示小数点后面的长度，M和D又称为精度和标度。

float和double在不指定精度时，默认会按照实际的精度来显示，而DECIMAL在不指定精度时，默认整数为10，小数为0。

### 示例1(重点)

```
mysql> create table test5(a float(5,2),b double(5,2),c decimal(5,2));
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test5 values (1,1,1),(2.1,2.1,2.1),(3.123,3.123,3.123),(4.125,4.125,4.125),(5.115,5.115,5.115),(6.126,6.126,6.126),(7.116,7.116,7.116),(8.1151,8.1151,8.1151),(9.1251,9.1251,9.1251),(10.11501,10.11501,10.11501),(11.12501,11.12501,11.12501);
Query OK, 7 rows affected, 5 warnings (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 5

mysql> select * from test5;
+-------+-------+-------+
| a     | b     | c     |
+-------+-------+-------+
|  1.00 |  1.00 |  1.00 |
|  2.10 |  2.10 |  2.10 |
|  3.12 |  3.12 |  3.12 |
|  4.12 |  4.12 |  4.13 |
|  5.12 |  5.12 |  5.12 |
|  6.13 |  6.13 |  6.13 |
|  7.12 |  7.12 |  7.12 |
|  8.12 |  8.12 |  8.12 |
|  9.13 |  9.13 |  9.13 |
| 10.12 | 10.12 | 10.12 |
| 11.13 | 11.13 | 11.13 |
+-------+-------+-------+
11 rows in set (0.00 sec)
```

**结果说明（注意看）：**

> c是decimal类型，认真看一下输入和输出，发现**decimal采用的是四舍五入**
>
> 认真看一下`a`和`b`的输入和输出，尽然不是四舍五入，一脸闷逼，float和double采用的是**四舍六入五成双**
>
> decimal插入的数据超过精度之后会触发警告。

**什么是四舍六入五成双？**

> 就是5以下舍弃5以上进位，如果需要处理数字为5的时候，需要看5后面是否还有不为0的任何数字，如果有，则直接进位，如果没有，需要看5前面的数字，若是奇数则进位，若是偶数则将5舍掉

### 示例2

我们将浮点类型的（M,D）精度和标度都去掉，看看效果：

```
mysql> create table test6(a float,b double,c decimal);
Query OK, 0 rows affected (0.02 sec)

mysql> insert into test6 values (1,1,1),(1.234,1.234,1.4),(1.234,0.01,1.5);
Query OK, 3 rows affected, 2 warnings (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 2

mysql> select * from test6;
+-------+-------+------+
| a     | b     | c    |
+-------+-------+------+
|     1 |     1 |    1 |
| 1.234 | 1.234 |    1 |
| 1.234 |  0.01 |    1 |
+-------+-------+------+
3 rows in set (0.00 sec)
```

**说明：**

> a和b的数据正确插入，而c被截断了
>
> 浮点数float、double如果不写精度和标度，则会按照实际显示
>
> decimal不写精度和标度，小数点后面的会进行四舍五入，并且插入时会有警告!

**再看一下下面代码：**

```
mysql> select sum(a),sum(b),sum(c) from test5;
+--------+--------+--------+
| sum(a) | sum(b) | sum(c) |
+--------+--------+--------+
|  67.21 |  67.21 |  67.22 |
+--------+--------+--------+
1 row in set (0.00 sec)

mysql> select sum(a),sum(b),sum(c) from test6;
+--------------------+--------------------+--------+
| sum(a)             | sum(b)             | sum(c) |
+--------------------+--------------------+--------+
| 3.4679999351501465 | 2.2439999999999998 |      4 |
+--------------------+--------------------+--------+
1 row in set (0.00 sec)
```

从上面sum的结果可以看出`float`、`double`会存在精度问题，`decimal`精度正常的，比如银行对统计结果要求比较精准的建议使用`decimal`。

## 日期类型

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaMSt9coVGdwoJxOZXr2cQAY2lReDBOwx3XLJyicRB6KYlld5WlBYWWicQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## 字符串类型

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaTvZI4iccFvTq9wTQ5CPug3kelEIPS2NDHCW2RlpQrwk4FuTEuvrwNqQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

char类型占用固定长度，如果存放的数据为固定长度的建议使用char类型，如：手机号码、身份证等固定长度的信息。

表格中的L表示存储的数据本身占用的字节，L 以外所需的额外字节为存放该值的长度所需的字节数。

MySQL 通过存储值的内容及其长度来处理可变长度的值，这些额外的字节是无符号整数。

请注意，可变长类型的最大长度、此类型所需的额外字节数以及占用相同字节数的无符号整数之间的对应关系：

> 例如，MEDIUMBLOB 值可能最多2的24次方 - 1字节长并需要3个字节记录其长度，3 个字节的整数类型MEDIUMINT 的最大无符号值为2的24次方 - 1。 

## mysql类型和java类型对应关系

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIban89tfKg1BjwwOtZtMofcb435wvrl6icABKacV5ZphEFHCibjR5tFaepQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaSDcDa1eJOCxGUgk4EUDib0jttPxYwooqUQlNMJVcpE13Giae9SndBcLw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## 数据类型选择的一些建议

- **选小不选大**：一般情况下选择可以正确存储数据的最小数据类型，越小的数据类型通常更快，占用磁盘，内存和CPU缓存更小。
- **简单就好**：简单的数据类型的操作通常需要更少的CPU周期，例如：整型比字符操作代价要小得多，因为字符集和校对规则(排序规则)使字符比整型比较更加复杂。
- **尽量避免NULL**：尽量制定列为NOT NULL，除非真的需要NULL类型的值，有NULL的列值会使得索引、索引统计和值比较更加复杂。
- **浮点类型的建议统一选择decimal**
- **记录时间的建议使用int或者bigint类型，将时间转换为时间戳格式，如将时间转换为秒、毫秒，进行存储，方便走索引**

# 数据类型

## 主要内容

1. 介绍mysql中常用的数据类型
2. mysql类型和java类型对应关系
3. 数据类型选择的一些建议

## MySQL的数据类型

**主要包括以下五大类**

- **整数类型**：`bit`、`bool`、`tinyint`、`smallint`、`mediumint`、`int`、`bigint`
- **浮点数类型**：`float`、`double`、`decimal`
- **字符串类型**：`char`、`varchar`、`tinyblob`、`blob`、`mediumblob`、`longblob`、`tinytext`、`text`、`mediumtext`、`longtext`
- **日期类型**：`Date`、`DateTime`、`TimeStamp`、`Time`、`Year`
- 其他数据类型：暂不介绍，用的比较少。

## 整数类型

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaIxGQgcI6eBlwnFEoydkwbmy5IFWUMqLEldOccODPIawPjlNT2Srqjg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

上面表格中有符号和无符号写反了，[]包含的内容是可选的，默认是无符号类型的，无符号的需要在类型后面跟上`unsigned`

### 示例1：有符号类型

```sql
mysql> create table demo1(
      c1 tinyint
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into demo1 values(-pow(2,7)),(pow(2,7)-1);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from demo1;
+------+
| c1   |
+------+
| -128 |
|  127 |
+------+
2 rows in set (0.00 sec)

mysql> insert into demo1 values(pow(2,7));
ERROR 1264 (22003): Out of range value for column 'c1' at row 1
```

demo1表中`c1`字段为tinyint有符号类型的，可以看一下上面的演示，有超出范围报错的。

关于数值对应的范围计算方式属于计算机基础的一些知识，可以去看一下计算机的二进制表示相关的文章。

### 示例2：无符号类型

```sql
mysql> create table demo2(
      c1 tinyint unsigned
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into demo2 values (-1);
ERROR 1264 (22003): Out of range value for column 'c1' at row 1
mysql> insert into demo2 values (pow(2,8)+1);
ERROR 1264 (22003): Out of range value for column 'c1' at row 1
mysql> insert into demo2 values (0),(pow(2,8));

mysql> insert into demo2 values (0),(pow(2,8)-1);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from demo2;
+------+
| c1   |
+------+
|    0 |
|  255 |
+------+
2 rows in set (0.00 sec)
```

c1是无符号的tinyint类型的，插入了负数会报错。

### 类型(n)说明

在开发中，我们会碰到有些定义整型的写法是int(11)，这种写法个人感觉在开发过程中没有什么用途，不过还是来说一下，`int(N)`我们只需要记住两点：

- 无论N等于多少，int永远占4个字节
- **N表示的是显示宽度，不足的用0补足，超过的无视长度而直接显示整个数字，但这要整型设置了unsigned zerofill才有效**

**看一下示例，理解更方便：**

```
mysql> CREATE TABLE test3 (
       `a` int,
       `b` int(5),
       `c` int(5) unsigned,
       `d` int(5) zerofill,
       `e` int(5) unsigned zerofill,
       `f` int    zerofill,
       `g` int    unsigned zerofill
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test3 values (1,1,1,1,1,1,1),(11,11,11,11,11,11,11),(12345,12345,12345,12345,12345,12345,12345);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from test3;
+-------+-------+-------+-------+-------+------------+------------+
| a     | b     | c     | d     | e     | f          | g          |
+-------+-------+-------+-------+-------+------------+------------+
|     1 |     1 |     1 | 00001 | 00001 | 0000000001 | 0000000001 |
|    11 |    11 |    11 | 00011 | 00011 | 0000000011 | 0000000011 |
| 12345 | 12345 | 12345 | 12345 | 12345 | 0000012345 | 0000012345 |
+-------+-------+-------+-------+-------+------------+------------+
3 rows in set (0.00 sec)

mysql> show create table test3;
| Table | Create Table                                                   
| test3 | CREATE TABLE `test3` (
  `a` int(11) DEFAULT NULL,
  `b` int(5) DEFAULT NULL,
  `c` int(5) unsigned DEFAULT NULL,
  `d` int(5) unsigned zerofill DEFAULT NULL,
  `e` int(5) unsigned zerofill DEFAULT NULL,
  `f` int(10) unsigned zerofill DEFAULT NULL,
  `g` int(10) unsigned zerofill DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)
```

`show create table test3;`输出了表`test3`的创建语句，和我们原始的创建语句不一致了，原始的`d`字段用的是无符号的，可以看出当使用了`zerofill`自动会将无符号提升为有符号。

**说明：**

> int(5)输出宽度不满5时，前面用0来进行填充
>
> int(n)中的n省略的时候，**宽度为对应类型无符号最大值的十进制的长度**，如bigint无符号最大值为2的64次方-1等于18,446,744,073,709,551,615‬；
>
> 长度是20位，来个bigint左边0填充的示例看一下

```
mysql> CREATE TABLE test4 (
       `a`  bigint    zerofill
     );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test4 values(1);
Query OK, 1 row affected (0.00 sec)

mysql> select *from test4;
+----------------------+
| a                    |
+----------------------+
| 00000000000000000001 |
+----------------------+
1 row in set (0.00 sec)
```

上面的结果中1前面补了19个0，和期望的结果一致。

## 浮点类型（容易懵，注意看）

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbasMiaONxNweQQObY92rp6n2JQRNMGj6y5uicg6jsWibiaQAIicpbxvVB6EOA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

float数值类型用于表示单精度浮点数值，而double数值类型用于表示双精度浮点数值，float和double都是浮点型，而decimal是定点型。

浮点型和定点型可以用类型名称后加（M，D）来表示，M表示该值的总共长度，D表示小数点后面的长度，M和D又称为精度和标度。

float和double在不指定精度时，默认会按照实际的精度来显示，而DECIMAL在不指定精度时，默认整数为10，小数为0。

### 示例1(重点)

```
mysql> create table test5(a float(5,2),b double(5,2),c decimal(5,2));
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test5 values (1,1,1),(2.1,2.1,2.1),(3.123,3.123,3.123),(4.125,4.125,4.125),(5.115,5.115,5.115),(6.126,6.126,6.126),(7.116,7.116,7.116),(8.1151,8.1151,8.1151),(9.1251,9.1251,9.1251),(10.11501,10.11501,10.11501),(11.12501,11.12501,11.12501);
Query OK, 7 rows affected, 5 warnings (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 5

mysql> select * from test5;
+-------+-------+-------+
| a     | b     | c     |
+-------+-------+-------+
|  1.00 |  1.00 |  1.00 |
|  2.10 |  2.10 |  2.10 |
|  3.12 |  3.12 |  3.12 |
|  4.12 |  4.12 |  4.13 |
|  5.12 |  5.12 |  5.12 |
|  6.13 |  6.13 |  6.13 |
|  7.12 |  7.12 |  7.12 |
|  8.12 |  8.12 |  8.12 |
|  9.13 |  9.13 |  9.13 |
| 10.12 | 10.12 | 10.12 |
| 11.13 | 11.13 | 11.13 |
+-------+-------+-------+
11 rows in set (0.00 sec)
```

**结果说明（注意看）：**

> c是decimal类型，认真看一下输入和输出，发现**decimal采用的是四舍五入**
>
> 认真看一下`a`和`b`的输入和输出，尽然不是四舍五入，一脸闷逼，float和double采用的是**四舍六入五成双**
>
> decimal插入的数据超过精度之后会触发警告。

**什么是四舍六入五成双？**

> 就是5以下舍弃5以上进位，如果需要处理数字为5的时候，需要看5后面是否还有不为0的任何数字，如果有，则直接进位，如果没有，需要看5前面的数字，若是奇数则进位，若是偶数则将5舍掉

### 示例2

我们将浮点类型的（M,D）精度和标度都去掉，看看效果：

```
mysql> create table test6(a float,b double,c decimal);
Query OK, 0 rows affected (0.02 sec)

mysql> insert into test6 values (1,1,1),(1.234,1.234,1.4),(1.234,0.01,1.5);
Query OK, 3 rows affected, 2 warnings (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 2

mysql> select * from test6;
+-------+-------+------+
| a     | b     | c    |
+-------+-------+------+
|     1 |     1 |    1 |
| 1.234 | 1.234 |    1 |
| 1.234 |  0.01 |    1 |
+-------+-------+------+
3 rows in set (0.00 sec)
```

**说明：**

> a和b的数据正确插入，而c被截断了
>
> 浮点数float、double如果不写精度和标度，则会按照实际显示
>
> decimal不写精度和标度，小数点后面的会进行四舍五入，并且插入时会有警告!

**再看一下下面代码：**

```
mysql> select sum(a),sum(b),sum(c) from test5;
+--------+--------+--------+
| sum(a) | sum(b) | sum(c) |
+--------+--------+--------+
|  67.21 |  67.21 |  67.22 |
+--------+--------+--------+
1 row in set (0.00 sec)

mysql> select sum(a),sum(b),sum(c) from test6;
+--------------------+--------------------+--------+
| sum(a)             | sum(b)             | sum(c) |
+--------------------+--------------------+--------+
| 3.4679999351501465 | 2.2439999999999998 |      4 |
+--------------------+--------------------+--------+
1 row in set (0.00 sec)
```

从上面sum的结果可以看出`float`、`double`会存在精度问题，`decimal`精度正常的，比如银行对统计结果要求比较精准的建议使用`decimal`。

## 日期类型

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaMSt9coVGdwoJxOZXr2cQAY2lReDBOwx3XLJyicRB6KYlld5WlBYWWicQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## 字符串类型

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaTvZI4iccFvTq9wTQ5CPug3kelEIPS2NDHCW2RlpQrwk4FuTEuvrwNqQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

char类型占用固定长度，如果存放的数据为固定长度的建议使用char类型，如：手机号码、身份证等固定长度的信息。

表格中的L表示存储的数据本身占用的字节，L 以外所需的额外字节为存放该值的长度所需的字节数。

MySQL 通过存储值的内容及其长度来处理可变长度的值，这些额外的字节是无符号整数。

请注意，可变长类型的最大长度、此类型所需的额外字节数以及占用相同字节数的无符号整数之间的对应关系：

> 例如，MEDIUMBLOB 值可能最多2的24次方 - 1字节长并需要3个字节记录其长度，3 个字节的整数类型MEDIUMINT 的最大无符号值为2的24次方 - 1。 

## mysql类型和java类型对应关系

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIban89tfKg1BjwwOtZtMofcb435wvrl6icABKacV5ZphEFHCibjR5tFaepQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06AauZYqVmVjRx775gMGBIbaSDcDa1eJOCxGUgk4EUDib0jttPxYwooqUQlNMJVcpE13Giae9SndBcLw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## 数据类型选择的一些建议

- **选小不选大**：一般情况下选择可以正确存储数据的最小数据类型，越小的数据类型通常更快，占用磁盘，内存和CPU缓存更小。
- **简单就好**：简单的数据类型的操作通常需要更少的CPU周期，例如：整型比字符操作代价要小得多，因为字符集和校对规则(排序规则)使字符比整型比较更加复杂。
- **尽量避免NULL**：尽量制定列为NOT NULL，除非真的需要NULL类型的值，有NULL的列值会使得索引、索引统计和值比较更加复杂。
- **浮点类型的建议统一选择decimal**
- **记录时间的建议使用int或者bigint类型，将时间转换为时间戳格式，如将时间转换为秒、毫秒，进行存储，方便走索引**

# 管理员权限

## 本文主要内容

1. 介绍Mysql权限工作原理
2. 查看所有用户
3. 创建用户
4. 修改密码
5. 给用户授权
6. 查看用户权限
7. 撤销用户权限
8. 删除用户
9. 授权原则说明
10. 总结

## Mysql权限工作原理

**mysql是如何来识别一个用户的呢？**

mysql为了安全性考虑，采用`主机名+用户名`来判断一个用户的身份，因为在互联网中很难通过用户名来判断一个用户的身份，但是我们可以通过ip或者主机名判断一台机器，某个用户通过这个机器过来的，我们可以识别为一个用户，所以**mysql中采用用户名+主机名来识别用户的身份**。当一个用户对mysql发送指令的时候，mysql就是通过用户名和来源（主机）来断定用户的权限。

**Mysql权限验证分为2个阶段：**

1. 阶段1：连接数据库，此时mysql会根据你的用户名及你的来源（ip或者主机名称）判断是否有权限连接
2. 阶段2：对mysql服务器发起请求操作，如create table、select、delete、update、create index等操作，此时mysql会判断你是否有权限操作这些指令

## 权限生效时间

用户及权限信息放在库名为mysql的库中，mysql启动时，这些内容被读进内存并且从此时生效，所以如果通过直接操作这些表来修改用户及权限信息的，需要`重启mysql`或者执行`flush privileges;`才可以生效。

用户登录之后，mysql会和当前用户之间创建一个连接，此时用户相关的权限信息都保存在这个连接中，存放在内存中，此时如果有其他地方修改了当前用户的权限，这些变更的权限会在下一次登录时才会生效。

## 查看mysql中所有用户

用户信息在`mysql.user`表中，如下：

```
mysql> use mysql;
Database changed
mysql> select user,host from user;
+---------------+--------------+
| user          | host         |
+---------------+--------------+
| test4         | 127.0.0.%    |
| test4         | 192.168.11.% |
| mysql.session | localhost    |
| mysql.sys     | localhost    |
| root          | localhost    |
| test2         | localhost    |
+---------------+--------------+
6 rows in set (0.00 sec)
```

## 创建用户

**语法：**

```
create user 用户名[@主机名] [identified by '密码'];
```

> 说明：
>
> 1. 主机名默认值为%，表示这个用户可以从任何主机连接mysql服务器
> 2. 密码可以省略，表示无密码登录

**示例1：不指定主机名**

> 不指定主机名时，表示这个用户可以从任何主机连接mysql服务器

```
mysql> use mysql;
Database changed

mysql> select user,host from user;
+---------------+-----------+
| user          | host      |
+---------------+-----------+
| mysql.session | localhost |
| mysql.sys     | localhost |
| root          | localhost |
+---------------+-----------+
3 rows in set (0.00 sec)

mysql> create user test1;
Query OK, 0 rows affected (0.00 sec)

mysql> select user,host from user;
+---------------+-----------+
| user          | host      |
+---------------+-----------+
| test1         | %         |
| mysql.session | localhost |
| mysql.sys     | localhost |
| root          | localhost |
+---------------+-----------+
4 rows in set (0.00 sec)

mysql> exit
Bye

C:\Users\Think>mysql -utest1
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 49
Server version: 5.7.25-log MySQL Community Server (GPL)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

上面创建了用户名为`test1`无密码的用户，没有指定主机，可以看出host的默认值为`%`，表示`test1`可以从任何机器登录到mysql中。

用户创建之后可以在`mysql`库中通过 `select user,host from user;`查看到。

**其他示例**

```
create user 'test2'@'localhost' identified by '123';
```

说明：test2的主机为localhost表示本机，此用户只能登陆本机的mysql

```
create user 'test3'@% identified by '123';
```

说明：test3可以从任何机器连接到mysql服务器

```
create user 'test4'@'192.168.11.%' identified by '123';
```

说明：test4可以从192.168.11段的机器连接mysql

## 修改密码【3种方式】

**方式1：通过管理员修改密码**

```
SET PASSWORD FOR '用户名'@'主机' = PASSWORD('密码');
```

**方式2：create user 用户名[@主机名] [identified by '密码'];**

```
set password = password('密码');
```

**方式3：通过修改mysql.user表修改密码**

```
use mysql;
update user set authentication_string = password('321') where user = 'test1' and host = '%';
flush privileges;
```

**注意：**

**通过表的方式修改之后，需要执行`flush privileges;`才能对用户生效。**

**5.7中user表中的authentication_string字段表示密码，老的一些版本中密码字段是password。**

## 给用户授权

创建用户之后，需要给用户授权，才有意义。

**语法：**

```
grant privileges ON database.table TO 'username'[@'host'] [with grant option]
```

**grant命令说明：**

- priveleges (权限列表)，可以是`all`，表示所有权限，也可以是`select、update`等权限，多个权限之间用逗号分开。
- ON 用来指定权限针对哪些库和表，格式为`数据库.表名` ，点号前面用来指定数据库名，点号后面用来指定表名，`*.*` 表示所有数据库所有表。
- TO 表示将权限赋予某个用户, 格式为`username@host`，@前面为用户名，@后面接限制的主机，可以是IP、IP段、域名以及%，%表示任何地方。
- WITH GRANT OPTION 这个选项表示该用户可以将自己拥有的权限授权给别人。注意：经常有人在创建操作用户的时候不指定WITH GRANT OPTION选项导致后来该用户不能使用GRANT命令创建用户或者给其它用户授权。
  *备注：可以使用GRANT重复给用户添加权限，权限叠加，比如你先给用户添加一个select权限，然后又给用户添加一个insert权限，那么该用户就同时拥有了select和insert权限。*

**示例：**

```
grant all on *.* to 'test1'@‘%’;
```

说明：给test1授权可以操作所有库所有权限，相当于dba

```
grant select on seata.* to 'test1'@'%';
```

说明：test1可以对seata库中所有的表执行select

```
grant select,update on seata.* to 'test1'@'%';
```

说明：test1可以对seata库中所有的表执行select、update

```
grant select(user,host) on mysql.user to 'test1'@'localhost';
```

说明：test1用户只能查询mysql.user表的user,host字段

## 查看用户有哪些权限

**show grants for '用户名'[@'主机']**

主机可以省略，默认值为%，示例：

```
mysql> show grants for 'test1'@'localhost';
+--------------------------------------------------------------------+
| Grants for test1@localhost                                         |
+--------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'test1'@'localhost'                          |
| GRANT SELECT (host, user) ON `mysql`.`user` TO 'test1'@'localhost' |
+--------------------------------------------------------------------+
2 rows in set (0.00 sec)
```

**show grants;**

查看当前用户的权限，如：

```
mysql> show grants;
+---------------------------------------------------------------------+
| Grants for root@localhost                                           |
+---------------------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION |
| GRANT ALL PRIVILEGES ON `test`.* TO 'root'@'localhost'              |
| GRANT DELETE ON `seata`.* TO 'root'@'localhost'                     |
| GRANT PROXY ON ''@'' TO 'root'@'localhost' WITH GRANT OPTION        |
+---------------------------------------------------------------------+
4 rows in set (0.00 sec)
```

## 撤销用户的权限

**语法**

```
revoke privileges ON database.table FROM '用户名'[@'主机'];
```

可以先通过`show grants`命令查询一下用户对于的权限，然后使用`revoke`命令撤销用户对应的权限，示例：

```
mysql> show grants for 'test1'@'localhost';
+--------------------------------------------------------------------+
| Grants for test1@localhost                                         |
+--------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'test1'@'localhost'                          |
| GRANT SELECT (host, user) ON `mysql`.`user` TO 'test1'@'localhost' |
+--------------------------------------------------------------------+
2 rows in set (0.00 sec)

mysql> revoke select(host) on mysql.user from test1@localhost;
Query OK, 0 rows affected (0.00 sec)

mysql> show grants for 'test1'@'localhost';
+--------------------------------------------------------------+
| Grants for test1@localhost                                   |
+--------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'test1'@'localhost'                    |
| GRANT SELECT (user) ON `mysql`.`user` TO 'test1'@'localhost' |
+--------------------------------------------------------------+
2 rows in set (0.00 sec)
```

上面我们先通过`grants`命令查看test1的权限，然后调用revoke命令撤销对`mysql.user`表`host`字段的查询权限，最后又通过grants命令查看了test1的权限，和预期结果一致。

## 删除用户【2种方式】

**方式1：**

**drop user '用户名'[@‘主机’]**，示例：

```
mysql> drop user test1@localhost;
Query OK, 0 rows affected (0.00 sec)
```

drop的方式删除用户之后，用户下次登录就会起效。

**方式2：**

通过删除mysql.user表数据的方式删除，如下：

```
delete from user where user='用户名' and host='主机';
flush privileges;
```

注意通过表的方式删除的，需要调用`flush privileges;`刷新权限信息（权限启动的时候在内存中保存着，通过表的方式修改之后需要刷新一下）。

## 授权原则说明

- 只授予能满足需要的最小权限，防止用户干坏事，比如用户只是需要查询，那就只给select权限就可以了，不要给用户赋予update、insert或者delete权限
- 创建用户的时候限制用户的登录主机，一般是限制成指定IP或者内网IP段
- 初始化数据库的时候删除没有密码的用户，安装完数据库的时候会自动创建一些用户，这些用户默认没有密码
- 为每个用户设置满足密码复杂度的密码
- 定期清理不需要的用户，回收权限或者删除用户

## 总结

1. 通过命令的方式操作用户和权限不需要刷新，下次登录自动生效
2. 通过操作mysql库中表的方式修改、用户信息，需要调用`flush privileges;`刷新一下，下次登录自动生效
3. mysql识别用户身份的方式是：用户名+主机
4. 本文中讲到的一些指令中带主机的，主机都可以省略，默认值为%，表示所有机器
5. mysql中用户和权限的信息在库名为mysql的库中

# DDL常见操作

DDL：Data Define Language数据定义语言，主要用来对数据库、表进行一些管理操作。

如：建库、删库、建表、修改表、删除表、对列的增删改等等。

文中涉及到的语法用[]包含的内容属于可选项，下面做详细说明。

### 库的管理

#### 创建库

```
create database [if not exists] 库名;
```

#### 删除库

```
drop databases [if exists] 库名;
```

#### 建库通用的写法

```
drop database if exists 旧库名;
create database 新库名;
```

#### 示例

```
mysql> show databases like 'javacode2018';
+-------------------------+
| Database (javacode2018) |
+-------------------------+
| javacode2018            |
+-------------------------+
1 row in set (0.00 sec)

mysql> drop database if exists javacode2018;
Query OK, 0 rows affected (0.00 sec)

mysql> show databases like 'javacode2018';
Empty set (0.00 sec)

mysql> create database javacode2018;
Query OK, 1 row affected (0.00 sec)
```

`show databases like 'javacode2018';`列出`javacode2018`库信息。

### 表管理

#### 创建表

```
create table 表名(
    字段名1 类型[(宽度)] [约束条件] [comment '字段说明'],
    字段名2 类型[(宽度)] [约束条件] [comment '字段说明'],
    字段名3 类型[(宽度)] [约束条件] [comment '字段说明']
)[表的一些设置];
```

**注意：**

1. 在同一张表中，字段名不能相同
2. 宽度和约束条件为可选参数，字段名和类型是必须的
3. 最后一个字段后不能加逗号
4. 类型是用来限制 字段 必须以何种数据类型来存储记录
5. 类型其实也是对字段的约束(约束字段下的记录必须为XX类型)
6. 类型后写的 约束条件 是在类型之外的 额外添加的约束

**约束说明**

**not null**：标识该字段不能为空

```
mysql> create table test1(a int not null comment '字段a');
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test1 values (null);
ERROR 1048 (23000): Column 'a' cannot be null
mysql> insert into test1 values (1);
Query OK, 1 row affected (0.00 sec)

mysql> select * from test1;
+---+
| a |
+---+
| 1 |
+---+
1 row in set (0.00 sec)
```

**default value**：为该字段设置默认值，默认值为value

```
mysql> drop table IF EXISTS test2;
Query OK, 0 rows affected (0.01 sec)

mysql> create table test2(
    ->   a int not null comment '字段a',
    ->   b int not null default 0 comment '字段b'
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> insert into test2(a) values (1);
Query OK, 1 row affected (0.00 sec)

mysql> select *from test2;
+---+---+
| a | b |
+---+---+
| 1 | 0 |
+---+---+
1 row in set (0.00 sec)
```

> 上面插入时未设置b的值，自动取默认值0

**primary key**：标识该字段为该表的主键，可以唯一的标识记录，插入重复的会报错

两种写法，如下：

方式1：跟在列后，如下：

```
mysql> drop table IF EXISTS test3;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> create table test3(
    ->   a int not null comment '字段a' primary key
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test3 (a) values (1);
Query OK, 1 row affected (0.01 sec)

mysql> insert into test3 (a) values (1);
ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
```

方式2：在所有列定义之后定义，如下：

```
mysql> drop table IF EXISTS test4;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> create table test4(
    ->   a int not null comment '字段a',
    ->   b int not null default 0 comment '字段b',
    ->   primary key(a)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> insert into test4(a,b) values (1,1);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test4(a,b) values (1,2);
ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
```

> 插入重复的值，会报违法主键约束

方式2支持多字段作为主键，多个之间用逗号隔开，语法：primary key(字段1,字段2,字段n)，示例：

```
mysql> drop table IF EXISTS test7;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> create table test7(
    ->    a int not null comment '字段a',
    ->    b int not null comment '字段b',
    ->   PRIMARY KEY (a,b)
    ->  );
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> insert into test7(a,b) VALUES (1,1);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test7(a,b) VALUES (1,1);
ERROR 1062 (23000): Duplicate entry '1-1' for key 'PRIMARY'
```

**foreign key**：为表中的字段设置外键

**语法：foreign key(当前表的列名) references 引用的外键表(外键表中字段名称)**

```
mysql> drop table IF EXISTS test6;
Query OK, 0 rows affected (0.01 sec)

mysql> drop table IF EXISTS test5;
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> create table test5(
    ->   a int not null comment '字段a' primary key
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> create table test6(
    ->   b int not null comment '字段b',
    ->   ts5_a int not null,
    ->   foreign key(ts5_a) references test5(a)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test5 (a) values (1);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test6 (b,test6.ts5_a) values (1,1);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test6 (b,test6.ts5_a) values (2,2);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`javacode2018`.`test6`, CONSTRAINT `test6_ibfk_1` FOREIGN KEY (`ts5_a`) REFERENCES `test5` (`a`))
```

> 说明：表示test6中ts5_a字段的值来源于表test5中的字段a。
>
> 注意几点：
>
> - 两张表中需要建立外键关系的字段类型需要一致
> - 要设置外键的字段不能为主键
> - 被引用的字段需要为主键
> - 被插入的值在外键表必须存在，如上面向test6中插入ts5_a为2的时候报错了，原因：2的值在test5表中不存在

**unique key(uq)**：标识该字段的值是唯一的

支持一个到多个字段，插入重复的值会报违反唯一约束，会插入失败。

定义有2种方式。

方式1：跟在字段后，如下：

```
mysql> drop table IF EXISTS test8;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> create table test8(
    ->    a int not null comment '字段a' unique key
    ->  );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> insert into test8(a) VALUES (1);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test8(a) VALUES (1);
ERROR 1062 (23000): Duplicate entry '1' for key 'a'
```

方式2：所有列定义之后定义，如下：

```
mysql> drop table IF EXISTS test9;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> create table test9(
    ->    a int not null comment '字段a',
    ->   unique key(a)
    ->  );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> insert into test9(a) VALUES (1);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test9(a) VALUES (1);
ERROR 1062 (23000): Duplicate entry '1' for key 'a'
```

方式2支持多字段，多个之间用逗号隔开，语法：primary key(字段1,字段2,字段n)，示例：

```
mysql> drop table IF EXISTS test10;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> create table test10(
    ->   a int not null comment '字段a',
    ->   b int not null comment '字段b',
    ->   unique key(a,b)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> insert into test10(a,b) VALUES (1,1);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test10(a,b) VALUES (1,1);
ERROR 1062 (23000): Duplicate entry '1-1' for key 'a'
```

**auto_increment**：标识该字段的值自动增长（整数类型，而且为主键）

```
mysql> drop table IF EXISTS test11;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> create table test11(
    ->   a int not null AUTO_INCREMENT PRIMARY KEY comment '字段a',
    ->   b int not null comment '字段b'
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> insert into test11(b) VALUES (10);
Query OK, 1 row affected (0.00 sec)

mysql> insert into test11(b) VALUES (20);
Query OK, 1 row affected (0.00 sec)

mysql> select * from test11;
+---+----+
| a | b  |
+---+----+
| 1 | 10 |
| 2 | 20 |
+---+----+
2 rows in set (0.00 sec)
```

> 字段a为自动增长，默认值从1开始，每次+1
>
> 关于自动增长字段的初始值、步长可以在mysql中进行设置，比如设置初始值为1万，每次增长10

**注意：**

**自增长列当前值存储在内存中，数据库每次重启之后，会查询当前表中自增列的最大值作为当前值，如果表数据被清空之后，数据库重启了，自增列的值将从初始值开始**

我们来演示一下：

```
mysql> delete from test11;
Query OK, 2 rows affected (0.00 sec)

mysql> insert into test11(b) VALUES (10);
Query OK, 1 row affected (0.00 sec)

mysql> select * from test11;
+---+----+
| a | b  |
+---+----+
| 3 | 10 |
+---+----+
1 row in set (0.00 sec)
```

上面删除了test11数据，然后插入了一条，a的值为3，执行下面操作：

> 删除test11数据，重启mysql，插入数据，然后看a的值是不是被初始化了？如下：

```
mysql> delete from test11;
Query OK, 1 row affected (0.00 sec)

mysql> select * from test11;
Empty set (0.00 sec)

mysql> exit
Bye

C:\Windows\system32>net stop mysql
mysql 服务正在停止..
mysql 服务已成功停止。


C:\Windows\system32>net start mysql
mysql 服务正在启动 .
mysql 服务已经启动成功。


C:\Windows\system32>mysql -uroot -p
Enter password: *******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.25-log MySQL Community Server (GPL)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use javacode2018;
Database changed
mysql> select * from test11;
Empty set (0.01 sec)

mysql> insert into test11 (b) value (100);
Query OK, 1 row affected (0.00 sec)

mysql> select * from test11;
+---+-----+
| a | b   |
+---+-----+
| 1 | 100 |
+---+-----+
1 row in set (0.00 sec)
```

#### 删除表

```
drop table [if exists] 表名;
```

#### 修改表名

```
alter table 表名 rename [to] 新表名;
```

#### 表设置备注

```
alter table 表名 comment '备注信息';
```

#### 复制表

##### 只复制表结构

```
create table 表名 like 被复制的表名;
```

如：

```
mysql> create table test12 like test11;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from test12;
Empty set (0.00 sec)

mysql> show create table test12;
+--------+-------+
| Table  | Create Table                                                                                                                                           
+--------+-------+
| test12 | CREATE TABLE `test12` (
  `a` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段a',
  `b` int(11) NOT NULL COMMENT '字段b',
  PRIMARY KEY (`a`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8     |
+--------+-------+
1 row in set (0.00 sec)
```

##### 复制表结构+数据

```
create table 表名 [as] select 字段,... from 被复制的表 [where 条件];
```

如：

```
mysql> create table test13 as select * from test11;
Query OK, 1 row affected (0.02 sec)
Records: 1  Duplicates: 0  Warnings: 0

mysql> select * from test13;
+---+-----+
| a | b   |
+---+-----+
| 1 | 100 |
+---+-----+
1 row in set (0.00 sec)
```

表结构和数据都过来了。

### 表中列的管理

#### 添加列

```
alter table 表名 add column 列名 类型 [列约束];
```

示例：

```
mysql> drop table IF EXISTS test14;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql>
mysql> create table test14(
    ->   a int not null AUTO_INCREMENT PRIMARY KEY comment '字段a'
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> alter table test14 add column b int not null default 0 comment '字段b';
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table test14 add column c int not null default 0 comment '字段c';
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> insert into test14(b) values (10);
Query OK, 1 row affected (0.00 sec)

mysql> select * from test14;                                                 c
+---+----+---+
| a | b  | c |
+---+----+---+
| 1 | 10 | 0 |
+---+----+---+
1 row in set (0.00 sec)
```

#### 修改列

```
alter table 表名 modify column 列名 新类型 [约束];
或者
alter table 表名 change column 列名 新列名 新类型 [约束];
```

**2种方式区别：modify不能修改列名，change可以修改列名**

我们看一下test14的表结构：

```
mysql> show create table test14;
+--------+--------+
| Table  | Create Table |
+--------+--------+
| test14 | CREATE TABLE `test14` (
  `a` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段a',
  `b` int(11) NOT NULL DEFAULT '0' COMMENT '字段b',
  `c` int(11) NOT NULL DEFAULT '0' COMMENT '字段c',
  PRIMARY KEY (`a`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8       |
+--------+--------+
1 row in set (0.00 sec)
```

我们将字段c名字及类型修改一下，如下:

```
mysql> alter table test14 change column c d varchar(10) not null default '' comment '字段d';
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> show create table test14;                                                          ;;
+--------+--------+
| Table  | Create Table |
+--------+--------+
| test14 | CREATE TABLE `test14` (
  `a` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段a',
  `b` int(11) NOT NULL DEFAULT '0' COMMENT '字段b',
  `d` varchar(10) NOT NULL DEFAULT '' COMMENT '字段d',
  PRIMARY KEY (`a`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8       |
+--------+--------+
1 row in set (0.00 sec)
```

#### 删除列

```
alter table 表名 drop column 列名;
```

示例：

```sql
mysql> alter table test14 drop column d;
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> show create table test14;
+--------+--------+
| Table  | Create Table |
+--------+--------+
| test14 | CREATE TABLE `test14` (
  `a` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段a',
  `b` int(11) NOT NULL DEFAULT '0' COMMENT '字段b',
  PRIMARY KEY (`a`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8     |
+--------+--------+
1 row in set (0.00 sec)
```

# DML基本操作

DML(Data Manipulation Language)数据操作语言，以INSERT、UPDATE、DELETE三种指令为核心，分别代表插入、更新与删除，**是必须要掌握的指令**，DML和SQL中的select熟称CRUD（增删改查）。

文中涉及到的语法用[]包含的内容属于可选项，下面做详细说明。

### 插入操作

#### 插入单行2种方式

##### 方式1

```sql
insert into 表名[(字段,字段)] values (值,值);
```

> **说明：**
>
> 值和字段需要一一对应
>
> 如果是字符型或日期类型，值需要用单引号引起来；如果是数值类型，不需要用单引号
>
> 字段和值的个数必须一致，位置对应
>
> 字段如果不能为空，则必须插入值
>
> 可以为空的字段可以不用插入值，但需要注意：字段和值都不写；或字段写上，值用null代替
>
> 表名后面的字段可以省略不写，此时表示所有字段，顺序和表中字段顺序一致。

##### 方式2

```sql
insert into 表名 set 字段 = 值,字段 = 值;
```

方式2不常见，建议使用方式1

#### 批量插入2种方式

##### 方式1

```sql
insert into 表名 [(字段,字段)] values (值,值),(值,值),(值,值);
```

##### 方式2

```sql
insert into 表 [(字段,字段)]
数据来源select语句;
```

> **说明：**
>
> 数据来源select语句可以有很多种写法，需要注意：select返回的结果和插入数据的字段数量、顺序、类型需要一致。
>
> 关于select的写法后面文章会详细介绍。

如：

```
-- 删除test1
drop table if exists test1;
-- 创建test1
create table test1(a int,b int);
-- 删除test2
drop table if exists test2;
-- 创建test2
create table test2(c1 int,c2 int,c3 int);
-- 向test2中插入数据
insert into test2 values (100,101,102),(200,201,202),(300,301,302),(400,401,402);
-- 向test1中插入数据
insert into test1 (a,b) select 1,1 union all select 2,2 union all select 2,2;
-- 向test1插入数据，数据来源于test2表
insert into test1 (a,b) select c2,c3 from test2 where c1>=200;

select * from test1;

mysql> select * from test1;
+------+------+
| a    | b    |
+------+------+
|    1 |    1 |
|    2 |    2 |
|    2 |    2 |
|  201 |  202 |
|  301 |  302 |
|  401 |  402 |

mysql> select * from test2;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
|  100 |  101 |  102 |
|  200 |  201 |  202 |
|  300 |  301 |  302 |
|  400 |  401 |  402 |
+------+------+------+
4 rows in set (0.00 sec)
```

### 数据更新

#### 单表更新

##### 语法：

```
update 表名 [[as] 别名] set [别名.]字段 = 值,[别名.]字段 = 值 [where条件];
```

> 有些表名可能名称比较长，为了方便操作，可以给这个表名起个简单的别名，更方便操作一些。
>
> 如果无别名的时候，表名就是别名。

##### 示例：

```
mysql> update test1 t set t.a = 2;
Query OK, 4 rows affected (0.00 sec)
Rows matched: 6  Changed: 4  Warnings: 0

mysql> update test1 as t set t.a = 3;
Query OK, 6 rows affected (0.00 sec)
Rows matched: 6  Changed: 6  Warnings: 0

mysql> update test1 set a = 1,b=2;
Query OK, 6 rows affected (0.00 sec)
Rows matched: 6  Changed: 6  Warnings: 0
```

#### 多表更新

> 可以同时更新多个表中的数据

##### 语法：

```
update 表1 [[as] 别名1],表名2 [[as] 别名2]
set [别名.]字段 = 值,[别名.]字段 = 值
[where条件]
```

##### 示例：

```
-- 无别名方式
update test1,test2 set test1.a = 2 ,test1.b = 2, test2.c1 = 10;
-- 无别名方式
update test1,test2 set test1.a = 2 ,test1.b = 2, test2.c1 = 10 where test1.a = test2.c1;
-- 别名方式更新
update test1 t1,test2 t2 set t1.a = 2 ,t1.b = 2, t2.c1 = 10 where t1.a = t2.c1;
-- 别名的方式更新多个表的多个字段
update test1 as t1,test2 t2 set t1.a = 2 ,t1.b = 2, t2.c1 = 10 where t1.a = t2.c1;
```

#### 使用建议

建议采用单表方式更新，方便维护。

### 删除数据操作

#### 使用delete删除

##### delete单表删除

```
delete [别名] from 表名 [[as] 别名] [where条件];
```

> 注意：
>
> 如果无别名的时候，表名就是别名
>
> 如果有别名，delete后面必须写别名
>
> 如果没有别名，delete后面的别名可以省略不写。

##### 示例

```
-- 删除test1表所有记录
delete from test1;
-- 删除test1表所有记录
delete test1 from test1;
-- 有别名的方式，删除test1表所有记录
delete t1 from test1 t1;
-- 有别名的方式删除满足条件的记录
delete t1 from test1 t1 where t1.a>100;
```

> 上面的4种写法，大家可以认真看一下。

##### 多表删除

> 可以同时删除多个表中的记录，语法如下：

```
delete [别名1],[别名2] from 表1 [[as] 别名1],表2 [[as] 别名2] [where条件];
```

> 说明：
>
> 别名可以省略不写，但是需要在delete后面跟上表名，多个表名之间用逗号隔开。

##### 示例1

```
delete t1 from test1 t1,test2 t2 where t1.a=t2.c2;
```

> 删除test1表中的记录，条件是这些记录的字段a在test.c2中存在的记录

看一下运行效果：

```
-- 删除test1
drop table if exists test1;
-- 创建test1
create table test1(a int,b int);
-- 删除test2
drop table if exists test2;
-- 创建test2
create table test2(c1 int,c2 int,c3 int);
-- 向test2中插入数据
insert into test2 values (100,101,102),(200,201,202),(300,301,302),(400,401,402);
-- 向test1中插入数据
insert into test1 (a,b) select 1,1 union all select 2,2 union all select 2,2;
-- 向test1插入数据，数据来源于test2表
insert into test1 (a,b) select c2,c3 from test2 where c1>=200;

mysql> select * from test1;
+------+------+
| a    | b    |
+------+------+
|    1 |    1 |
|    2 |    2 |
|    2 |    2 |
|  201 |  202 |
|  301 |  302 |
|  401 |  402 |

mysql> select * from test2;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
|  100 |  101 |  102 |
|  200 |  201 |  202 |
|  300 |  301 |  302 |
|  400 |  401 |  402 |
+------+------+------+
4 rows in set (0.00 sec)

mysql> delete t1 from test1 t1,test2 t2 where t1.a=t2.c2;
Query OK, 3 rows affected (0.00 sec)

mysql> select * from test1;
+------+------+
| a    | b    |
+------+------+
|    1 |    1 |
|    2 |    2 |
|    2 |    2 |
+------+------+
3 rows in set (0.00 sec)
```

从上面的输出中可以看到test1表中3条记录被删除了。

##### 示例2

```
delete t2,t1 from test1 t1,test2 t2 where t1.a=t2.c2;
```

> 同时对2个表进行删除，条件是test.a=test.c2的记录

看一下运行效果：

```
-- 删除test1
drop table if exists test1;
-- 创建test1
create table test1(a int,b int);
-- 删除test2
drop table if exists test2;
-- 创建test2
create table test2(c1 int,c2 int,c3 int);
-- 向test2中插入数据
insert into test2 values (100,101,102),(200,201,202),(300,301,302),(400,401,402);
-- 向test1中插入数据
insert into test1 (a,b) select 1,1 union all select 2,2 union all select 2,2;
-- 向test1插入数据，数据来源于test2表
insert into test1 (a,b) select c2,c3 from test2 where c1>=200;

mysql> select * from test1;
+------+------+
| a    | b    |
+------+------+
|    1 |    1 |
|    2 |    2 |
|    2 |    2 |
|  201 |  202 |
|  301 |  302 |
|  401 |  402 |
+------+------+
6 rows in set (0.00 sec)

mysql> select * from test2;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
|  100 |  101 |  102 |
|  200 |  201 |  202 |
|  300 |  301 |  302 |
|  400 |  401 |  402 |
+------+------+------+
4 rows in set (0.00 sec)

mysql> delete t2,t1 from test1 t1,test2 t2 where t1.a=t2.c2;
Query OK, 6 rows affected (0.00 sec)

mysql> select * from test1;
+------+------+
| a    | b    |
+------+------+
|    1 |    1 |
|    2 |    2 |
|    2 |    2 |
+------+------+
3 rows in set (0.00 sec)

mysql> select * from test2;
+------+------+------+
| c1   | c2   | c3   |
+------+------+------+
|  100 |  101 |  102 |
+------+------+------+
1 row in set (0.00 sec)
```

从输出中可以看出test1和test2总计6条记录被删除了。

**平时我们用的比较多的方式是`delete from 表名`这种语法，上面我们介绍了再delete后面跟上表名的用法，大家可以在回顾一下，加深记忆。**

#### 使用truncate删除

##### 语法

```
truncate 表名;
```

#### drop，truncate，delete区别

- drop (删除表)：删除内容和定义，释放空间，简单来说就是**把整个表去掉**，以后要新增数据是不可能的，除非新增一个表。

  drop语句将删除表的结构被依赖的约束（constrain），触发器（trigger）索引（index），依赖于该表的存储过程/函数将被保留，但其状态会变为：invalid。

  如果要删除表定义及其数据，请使用 drop table 语句。

- truncate (清空表中的数据)：删除内容、释放空间但不删除定义(**保留表的数据结构**)，与drop不同的是，只是清空表数据而已。

  注意：truncate不能删除具体行数据，要删就要把整个表清空了。

- delete (删除表中的数据)：delete 语句用于**删除表中的行**。delete语句执行删除的过程是每次从表中删除一行，并且同时将该行的删除操作作为事务记录在日志中保存，以便进行进行回滚操作。

  truncate与不带where的delete ：只删除数据，而不删除表的结构（定义）

  truncate table 删除表中的所有行，但表结构及其列、约束、索引等保持不变。

  对于由foreign key约束引用的表，不能使用truncate table ，而应使用不带where子句的delete语句。由于truncate table 记录在日志中，所以它不能激活触发器。

  delete语句是数据库操作语言(dml)，这个操作会放到 rollback segement 中，**事务提交之后才生效**；如果有相应的 trigger，执行的时候将被触发。

  **truncate、drop 是数据库定义语言(ddl)，操作立即生效**，原数据不放到 rollback segment 中，不能回滚，操作不触发 trigger。

  **如果有自增列，truncate方式删除之后，自增列的值会被初始化，delete方式要分情况（如果数据库被重启了，自增列值也会被初始化，数据库未被重启，则不变）**

- **如果要删除表定义及其数据，请使用 drop table 语句**

- **安全性：小心使用 drop 和 truncate，尤其没有备份的时候，否则哭都来不及**

- **删除速度，一般来说: drop> truncate > delete**

![图片](https://mmbiz.qpic.cn/mmbiz_png/xicEJhWlK06ADdX54upy56Qj17e8BT15cFG5We0PhDHwTW9v7fPb9S8oZXG8ia7Jiac7e026QMXZJXkehrd3DfDjw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

# DQL基本操作

DQL(Data QueryLanguage)：数据查询语言，通俗点讲就是从数据库获取数据的，按照DQL的语法给数据库发送一条指令，数据库将按需求返回数据。

DQL分多篇来说，本文属于第1篇。

### 基本语法

```
select 查询的列 from 表名;
```

注意：

select语句中不区分大小写，SELECT和select、FROM和from效果一样。

查询的结果放在一个表格中，表格的第1行称为列头，第2行开始是数据，类属于一个二维数组。

### 查询常量

```
select 常量值1,常量值2,常量值3;
```

如：

```
mysql> select 1,'b';
+---+---+
| 1 | b |
+---+---+
| 1 | b |
+---+---+
1 row in set (0.00 sec)
```

### 查询表达式

```
select 表达式;
```

如：

```
mysql> select 1+2,3*10,10/3;
+-----+------+--------+
| 1+2 | 3*10 | 10/3   |
+-----+------+--------+
|   3 |   30 | 3.3333 |
+-----+------+--------+
1 row in set (0.00 sec)
```

### 查询函数

```
select 函数;
```

如：

```
mysql> select mod(10,4),isnull(null),ifnull(null,'第一个参数为空返回这个值'),ifnull(1,'第一个参数为空返回这个值，否知返回第一个参数');
+-----------+--------------+-----------------------------------------------------+--------------------------------------------------------------------------------+
| mod(10,4) | isnull(null) | ifnull(null,'第一个参数为空返回这个值')             | ifnull(1,'第一个参数为空返回这个值，否知返回第一个参数')                       |
+-----------+--------------+-----------------------------------------------------+--------------------------------------------------------------------------------+
|         2 |            1 | 第一个参数为空返回这个值                            | 1                                                                              |
+-----------+--------------+-----------------------------------------------------+--------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```

说明一下：

mod函数，对两个参数取模运算。

isnull函数，判断参数是否为空，若为空返回1，否则返回0。

ifnull函数，2个参数，判断第一个参数是否为空，如果为空返回第一个参数的值，否则返回第一个参数的值。

### 查询指定的字段

```
select 字段1,字段2,字段3 from 表名;
```

如：

```sql
mysql> drop table if exists test1;
Query OK, 0 rows affected (0.01 sec)

mysql> create table test1(a int not null comment '字段a',b varchar(10) not null default '' comment '字段b');
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test1 values(1,'a'),(2,'b'),(3,'c');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select a,b from test1;
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | b |
| 3 | c |
+---+---+
3 rows in set (0.00 sec)
```

说明：

test1表有两个字段a、b，`select a,b from test1;`用于查询`test1`中两个字段的数据。

### 查询所有列

```
select * from 表名
```

**说明：**

*表示返回表中所有字段。

如：

```
mysql> select * from test1;
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | b |
| 3 | c |
+---+---+
3 rows in set (0.00 sec)
```

### 列别名

在创建数据表时，一般都会使用英文单词或英文单词缩写来设置字段名，在查询时列名都会以英文的形式显示，这样会给用户查看数据带来不便，这种情况可以使用别名来代替英文列名，增强阅读性。

**语法：**

```
select 列 [as] 别名 from 表;
```

**使用双引号创建别名:**

```sql
mysql> select a "列1",b "列2" from test1;
+------+------+
| 列1  | 列2  |
+------+------+
|    1 | a    |
|    2 | b    |
|    3 | c    |
+------+------+
3 rows in set (0.00 sec)
```

**使用单引号创建别名：**

```
mysql> select a '列1',b '列2' from test1;;
+------+------+
| 列1  | 列2  |
+------+------+
|    1 | a    |
|    2 | b    |
|    3 | c    |
+------+------+
3 rows in set (0.00 sec)
```

**不用引号创建别名：**

```
mysql> select a 列1,b 列2 from test1;
+------+------+
| 列1  | 列2  |
+------+------+
|    1 | a    |
|    2 | b    |
|    3 | c    |
+------+------+
3 rows in set (0.00 sec)
```

**使用as创建别名：**

```sql
mysql> select a as 列1,b as 列 2 from test1;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '2 from test1' at line 1
mysql> select a as 列1,b as '列 2' from test1;
+------+-------+
| 列1  | 列 2  |
+------+-------+
|    1 | a     |
|    2 | b     |
|    3 | c     |
+------+-------+
3 rows in set (0.00 sec)
```

> 别名中有特殊符号的，比如空格，此时别名必须用引号引起来。

**懵逼示例，看效果：**

```
mysql> select 'a' 'b';
+----+
| a  |
+----+
| ab |
+----+
1 row in set (0.00 sec)

mysql> select 'a' b;
+---+
| b |
+---+
| a |
+---+
1 row in set (0.00 sec)

mysql> select 'a' "b";
+----+
| a  |
+----+
| ab |
+----+
1 row in set (0.00 sec)

mysql> select 'a' as "b";
+---+
| b |
+---+
| a |
+---+
1 row in set (0.00 sec)
```

认真看一下第1个和第3个返回的结果（列头和数据），是不是懵逼状态，建议这种的最好使用**as**，as后面跟上别名。

### 表别名

```
select 别名.字段,别名.* from 表名 [as] 别名;
```

如：

```sql
mysql> select t.a,t.b from test1 as t;
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | b |
| 3 | c |
+---+---+
3 rows in set (0.00 sec)

mysql> select t.a as '列 1',t.b as 列2 from test1 as t;
+-------+------+
| 列 1  | 列2  |
+-------+------+
|     1 | a    |
|     2 | b    |
|     3 | c    |
+-------+------+
3 rows in set (0.00 sec)

mysql> select t.* from test1 as t;                   
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | b |
| 3 | c |
+---+---+
3 rows in set (0.00 sec)

mysql> select * from test1 as t;
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | b |
| 3 | c |
+---+---+
3 rows in set (0.00 sec)
```

### 总结

- **建议别名前面跟上as关键字**
- **查询数据的时候，避免使用select \*，建议需要什么字段写什么字段**

# 条件查询

电商中：我们想查看某个用户所有的订单，或者想查看某个用户在某个时间段内所有的订单，此时我们需要对订单表数据进行筛选，按照用户、时间进行过滤，得到我们期望的结果。

此时我们需要使用条件查询来对指定表进行操作，我们需要了解sql中的条件查询常见的玩法。

### 本篇内容

1. 条件查询语法
2. 条件查询运算符详解（=、<、>、>=、<=、<>、!=）
3. 逻辑查询运算符详解（and、or）
4. like模糊查询介绍
5. between and查询
6. in、not in查询
7. NULL值存在的坑
8. is null/is not null（NULL值专用查询）
9. <=>（安全等于）运算符
10. 经典面试题

### 条件查询

语法：

```
select 列名 from 表名 where 列 运算符 值
```

> 说明：
>
> 注意关键字where，where后面跟上一个或者多个条件，条件是对前面数据的过滤，只有满足where后面条件的数据才会被返回。

下面介绍常见的查询运算符。

### 条件查询运算符

| 操作符     | 描述     |
| :--------- | :------- |
| =          | 等于     |
| <> 或者 != | 不等于   |
| >          | 大于     |
| <          | 小于     |
| >=         | 大于等于 |
| <=         | 小于等于 |

#### 等于（=）

```
select 列名 from 表名 where 列 = 值;
```

> 说明：
>
> 查询出指定的列和对应的值相等的记录。
>
> 值如果是字符串类型，需要用单引号或者双引号引起来。

示例：

```sql
mysql> create table test1 (a int,b varchar(10));
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test1 values (1,'abc'),(2,'bbb');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from test1;
+------+------+
| a    | b    |
+------+------+
|    1 | abc  |
|    2 | bbb  |
+------+------+
2 rows in set (0.00 sec)

mysql> select * from test1 where a=2;
+------+------+
| a    | b    |
+------+------+
|    2 | bbb  |
+------+------+
1 row in set (0.00 sec)

mysql> select * from test1 where b = 'abc';
+------+------+
| a    | b    |
+------+------+
|    1 | abc  |
+------+------+
1 row in set (0.00 sec)

mysql> select * from test1 where b = "abc";
+------+------+
| a    | b    |
+------+------+
|    1 | abc  |
+------+------+
1 row in set (0.00 sec)
```

#### 不等于（<>、!=）

不等于有两种写法：<>或者!=

```sql
select 列名 from 表名 where 列 <> 值;
或者
select 列名 from 表名 where 列 != 值;
```

示例：

```
mysql> select * from test1 where a<>1;
+------+------+
| a    | b    |
+------+------+
|    2 | bbb  |
+------+------+
1 row in set (0.00 sec)

mysql> select * from test1 where a!=1;
+------+------+
| a    | b    |
+------+------+
|    2 | bbb  |
+------+------+
1 row in set (0.00 sec)
```

> **注意：**
>
> <> 这个是最早的用法。
>
> !=是后来才加上的。
>
> 两者意义相同，在可移植性上前者优于后者
>
> 故而sql语句中尽量使用<>来做不等判断

#### 大于（>）

```
select 列名 from 表名 where 列 > 值;
```

示例：

```
mysql> select * from test1 where a>1;
+------+------+
| a    | b    |
+------+------+
|    2 | bbb  |
+------+------+
1 row in set (0.00 sec)

mysql> select * from test1 where b>'a';
+------+------+
| a    | b    |
+------+------+
|    1 | abc  |
|    2 | bbb  |
+------+------+
2 rows in set (0.00 sec)

mysql> select * from test1 where b>'ac';
+------+------+
| a    | b    |
+------+------+
|    2 | bbb  |
+------+------+
1 row in set (0.00 sec)
```

> **说明：**
>
> 数值按照大小比较。
>
> 字符按照*ASC*II码对应的值进行比较，比较时按照字符对应的位置一个字符一个字符的比较。

其他几个运算符（<、<=、>=）在此就不介绍了，用法和上面类似，大家可以自己练习一下。

### 逻辑查询运算符

当我们需要使用多个条件进行查询的时候，需要使用逻辑查询运算符。

| 逻辑运算符 | 描述               |
| :--------- | :----------------- |
| AND        | 多个条件都成立     |
| OR         | 多个条件中满足一个 |

#### AND（并且）

```
select 列名 from 表名 where 条件1 and 条件2;
```

> 表示返回满足条件1和条件2的记录。

示例：

```
mysql> create table test3(a int not null,b varchar(10) not null);
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test3 (a,b) values (1,'a'),(2,'b'),(2,'c'),(3,'c');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from test3;
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | b |
| 2 | c |
| 3 | c |
+---+---+
4 rows in set (0.00 sec)

mysql> select * from test3 t where t.a=2 and t.b='c';
+---+---+
| a | b |
+---+---+
| 2 | c |
+---+---+
1 row in set (0.00 sec)
```

> 查询出了a=2 并且 b='c'的记录，返回了一条结果。

#### OR（或者）

```
select 列名 from 表名 where 条件1 or 条件2;
```

> 满足条件1或者满足条件2的记录都会被返回。

示例：

```
mysql> select * from test3;
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | b |
| 2 | c |
| 3 | c |
+---+---+
4 rows in set (0.00 sec)

mysql> select * from test3 t where t.a=1 or t.b='c';
+---+---+
| a | b |
+---+---+
| 1 | a |
| 2 | c |
| 3 | c |
+---+---+
3 rows in set (0.00 sec)
```

> 查询出了a=1或者b='c'的记录，返回了3条记录。

### like（模糊查询）

有个学生表，包含（学生id，年龄，姓名），当我们需要查询姓“张”的学生的时候，如何查询呢？

此时我们可以使用sql中的like关键字。语法：

```
select 列名 from 表名 where 列 like pattern;
```

> pattern中可以包含通配符，有以下通配符：
>
> %：表示匹配任意一个或多个字符
>
> _：表示匹配任意一个字符。

**学生表，查询名字姓“张”的学生，如下：**

```
mysql> create table stu (id int not null comment '编号',age smallint not null comment '年龄',name varchar(10) not null comment '姓名');
Query OK, 0 rows affected (0.01 sec)

mysql> insert into stu values (1,22,'张三'),(2,25,'李四'),(3,26,'张学友'),(4,32,'刘德华'),(5,55,'张学良');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from stu;
+----+-----+-----------+
| id | age | name      |
+----+-----+-----------+
|  1 |  22 | 张三      |
|  2 |  25 | 李四      |
|  3 |  26 | 张学友    |
|  4 |  32 | 刘德华    |
|  5 |  55 | 张学良    |
+----+-----+-----------+
5 rows in set (0.00 sec)

mysql> select * from stu a where a.name like '张%';
+----+-----+-----------+
| id | age | name      |
+----+-----+-----------+
|  1 |  22 | 张三      |
|  3 |  26 | 张学友    |
|  5 |  55 | 张学良    |
+----+-----+-----------+
3 rows in set (0.00 sec)
```

**查询名字中带有'学'的学生，'学'的位置不固定，可以这么查询，如下：**

```
mysql> select * from stu a where a.name like '%学%'; ;
+----+-----+-----------+
| id | age | name      |
+----+-----+-----------+
|  3 |  26 | 张学友    |
|  5 |  55 | 张学良    |
+----+-----+-----------+
2 rows in set (0.00 sec)
```

**查询姓'张'，名字2个字的学生：**

```
mysql> select * from stu a where a.name like '张_';
+----+-----+--------+
| id | age | name   |
+----+-----+--------+
|  1 |  22 | 张三   |
+----+-----+--------+
1 row in set (0.00 sec)
```

> 上面的*代表任意一个字符，如果要查询姓'张'的3个字的学生，条件变为了'张_*'，2个下划线符号。

### BETWEEN AND(区间查询)

操作符 BETWEEN … AND 会选取介于两个值之间的数据范围，这些值可以是数值、文本或者日期，属于一个闭区间查询。

```
selec 列名 from 表名 where 列名 between 值1 and 值2;
```

> 返回对应的列的值在[值1,值2]区间中的记录
>
> 使用between and可以提高语句的简洁度
>
> 两个临界值不要调换位置，只能是大于等于左边的值，并且小于等于右边的值。

**示例：**

查询年龄在[25,32]的，如下：

```
mysql> select * from stu;
+----+-----+-----------+
| id | age | name      |
+----+-----+-----------+
|  1 |  22 | 张三      |
|  2 |  25 | 李四      |
|  3 |  26 | 张学友    |
|  4 |  32 | 刘德华    |
|  5 |  55 | 张学良    |
+----+-----+-----------+
5 rows in set (0.00 sec)

mysql> select * from stu t where t.age between 25 and 32;
+----+-----+-----------+
| id | age | name      |
+----+-----+-----------+
|  2 |  25 | 李四      |
|  3 |  26 | 张学友    |
|  4 |  32 | 刘德华    |
+----+-----+-----------+
3 rows in set (0.00 sec)
```

下面两条sql效果一样

```
select * from stu t where t.age between 25 and 32;
select * from stu t where t.age >= 25 and t.age <= 32;
```

### IN查询

我们需要查询年龄为10岁、15岁、20岁、30岁的人，怎么查询呢？可以用or查询，如下：

```
mysql> create table test6(id int,age smallint);
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test6 values(1,14),(2,15),(3,18),(4,20),(5,28),(6,10),(7,10),(8,30);
Query OK, 8 rows affected (0.00 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> select * from test6;
+------+------+
| id   | age  |
+------+------+
|    1 |   14 |
|    2 |   15 |
|    3 |   18 |
|    4 |   20 |
|    5 |   28 |
|    6 |   10 |
|    7 |   10 |
|    8 |   30 |
+------+------+
8 rows in set (0.00 sec)

mysql> select * from test6 t where t.age=10 or t.age=15 or t.age=20 or t.age = 30;
+------+------+
| id   | age  |
+------+------+
|    2 |   15 |
|    4 |   20 |
|    6 |   10 |
|    7 |   10 |
|    8 |   30 |
+------+------+
5 rows in set (0.00 sec)
```

**用了这么多or，有没有更简单的写法？有，用IN查询**

IN 操作符允许我们在 WHERE 子句中规定多个值。

```
select 列名 from 表名 where 字段 in (值1,值2,值3,值4);
```

> in 后面括号中可以包含多个值，对应记录的字段满足in中任意一个都会被返回
>
> in列表的值类型必须一致或兼容
>
> in列表中不支持通配符。

上面的示例用IN实现如下：

```
mysql> select * from test6 t where t.age in (10,15,20,30);
+------+------+
| id   | age  |
+------+------+
|    2 |   15 |
|    4 |   20 |
|    6 |   10 |
|    7 |   10 |
|    8 |   30 |
+------+------+
5 rows in set (0.00 sec)
```

相对于or简洁了很多。

### NOT IN查询

not in和in刚好相反，in是列表中被匹配的都会被返回，NOT IN是和列表中都不匹配的会被返回。

```
select 列名 from 表名 where 字段 not in (值1,值2,值3,值4);
```

如查询年龄不在10、15、20、30之内的，如下：

```
mysql> select * from test6 t where t.age not in (10,15,20,30);
+------+------+
| id   | age  |
+------+------+
|    1 |   14 |
|    3 |   18 |
|    5 |   28 |
+------+------+
3 rows in set (0.00 sec)
```

### NULL存在的坑

我们先看一下效果，然后在解释，示例如下：

```
mysql> create table test5 (a int not null,b int,c varchar(10));
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test5 values (1,2,'a'),(3,null,'b'),(4,5,null);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from test5;
+---+------+------+
| a | b    | c    |
+---+------+------+
| 1 |    2 | a    |
| 3 | NULL | b    |
| 4 |    5 | NULL |
+---+------+------+
3 rows in set (0.00 sec)
```

上面我们创建了一个表test5，3个字段，a不能为空，b、c可以为空，插入了3条数据，睁大眼睛看效果了：

```
mysql> select * from test5 where b>0;
+---+------+------+
| a | b    | c    |
+---+------+------+
| 1 |    2 | a    |
| 4 |    5 | NULL |
+---+------+------+
2 rows in set (0.00 sec)

mysql> select * from test5 where b<=0;
Empty set (0.00 sec)

mysql> select * from test5 where b=NULL;
Empty set (0.00 sec)

mysql> select * from test5 t where t.b between 0 and 100;
+---+------+------+
| a | b    | c    |
+---+------+------+
| 1 |    2 | a    |
| 4 |    5 | NULL |
+---+------+------+
2 rows in set (0.00 sec)

mysql> select * from test5 where c like '%';
+---+------+------+
| a | b    | c    |
+---+------+------+
| 1 |    2 | a    |
| 3 | NULL | b    |
+---+------+------+
2 rows in set (0.00 sec)

mysql> select * from test5 where c in ('a','b',NULL);
+---+------+------+
| a | b    | c    |
+---+------+------+
| 1 |    2 | a    |
| 3 | NULL | b    |
+---+------+------+
2 rows in set (0.00 sec)

mysql> select * from test5 where c not in ('a','b',NULL);
Empty set (0.00 sec)
```

认真看一下上面的查询：

上面带有条件的查询，对字段b进行条件查询的，b的值为NULL的都没有出现。

对c字段进行like '%'查询、in、not查询，c中为NULL的记录始终没有查询出来。

between and查询，为空的记录也没有查询出来。

**结论：查询运算符、like、between and、in、not in对NULL值查询不起效。**

**那NULL如何查询呢？继续向下看**

### IS NULL/IS NOT NULL（NULL值专用查询）

上面介绍的各种运算符对NULL值均不起效，mysql为我们提供了查询空值的语法：IS NULL、IS NOT NULL。

#### IS NULL（返回值为空的记录）

```
select 列名 from 表名 where 列 is null;
```

> 查询指定的列的值为NULL的记录。

如：

```
mysql> create table test7 (a int,b varchar(10));
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test7 (a,b) values (1,'a'),(null,'b'),(3,null),(null,null),(4,'c');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from test7;
+------+------+
| a    | b    |
+------+------+
|    1 | a    |
| NULL | b    |
|    3 | NULL |
| NULL | NULL |
|    4 | c    |
+------+------+
5 rows in set (0.00 sec)

mysql> select * from test7 t where t.a is null;
+------+------+
| a    | b    |
+------+------+
| NULL | b    |
| NULL | NULL |
+------+------+
2 rows in set (0.00 sec)

mysql> select * from test7 t where t.a is null or t.b is null;
+------+------+
| a    | b    |
+------+------+
| NULL | b    |
|    3 | NULL |
| NULL | NULL |
+------+------+
3 rows in set (0.00 sec)
```

#### IS NULL（返回值不为空的记录）

```
select 列名 from 表名 where 列 is not null;
```

> 查询指定的列的值不为NULL的记录。

如：

```
mysql> select * from test7 t where t.a is not null;
+------+------+
| a    | b    |
+------+------+
|    1 | a    |
|    3 | NULL |
|    4 | c    |
+------+------+
3 rows in set (0.00 sec)

mysql> select * from test7 t where t.a is not null and t.b is not null;
+------+------+
| a    | b    |
+------+------+
|    1 | a    |
|    4 | c    |
+------+------+
2 rows in set (0.00 sec)
```

### <=>（安全等于）

<=>：既可以判断NULL值，又可以判断普通的数值，可读性较低，用得较少

**示例：**

```
mysql> create table test8 (a int,b varchar(10));
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test8 (a,b) values (1,'a'),(null,'b'),(3,null),(null,null),(4,'c');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from test8;
+------+------+
| a    | b    |
+------+------+
|    1 | a    |
| NULL | b    |
|    3 | NULL |
| NULL | NULL |
|    4 | c    |
+------+------+
5 rows in set (0.00 sec)

mysql> select * from test8 t where t.a<=>null;
+------+------+
| a    | b    |
+------+------+
| NULL | b    |
| NULL | NULL |
+------+------+
2 rows in set (0.00 sec)

mysql> select * from test8 t where t.a<=>1;
+------+------+
| a    | b    |
+------+------+
|    1 | a    |
+------+------+
1 row in set (0.00 sec)
```

可以看到<=>可以将NULL查询出来。

### 经典面试题

下面的2个sql查询结果一样么？

```
select * from students;
select * from students where name like '%';
```

结果分2种情况：

当name没有NULL值时，返回的结果一样。

当name有NULL值时，第2个sql查询不出name为NULL的记录。

### 总结

- **like中的%可以匹配一个到多个任意的字符，_可以匹配任意一个字符**
- **空值查询需要使用IS NULL或者IS NOT NULL，其他查询运算符对NULL值无效**
- **建议创建表的时候，尽量设置表的字段不能为空，给字段设置一个默认值**
- **<=>（安全等于）玩玩可以，建议少使用**

# 排序、分页

**代码中被[]包含的表示可选，|符号分开的表示可选其一。**

### 本章内容

1. 详解排序查询
2. 详解limit
3. limit存在的坑
4. 分页查询中的坑

### 排序查询（order by）

电商中：我们想查看今天所有成交的订单，按照交易额从高到低排序，此时我们可以使用数据库中的排序功能来完成。

**排序语法：**

```
select 字段名 from 表名 order by 字段1 [asc|desc],字段2 [asc|desc];
```

> 需要排序的字段跟在`order by`之后；
>
> asc|desc表示排序的规则，asc：升序，desc：降序，默认为asc；
>
> 支持多个字段进行排序，多字段排序之间用逗号隔开。

#### 单字段排序

```
mysql> create table test2(a int,b varchar(10));
Query OK, 0 rows affected (0.01 sec)

mysql> insert into test2 values (10,'jack'),(8,'tom'),(5,'ready'),(100,'javacode');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from test2;
+------+----------+
| a    | b        |
+------+----------+
|   10 | jack     |
|    8 | tom      |
|    5 | ready    |
|  100 | javacode |
+------+----------+
4 rows in set (0.00 sec)

mysql> select * from test2 order by a asc;
+------+----------+
| a    | b        |
+------+----------+
|    5 | ready    |
|    8 | tom      |
|   10 | jack     |
|  100 | javacode |
+------+----------+
4 rows in set (0.00 sec)

mysql> select * from test2 order by a desc;
+------+----------+
| a    | b        |
+------+----------+
|  100 | javacode |
|   10 | jack     |
|    8 | tom      |
|    5 | ready    |
+------+----------+
4 rows in set (0.00 sec)

mysql> select * from test2 order by a;
+------+----------+
| a    | b        |
+------+----------+
|    5 | ready    |
|    8 | tom      |
|   10 | jack     |
|  100 | javacode |
+------+----------+
4 rows in set (0.00 sec)
```

#### 多字段排序

比如学生表，先按学生年龄降序，年龄相同时，再按学号升序，如下：

```sql
mysql> create table stu(id int not null comment '学号' primary key,age tinyint not null comment '年龄',name varchar(16) comment '姓名');
Query OK, 0 rows affected (0.01 sec)

mysql> insert into stu (id,age,name) values (1001,18,'路人甲Java'),(1005,20,'刘德华'),(1003,18,'张学友'),(1004,20,'张国荣'),(1010,19,'梁朝伟');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> select * from stu;
+------+-----+---------------+
| id   | age | name          |
+------+-----+---------------+
| 1001 |  18 | 路人甲Java    |
| 1003 |  18 | 张学友        |
| 1004 |  20 | 张国荣        |
| 1005 |  20 | 刘德华        |
| 1010 |  19 | 梁朝伟        |
+------+-----+---------------+
5 rows in set (0.00 sec)

mysql> select * from stu order by age desc,id asc;
+------+-----+---------------+
| id   | age | name          |
+------+-----+---------------+
| 1004 |  20 | 张国荣        |
| 1005 |  20 | 刘德华        |
| 1010 |  19 | 梁朝伟        |
| 1001 |  18 | 路人甲Java    |
| 1003 |  18 | 张学友        |
+------+-----+---------------+
5 rows in set (0.00 sec)
```

#### 按别名排序

```sql
mysql> select * from stu;
+------+-----+---------------+
| id   | age | name          |
+------+-----+---------------+
| 1001 |  18 | 路人甲Java    |
| 1003 |  18 | 张学友        |
| 1004 |  20 | 张国荣        |
| 1005 |  20 | 刘德华        |
| 1010 |  19 | 梁朝伟        |
+------+-----+---------------+
5 rows in set (0.00 sec)

mysql> select age '年龄',id as '学号' from stu order by 年龄 asc,学号 desc;
+--------+--------+
| 年龄   | 学号   |
+--------+--------+
|     18 |   1003 |
|     18 |   1001 |
|     19 |   1010 |
|     20 |   1005 |
|     20 |   1004 |
+--------+--------+
```

#### 按函数排序

有学生表（id：编号，birth：出生日期，name：姓名），如下：

```sql
mysql> drop table if exists student;
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE student (
    ->   id int(11) NOT NULL COMMENT '学号',
    ->   birth date NOT NULL COMMENT '出生日期',
    ->   name varchar(16) DEFAULT NULL COMMENT '姓名',
    ->   PRIMARY KEY (id)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> insert into student (id,birth,name) values (1001,'1990-10-10','路人甲Java'),(1005,'1960-03-01','刘德华'),(1003,'1960-08-16','张学友'),(1004,'1968-07-01','张国荣'),(1010,'1962-05-16','梁朝伟');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> SELECT * FROM student;
+------+------------+---------------+
| id   | birth      | name          |
+------+------------+---------------+
| 1001 | 1990-10-10 | 路人甲Java    |
| 1003 | 1960-08-16 | 张学友        |
| 1004 | 1968-07-01 | 张国荣        |
| 1005 | 1960-03-01 | 刘德华        |
| 1010 | 1962-05-16 | 梁朝伟        |
+------+------------+---------------+
5 rows in set (0.00 sec)
```

需求：按照出生年份升序、编号升序，查询出编号、出生日期、出生年份、姓名，2种写法如下：

```sql
mysql> SELECT id 编号,birth 出生日期,year(birth) 出生年份,name 姓名 from student ORDER BY year(birth) asc,id asc;
+--------+--------------+--------------+---------------+
| 编号   | 出生日期     | 出生年份     | 姓名          |
+--------+--------------+--------------+---------------+
|   1003 | 1960-08-16   |         1960 | 张学友        |
|   1005 | 1960-03-01   |         1960 | 刘德华        |
|   1010 | 1962-05-16   |         1962 | 梁朝伟        |
|   1004 | 1968-07-01   |         1968 | 张国荣        |
|   1001 | 1990-10-10   |         1990 | 路人甲Java    |
+--------+--------------+--------------+---------------+
5 rows in set (0.00 sec)

mysql> SELECT id 编号,birth 出生日期,year(birth) 出生年份,name 姓名 from student ORDER BY 出生年份 asc,id asc;
+--------+--------------+--------------+---------------+
| 编号   | 出生日期     | 出生年份     | 姓名          |
+--------+--------------+--------------+---------------+
|   1003 | 1960-08-16   |         1960 | 张学友        |
|   1005 | 1960-03-01   |         1960 | 刘德华        |
|   1010 | 1962-05-16   |         1962 | 梁朝伟        |
|   1004 | 1968-07-01   |         1968 | 张国荣        |
|   1001 | 1990-10-10   |         1990 | 路人甲Java    |
+--------+--------------+--------------+---------------+
5 rows in set (0.00 sec)
```

> 说明：
>
> year函数：属于日期函数，可以获取对应日期中的年份。
>
> 上面使用了2种方式排序，第一种是在order by中使用了函数，第二种是使用了别名排序。

#### where之后进行排序

有订单数据如下：

```sql
mysql> drop table if exists t_order;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> create table t_order(
    ->   id int not null auto_increment comment '订单编号',
    ->   price decimal(10,2) not null default 0 comment '订单金额',
    ->   primary key(id)
    -> )comment '订单表';
Query OK, 0 rows affected (0.01 sec)

mysql> insert into t_order (price) values (88.95),(100.68),(500),(300),(20.88),(200.5);
Query OK, 6 rows affected (0.00 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> select * from t_order;
+----+--------+
| id | price  |
+----+--------+
|  1 |  88.95 |
|  2 | 100.68 |
|  3 | 500.00 |
|  4 | 300.00 |
|  5 |  20.88 |
|  6 | 200.50 |
+----+--------+
6 rows in set (0.00 sec)
```

需求：查询订单金额>=100的，按照订单金额降序排序，显示2列数据，列头：订单编号、订单金额，如下：

```sql
mysql> select a.id 订单编号,a.price 订单金额 from t_order a where a.price>=100 order by a.price desc;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            3 |       500.00 |
|            4 |       300.00 |
|            6 |       200.50 |
|            2 |       100.68 |
+--------------+--------------+
4 rows in set (0.00 sec)
```

### limit介绍

limit用来限制select查询返回的行数，常用于分页等操作。

**语法：**

```
select 列 from 表 limit [offset,] count;
```

> 说明：
>
> offset：表示偏移量，通俗点讲就是跳过多少行，offset可以省略，默认为0，表示跳过0行；范围：[0,+∞)。
>
> count：跳过offset行之后开始取数据，取count行记录；范围：[0,+∞)。
>
> limit中offset和count的值不能用表达式。

下面我们列一些常用的示例来加深理解。

#### 获取前n行记录

```
select 列 from 表 limit 0,n;
或者
select 列 from 表 limit n;
```

示例，获取订单的前2条记录，如下：

```sql
mysql> create table t_order(
    ->   id int not null auto_increment comment '订单编号',
    ->   price decimal(10,2) not null default 0 comment '订单金额',
    ->   primary key(id)
    -> )comment '订单表';
Query OK, 0 rows affected (0.01 sec)

mysql> insert into t_order (price) values (88.95),(100.68),(500),(300),(20.88),(200.5);
Query OK, 6 rows affected (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> select * from t_order;
+----+--------+
| id | price  |
+----+--------+
|  1 |  88.95 |
|  2 | 100.68 |
|  3 | 500.00 |
|  4 | 300.00 |
|  5 |  20.88 |
|  6 | 200.50 |
+----+--------+
6 rows in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a limit 2;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            1 |        88.95 |
|            2 |       100.68 |
+--------------+--------------+
2 rows in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a limit 0,2;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            1 |        88.95 |
|            2 |       100.68 |
+--------------+--------------+
2 rows in set (0.00 sec)
```

#### 获取最大的一条记录

我们需要获取订单金额最大的一条记录，可以这么做：先按照金额降序，然后取第一条记录，如下：

```sql
mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            3 |       500.00 |
|            4 |       300.00 |
|            6 |       200.50 |
|            2 |       100.68 |
|            1 |        88.95 |
|            5 |        20.88 |
+--------------+--------------+
6 rows in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc limit 1;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            3 |       500.00 |
+--------------+--------------+
1 row in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc limit 0,1;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            3 |       500.00 |
+--------------+--------------+
1 row in set (0.00 sec)
```

#### 获取排名第n到m的记录

我们需要先跳过n-1条记录，然后取m-n+1条记录，如下：

```
select 列 from 表 limit n-1,m-n+1;
```

如：我们想获取订单金额最高的3到5名的记录，我们需要跳过2条，然后获取3条记录，如下：

```sql
mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            3 |       500.00 |
|            4 |       300.00 |
|            6 |       200.50 |
|            2 |       100.68 |
|            1 |        88.95 |
|            5 |        20.88 |
+--------------+--------------+
6 rows in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc limit 2,3;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            6 |       200.50 |
|            2 |       100.68 |
|            1 |        88.95 |
+--------------+--------------+
3 rows in set (0.00 sec)
```

#### 分页查询

开发过程中，分页我们经常使用，分页一般有2个参数：

page：表示第几页，从1开始，范围[1,+∞)

pageSize：每页显示多少条记录，范围[1,+∞)

如：page = 2，pageSize = 10，表示获取第2页10条数据。

我们使用limit实现分页，语法如下：

```sql
select 列 from 表名 limit (page - 1) * pageSize,pageSize;
```

需求：我们按照订单金额降序，每页显示2条，依次获取所有订单数据、第1页、第2页、第3页数据，如下：

```sql
mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            3 |       500.00 |
|            4 |       300.00 |
|            6 |       200.50 |
|            2 |       100.68 |
|            1 |        88.95 |
|            5 |        20.88 |
+--------------+--------------+
6 rows in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc limit 0,2;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            3 |       500.00 |
|            4 |       300.00 |
+--------------+--------------+
2 rows in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc limit 2,2;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            6 |       200.50 |
|            2 |       100.68 |
+--------------+--------------+
2 rows in set (0.00 sec)

mysql> select a.id 订单编号,a.price 订单金额 from t_order a order by a.price desc limit 4,2;
+--------------+--------------+
| 订单编号     | 订单金额     |
+--------------+--------------+
|            1 |        88.95 |
|            5 |        20.88 |
+--------------+--------------+
2 rows in set (0.00 sec)
```

### 避免踩坑

#### limit中不能使用表达式

```sql
mysql> select * from t_order where limit 1,4+1;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'limit 1,4+1' at line 1
mysql> select * from t_order where limit 1+0;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'limit 1+0' at line 1
mysql>
```

**结论：limit后面只能够跟明确的数字。**

#### limit后面的2个数字不能为负数

```sql
mysql> select * from t_order where limit -1;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'limit -1' at line 1
mysql> select * from t_order where limit 0,-1;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'limit 0,-1' at line 1
mysql> select * from t_order where limit -1,-1;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'limit -1,-1' at line 1
```

#### 排序分页存在的坑

准备数据：

```sql
mysql> insert into test1 (b) values (1),(2),(3),(4),(2),(2),(2),(2);
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> select * from test1;
+---+---+
| a | b |
+---+---+
| 1 | 1 |
| 2 | 2 |
| 3 | 3 |
| 4 | 4 |
| 5 | 2 |
| 6 | 2 |
| 7 | 2 |
| 8 | 2 |
+---+---+
8 rows in set (0.00 sec)

mysql> select * from test1 order by b asc;
+---+---+
| a | b |
+---+---+
| 1 | 1 |
| 2 | 2 |
| 5 | 2 |
| 6 | 2 |
| 7 | 2 |
| 8 | 2 |
| 3 | 3 |
| 4 | 4 |
+---+---+
8 rows in set (0.00 sec)
```

下面我们按照b升序，每页2条数据，来获取数据。

下面的sql依次为第1页、第2页、第3页、第4页、第5页的数据，如下：

```sql
mysql> select * from test1 order by b asc limit 0,2;
+---+---+
| a | b |
+---+---+
| 1 | 1 |
| 2 | 2 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc limit 2,2;
+---+---+
| a | b |
+---+---+
| 8 | 2 |
| 6 | 2 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc limit 4,2;
+---+---+
| a | b |
+---+---+
| 6 | 2 |
| 7 | 2 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc limit 6,2;
+---+---+
| a | b |
+---+---+
| 3 | 3 |
| 4 | 4 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc limit 7,2;
+---+---+
| a | b |
+---+---+
| 4 | 4 |
+---+---+
1 row in set (0.00 sec)
```

**上面有2个问题：**

**问题1：看一下第2个sql和第3个sql，分别是第2页和第3页的数据，结果出现了相同的数据，是不是懵逼了。**

**问题2：整个表只有8条记录，怎么会出现第5页的数据呢，又懵逼了。**

我们来分析一下上面的原因：**主要是b字段存在相同的值，当排序过程中存在相同的值时，没有其他排序规则时，mysql懵逼了，不知道怎么排序了。**

就像我们上学站队一样，按照身高排序，那身高一样的时候如何排序呢？身高一样的就乱排了。

建议：排序中存在相同的值时，需要再指定一个排序规则，通过这种排序规则不存在二义性，比如上面可以再加上a降序，如下：

```
mysql> select * from test1 order by b asc,a desc;
+---+---+
| a | b |
+---+---+
| 1 | 1 |
| 8 | 2 |
| 7 | 2 |
| 6 | 2 |
| 5 | 2 |
| 2 | 2 |
| 3 | 3 |
| 4 | 4 |
+---+---+
8 rows in set (0.00 sec)

mysql> select * from test1 order by b asc,a desc limit 0,2;
+---+---+
| a | b |
+---+---+
| 1 | 1 |
| 8 | 2 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc,a desc limit 2,2;
+---+---+
| a | b |
+---+---+
| 7 | 2 |
| 6 | 2 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc,a desc limit 4,2;
+---+---+
| a | b |
+---+---+
| 5 | 2 |
| 2 | 2 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc,a desc limit 6,2;
+---+---+
| a | b |
+---+---+
| 3 | 3 |
| 4 | 4 |
+---+---+
2 rows in set (0.00 sec)

mysql> select * from test1 order by b asc,a desc limit 8,2;
Empty set (0.00 sec)
```

看上面的结果，分页数据都正常了，第5页也没有数据了。

### 总结

- order by … [asc|desc]用于对查询结果排序，asc：升序，desc：降序，asc|desc可以省略，默认为asc
- limit用来限制查询结果返回的行数，有2个参数（offset，count），offset：表示跳过多少行，count：表示跳过offset行之后取count行
- limit中offset可以省略，默认值为0
- limit中offset 和 count都必须大于等于0
- limit中offset和count的值不能用表达式
- 分页排序时，排序不要有二义性，二义性情况下可能会导致分页结果乱序，可以在后面追加一个主键排序

# 分组查询

### 本篇内容

1. 分组查询语法
2. 聚合函数
3. 单字段分组
4. 多字段分组
5. 分组前筛选数据
6. 分组后筛选数据
7. where和having的区别
8. 分组后排序
9. where & group by & having & order by & limit 一起协作
10. mysql分组中的坑
11. in多列查询的使用

### 分组查询

**语法：**

```
SELECT column, group_function,... FROM table
[WHERE condition]
GROUP BY group_by_expression
[HAVING group_condition];
```

> 说明：
>
> group_function：聚合函数。
>
> group_by_expression：分组表达式，多个之间用逗号隔开。
>
> group_condition：分组之后对数据进行过滤。
>
> 分组中，select后面只能有两种类型的列：
>
> 1. 出现在group by后的列
> 2. 或者使用聚合函数的列

### 聚合函数

| 函数名称 | 作用                             |
| :------- | :------------------------------- |
| max      | 查询指定列的最大值               |
| min      | 查询指定列的最小值               |
| count    | 统计查询结果的行数               |
| sum      | 求和，返回指定列的总和           |
| avg      | 求平均值，返回指定列数据的平均值 |

分组时，可以使用使用上面的聚合函数。

### 准备数据

```
drop table if exists t_order;

-- 创建订单表
create table t_order(
  id int not null AUTO_INCREMENT COMMENT '订单id',
  user_id bigint not null comment '下单人id',
  user_name varchar(16) not null default '' comment '用户名',
  price decimal(10,2) not null default 0 comment '订单金额',
  the_year SMALLINT not null comment '订单创建年份',
  PRIMARY KEY (id)
) comment '订单表';

-- 插入数据
insert into t_order(user_id,user_name,price,the_year) values
  (1001,'路人甲Java',11.11,'2017'),
  (1001,'路人甲Java',22.22,'2018'),
  (1001,'路人甲Java',88.88,'2018'),
  (1002,'刘德华',33.33,'2018'),
  (1002,'刘德华',12.22,'2018'),
  (1002,'刘德华',16.66,'2018'),
  (1002,'刘德华',44.44,'2019'),
  (1003,'张学友',55.55,'2018'),
  (1003,'张学友',66.66,'2019');
mysql> select * from t_order;
+----+---------+---------------+-------+----------+
| id | user_id | user_name     | price | the_year |
+----+---------+---------------+-------+----------+
|  1 |    1001 | 路人甲Java    | 11.11 |     2017 |
|  2 |    1001 | 路人甲Java    | 22.22 |     2018 |
|  3 |    1001 | 路人甲Java    | 88.88 |     2018 |
|  4 |    1002 | 刘德华        | 33.33 |     2018 |
|  5 |    1002 | 刘德华        | 12.22 |     2018 |
|  6 |    1002 | 刘德华        | 16.66 |     2018 |
|  7 |    1002 | 刘德华        | 44.44 |     2019 |
|  8 |    1003 | 张学友        | 55.55 |     2018 |
|  9 |    1003 | 张学友        | 66.66 |     2019 |
+----+---------+---------------+-------+----------+
9 rows in set (0.00 sec)
```

### 单字段分组

**需求：**查询每个用户下单数量，输出：用户id、下单数量，如下：

```
mysql> SELECT 
            user_id 用户id, COUNT(id) 下单数量
        FROM
            t_order
        GROUP BY user_id;
+----------+--------------+
| 用户id   | 下单数量     |
+----------+--------------+
|     1001 |            3 |
|     1002 |            4 |
|     1003 |            2 |
+----------+--------------+
3 rows in set (0.00 sec)
```

### 多字段分组

**需求：**查询每个用户每年下单数量，输出字段：用户id、年份、下单数量，如下：

```
mysql> SELECT 
            user_id 用户id, the_year 年份, COUNT(id) 下单数量
        FROM
            t_order
        GROUP BY user_id , the_year;
+----------+--------+--------------+
| 用户id   | 年份   | 下单数量     |
+----------+--------+--------------+
|     1001 |   2017 |            1 |
|     1001 |   2018 |            2 |
|     1002 |   2018 |            3 |
|     1002 |   2019 |            1 |
|     1003 |   2018 |            1 |
|     1003 |   2019 |            1 |
+----------+--------+--------------+
6 rows in set (0.00 sec)
```

### 分组前筛选数据

> 分组前对数据进行筛选，使用where关键字

**需求：**需要查询2018年每个用户下单数量，输出：用户id、下单数量，如下：

```
mysql> SELECT 
            user_id 用户id, COUNT(id) 下单数量
        FROM
            t_order t
        WHERE
            t.the_year = 2018
        GROUP BY user_id;
+----------+--------------+
| 用户id   | 下单数量     |
+----------+--------------+
|     1001 |            2 |
|     1002 |            3 |
|     1003 |            1 |
+----------+--------------+
3 rows in set (0.00 sec)
```

### 分组后筛选数据

> 分组后对数据筛选，使用having关键字

**需求：**查询2018年订单数量大于1的用户，输出：用户id，下单数量，如下：

**方式1：**

```
mysql> SELECT
          user_id 用户id, COUNT(id) 下单数量
        FROM
          t_order t
        WHERE
          t.the_year = 2018
        GROUP BY user_id
        HAVING count(id)>=2;
+----------+--------------+
| 用户id   | 下单数量     |
+----------+--------------+
|     1001 |            2 |
|     1002 |            3 |
+----------+--------------+
2 rows in set (0.00 sec)
```

**方式2：**

```
mysql> SELECT
          user_id 用户id, count(id) 下单数量
        FROM
          t_order t
        WHERE
          t.the_year = 2018
        GROUP BY user_id
        HAVING 下单数量>=2;
+----------+--------------+
| 用户id   | 下单数量     |
+----------+--------------+
|     1001 |            2 |
|     1002 |            3 |
+----------+--------------+
2 rows in set (0.00 sec)
```

### where和having的区别

where是在分组（聚合）前对记录进行筛选，而having是在分组结束后的结果里筛选，最后返回整个sql的查询结果。

可以把having理解为两级查询，即含having的查询操作先获得不含having子句时的sql查询结果表，然后在这个结果表上使用having条件筛选出符合的记录，最后返回这些记录，因此，having后是可以跟聚合函数的，并且这个聚集函数不必与select后面的聚集函数相同。

### 分组后排序

**需求**：获取每个用户最大金额，然后按照最大金额倒序，输出：用户id，最大金额，如下：

```
mysql> SELECT
          user_id 用户id, max(price) 最大金额
        FROM
          t_order t
        GROUP BY user_id
        ORDER BY 最大金额 desc;
+----------+--------------+
| 用户id   | 最大金额     |
+----------+--------------+
|     1001 |        88.88 |
|     1003 |        66.66 |
|     1002 |        44.44 |
+----------+--------------+
3 rows in set (0.00 sec)
```

### where & group by & having & order by & limit 一起协作

where、group by、having、order by、limit这些关键字一起使用时，先后顺序有明确的限制，语法如下：

```
select 列 from 
表名
where [查询条件]
group by [分组表达式]
having [分组过滤条件]
order by [排序条件]
limit [offset,] count;
```

> **注意：**
>
> **写法上面必须按照上面的顺序来写。**

**示例：**

**需求：**查询出2018年，下单数量大于等于2的，按照下单数量降序排序，最后只输出第1条记录，显示：用户id，下单数量，如下：

```
mysql> SELECT
          user_id 用户id, COUNT(id) 下单数量
        FROM
          t_order t
        WHERE
          t.the_year = 2018
        GROUP BY user_id
        HAVING count(id)>=2
        ORDER BY 下单数量 DESC
        LIMIT 1;
+----------+--------------+
| 用户id   | 下单数量     |
+----------+--------------+
|     1002 |            3 |
+----------+--------------+
1 row in set (0.00 sec)
```

### mysql分组中的坑

本文开头有介绍，分组中select后面的列只能有2种：

1. 出现在group by后面的列
2. 使用聚合函数的列

oracle、sqlserver、db2中也是按照这种规范来的。

文中使用的是5.7版本，默认是按照这种规范来的。

mysql早期的一些版本，没有上面这些要求，select后面可以跟任何合法的列。

#### 示例

**需求：获取每个用户下单的最大金额及下单的年份，输出：用户id，最大金额，年份，写法如下：**

```
mysql> select
          user_id 用户id, max(price) 最大金额, the_year 年份
        FROM t_order t
        GROUP BY t.user_id;
ERROR 1055 (42000): Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'javacode2018.t.the_year' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
```

上面的sql报错了，原因因为`the_year`不符合上面说的2条规则（select后面的列必须出现在group by中或者使用聚合函数），而`sql_mode`限制了这种规则，我们看一下`sql_mode`的配置：

```
mysql> select @@sql_mode;
+-------------------------------------------------------------------------------------------------------------------------------------------+
| @@sql_mode                                                                                                                                |
+-------------------------------------------------------------------------------------------------------------------------------------------+
| ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |
+-------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```

sql_mode中包含了`ONLY_FULL_GROUP_BY`，这个表示select后面的列必须符合上面的说的2点规范。

可以将`ONLY_FULL_GROUP_BY`去掉，select后面就可以加任意列了，我们来看一下效果。

修改mysql中的`my.ini`文件：

```
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
```

重启mysql，再次运行，效果如下：

```
mysql> select
          user_id 用户id, max(price) 最大金额, the_year 年份
        FROM t_order t
        GROUP BY t.user_id;
+----------+--------------+--------+
| 用户id   | 最大金额     | 年份   |
+----------+--------------+--------+
|     1001 |        88.88 |   2017 |
|     1002 |        44.44 |   2018 |
|     1003 |        66.66 |   2018 |
+----------+--------------+--------+
3 rows in set (0.03 sec)
```

看一下上面的数据，第一条`88.88`的年份是`2017`年，我们再来看一下原始数据：

```sql
mysql> select * from t_order;
+----+---------+---------------+-------+----------+
| id | user_id | user_name     | price | the_year |
+----+---------+---------------+-------+----------+
|  1 |    1001 | 路人甲Java    | 11.11 |     2017 |
|  2 |    1001 | 路人甲Java    | 22.22 |     2018 |
|  3 |    1001 | 路人甲Java    | 88.88 |     2018 |
|  4 |    1002 | 刘德华        | 33.33 |     2018 |
|  5 |    1002 | 刘德华        | 12.22 |     2018 |
|  6 |    1002 | 刘德华        | 16.66 |     2018 |
|  7 |    1002 | 刘德华        | 44.44 |     2019 |
|  8 |    1003 | 张学友        | 55.55 |     2018 |
|  9 |    1003 | 张学友        | 66.66 |     2019 |
+----+---------+---------------+-------+----------+
9 rows in set (0.00 sec)
```

对比一下，user_id=1001、price=88.88是第3条数据，即the_year是2018年，但是上面的分组结果是2017年，结果和我们预期的不一致，此时mysql对这种未按照规范来的列，乱序了，mysql取的是第一条。

**正确的写法，提供两种，如下：**

```sql
mysql> SELECT
          user_id 用户id,
          price 最大金额,
          the_year 年份
        FROM
          t_order t1
        WHERE
          (t1.user_id , t1.price)
          IN
          (SELECT
             t.user_id, MAX(t.price)
           FROM
             t_order t
           GROUP BY t.user_id);
+----------+--------------+--------+
| 用户id   | 最大金额     | 年份   |
+----------+--------------+--------+
|     1001 |        88.88 |   2018 |
|     1002 |        44.44 |   2019 |
|     1003 |        66.66 |   2019 |
+----------+--------------+--------+
3 rows in set (0.00 sec)

mysql> SELECT
          user_id 用户id,
          price 最大金额,
          the_year 年份
        FROM
          t_order t1,(SELECT
                        t.user_id uid, MAX(t.price) pc
                      FROM
                        t_order t
                      GROUP BY t.user_id) t2
        WHERE
          t1.user_id = t2.uid
        AND  t1.price = t2.pc;
+----------+--------------+--------+
| 用户id   | 最大金额     | 年份   |
+----------+--------------+--------+
|     1001 |        88.88 |   2018 |
|     1002 |        44.44 |   2019 |
|     1003 |        66.66 |   2019 |
+----------+--------------+--------+
3 rows in set (0.00 sec)
```

上面第1种写法，比较少见，`in`中使用了多字段查询。

**建议：在写分组查询的时候，最好按照标准的规范来写，select后面出现的列必须在group by中或者必须使用聚合函数。**

### 总结

1. 在写分组查询的时候，最好按照标准的规范来写，**select后面出现的列必须在group by中或者必须使用聚合函数**。
2. select语法顺序：select、from、where、group by、having、order by、limit，顺序不能搞错了，否则报错。
3. **in多列查询的使用，下去可以试试**