---
typora-copy-images-to: upload

---

## java基础

### 1. 什么是面向对象？

面相对象:将问题中的各个事务抽象为一个个对象，即对象反映了现实中的事物，为了解决问题，对象应具备一系列的属性和行为，对象之间的关系反映现实事物之间的关系，然后让每个对象去执行自己的方法，问题得到解决。创建对象不是为了完成某个步骤，而是在这个问题中具备哪些能力。具体到微观还是面向过程

### 2. 面向对象的三大特征

封装：将类的某些信息隐藏在类内部，不允许外部程序直接访问，而是通过该类的实例来对隐藏信息的操作和访问。

继承：继承是类与类的一种关系，是一种“is a”的关系。如“狗”继承“动物”，这里动物类是狗类的父类或者基类，狗类是动物类的子类或者派生类。java中的继承是<font color='red'>单继承</font>，即<font color='red'>一个类只有一个父类</font>。

多态就是对象的多种形态。多个同一类型不同对象进行相同的操作，产生不同的结果。<font color='red'>继承是多态的基础</font>。

### 3. jdk，jre，jvm的区别

JDK：java development kit （java开发工具）

JRE：java runtime environment （java运行时环境）

JRE顾名思义是java运行时环境，包含了java虚拟机，java基础类库。是使用java语言编写的程序运行所需要的软件环境，是提供给想运行java程序的用户使用的。

JDK顾名思义是java开发工具包，是程序员使用java语言编写java程序所需的开发工具包，是提供给程序员使用的。JDK包含了JRE，同时还包含了编译java源码的编译器javac，还包含了很多java程序调试和分析的工具：jconsole，jvisualvm等工具软件，还包含了java程序编写所需的文档和demo例子程序。

**如果你需要运行java程序，只需安装JRE就可以了。如果你需要编写java程序，需要安装JDK。**

`JVM`(`JAVA`虚拟机)是运行`Java`字节码的虚拟机，在现实世界中，`JVM`是一种规范，它提供可以执行`Java`字节码的运行时环境

### 4. java关键字有哪些

48个关键字：abstract、assert、boolean、break、byte、case、catch、char、class、continue、default、do、double、else、enum、extends、final、finally、float、for、if、implements、import、int、interface、instanceof、long、native、new、package、private、protected、public、return、short、static、strictfp、super、switch、synchronized、this、throw、throws、transient、try、void、volatile、while。
2个保留字（现在没用以后可能用到作为关键字）：goto、const。
3个特殊直接量：true、false、null。

### 5. 如何编译和运行java程序

javac .java文件生成 .class 文件；java .class文件运行 

### 6. 构造器与方法的区别

| 主题                                       | 构造器                                                       | 方法                                   |
| ------------------------------------------ | ------------------------------------------------------------ | -------------------------------------- |
| 功能                                       | 建立一个类的实例                                             | java功能语句                           |
| 修饰                                       | 不能用`bstract`, `final`, `native`, `static`, or `synchronized` | 能                                     |
| 返回类型                                   | 没有返回值，没有void                   |有返回值，或者void|
| 命名                                       | 和类名相同；通常为名词，大写开头                             | 通常代表一个动词的意思，小写开头       |
| this                                       | 指向同一个类中另外一个构造器，在第一行                       | 指向当前类的一个实例，不能用于静态方法 |
| super                                      | 调用父类的构造器，在第一行                                   | 调用父类中一个重载的方法               |
| 继承                                       | 构造器不能被继承                                             | 方法可以被继承（final方法不行）        |
| 编译器自动加入一个缺省的构造器             | 自动加入（如果没有）                                         | 不支持                                 |
| 编译器自动加入一个缺省的调用到超类的构造器 | 自动加入（如果没有）                                         | 不支持                                 |

### 7. Java 标识符命名规则是怎样的?

(1).标识符一般有字母、数字、下划线_、美元符$、人民币符号￥组成。

(2).注意数字不能放开头

(3).不能把java关键字(例如public int)作为标识符

(4).不能把java保留字(goto,const)作为标识符

(5).标识符没有长度限制，并且支持中文，但是不建议使用中文作为标识符

(6).标识符对大小写敏感。(OK、Ok、oK、ok所代表的意义不同)

(7).对于类名、接口名，所有单词首字母大写其他字母小写。(如StudentManager)

(8).对于方法名、变量名，第一个单词首字母小写，其他单词首字母大写，其他字母小写(如strName)

(9).对于包名所有字母都小写(如package animal;)

(10).对于不可变的变量(常量)所有字母都大写，不同单词之间用下划线分隔(如INT_MAX)

### 8. Java 类命名规范是怎样的?

对于类名、接口名，所有单词首字母大写其他字母小写

### 9. Java 方法命名规范是怎样的?

第一个单词首字母小写，其他单词首字母大写，其他字母小写(如strName)

### 10. Java 变量命名规范是怎样的?

第一个单词首字母小写，其他单词首字母大写，其他字母小写(如strName)

### 11. Java 常量命名规范是怎样的?

所有字母都大写，不同单词之间用下划线分隔(如INT_MAX)

### 12. Java 常量和变量的区别?

用final修饰(也称最终变量)；常量在声明时必须赋初值，赋值后不能再修改值；常量名通常用全大写字母表示

声明一个变量时，编译程序会在内存里开辟一块足以容纳此变量的内存空间给它。不管变量的值如何改变，都永远使用相同的内存空间。

### 13. Java怎么定义一个常量?

使用`final `修饰

### 14. Java 常量有几种类型?

1. 按照数据类型进行分类

    - 基本数据类型(简单数据类型)
        - 整数类型  byte、short、int、long    234
        - 小数类型  float、double    12.5 
        - 字符类型  char        'A' 
        - 布尔类型  boolean   true  false

    - 引用数据类型(复杂数据类型)
      - 空常量   null   ---> 代表不指向任何的地址 
      - 数组
      - 类（例如：字符串常量String  "字符串内容"）
      - 接口
      - 枚举
      - 注解

2. 可以从表现形式上进行分类
   - 字面值常量: 看到这个常量之后,就知道其值为多少。例如： 123  12.5
   - 符号常量: 是用符号进行表示, 看到常量之后,能够知道其表示什么意思,但是不能知道其值为多少 。例如：PI 、 E

### 15. Java 有哪几种基本数据类型?

在栈中可以直接分配内存的数据是基本数据类型。

| 类型    | 占用存储空间 | 表数范围               | 默认值          |
| ------- | ------------ | ---------------------- | --------------- |
| byte    | 1字节        | -128 ~ 127             | 0               |
| short   | 2字节        | -2^15 ~ 2^15 -1        | 0               |
| int     | 4字节        | -2^31 ~ 2^31 -1        | 0               |
| long    | 8字节        | -2^63 ~ 2^63 -1        | 0，或者0L或者0l |
| float   | 4字节        | -3.403E38 ~ 3.403E38   | 0.0F或0.0f      |
| double  | 8字节        | -1.798E308 ~ 1.798E308 | 0.0D或0.0d      |
| char    | 2字节        | 0~2^16 -1              | '\u0000'        |
| boolean | 1字节        | true/false             | false           |

### 16. ==和equals 比较有什么区别?

==

- 如果比较的对象是基本数据类型，则比较的是数值是否一致; 

- 如果比较的是引用数据类型，则比较的是对象的地址是否一致。 

equals()

-  equals（）默认用来比较对象的地址是否一致，不能用于比较基本数据类型，如果对象和自身进行比较，则equals（）方法与 ==的作用是一样的。

  ```java
  pubLic booLean equaLs(0bject obj)
  	return (this == obj);
  ```

   那为什么常用 equals（）来比较 String 字符串的内容相等是为什么呢? 那是因为对于 String、Date、Integer 等类型<font color='red'>重写</font>了equals 方法，<font color='red'>使其比较的是存储对象的内容是否相等</font>，而不是堆内存地址。 

### 17. public，private，protected，默认的区别?

private修饰词，表示成员是私有的，只有自身可以访问；   

protected，表示受保护权限，体现在继承，即子类可以访问父类受保护成员，同时相同包内的其他类也可以访问protected成员。   

无修饰词（默认），表示包访问权限（friendly， java语言中是没有friendly这个修饰符的，这样称呼应该是来源于c++ ），同一个包内可以访问，访问权限是包级访问权限

public修饰词，表示成员是公开的，所有其他类都可以访问；

|           | 类内部 | 本包 | 子包 | 外部包 |
| --------- | ------ | ---- | ---- | ------ |
| public    | √      | √    | √    | √      |
| protected | √      | √    | √    | ×      |
| default   | √      | √    | ×    | ×      |
| private   | √      | ×    | ×    | ×      |

### 18. this和 super 有什么区别?

this：指对当前对象的引用

super：指对当前对象父类的引用

this可以调用本类和父类的成员变量和方法（因为继承）。super只能调用父类的成员变量和方法

注意：this和super调用构造方法必须放在方法体的第一行

### 19. s1=s1+1和s1+=1的区别?

`short s1=1;s1+=1;`有错吗?
`short s1=1;s1=s1+1;`有错吗?

如果s1原先的数据类型小于int类型，如：short s1 = 10，则s1 = s1 + 1 会发生编译异常。因为在java里面，没小数点的数据类型默认是 int,有小数点的默认是 double。此时需要显示强制类型转换

而 s1 += 1 则不会有任何问题，因为 s1 += 1 有隐式强制类型转换，会自动提升为计算结果的数据类型。

拓展：`short s1 = 1,s2 = 2;short s3 = s1 + s2;   `同样会报错，short+short默认类型为int ，此处需要强转

`short s3 = (short)(s1 + s2)`

### 20.float n=1.8 有错吗?

![image-20210831235914982](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210831235914982.png)

Java中小数默认为double，可以通过强制类型转换赋值给单精度浮点数（float），但是窄化会造成精度丢失。建议写成 `float a = 1.8f`

### 21.0.1+0.2==0.3正确么?为什么?

https://blog.csdn.net/qq_33327680/article/details/94462435

```java
System.out.println(0.1+0.2);

/**输出
0.30000000000000004
*/
```

计算机是以二进制存储数值的，浮点数也不例外。Java 采用的是IEEE754标准实现浮点数的表达和运算。

比如，0.1 的二进制表示为 0.0 0011 0011 0011… （0011 无限循环)，再转换为十进制就是 0.1000000000000000055511151231257827021181583404541015625。

22.i++和++i的区别?

https://blog.csdn.net/wenchangwenliu/article/details/104564555/

```java
    public static void main(String[] args) {

        int i = 1;
        i = i++; //i = 1
        int j = i++;//j = 1,i = 2
        int k = i + ++i * i++; // 2 + 3 * 3++ , k = 11 , i= 4
        System.out.println("i = " + i);//4
        System.out.println("j = " + j);//1
        System.out.println("k = " + k);//11
  }
/**字节码
 0 iconst_1
 1 istore_1
 2 iload_1
 3 iinc 1 by 1
 6 istore_1
 7 iload_1
 8 iinc 1 by 1
11 istore_2
12 iload_1
13 iinc 1 by 1
16 iload_1
17 iload_1
18 iinc 1 by 1
21 imul
22 iadd
23 istore_3
*/
```

### 23.while和 do while 有啥区别?

do while至少执行一次。while则不一定

### 24.如何跳出 Java 中的循环?

break、continue、return、抛异常

### 25.如何跳出Java中的多层嵌套循环?

break+标签、return、抛异常

### 26.&和&&的区别?

Java 中 && 和 & 都是表示与的逻辑运算符，都表示逻辑运输符 and，当两边的表达式都为 true 的时候，整个运算结果才为 true，否则为 false。 

&&：有短路功能，当第一个表达式的值为 false 的时候，则不再计算第二个表达式；

&：不管第一个表达式结果是否为 true，第二个都会执行。除此之外，& 还可以用作位运算符：当 & 两边的表达式不是 Boolean 类型的时候，& 表示按位操作。

### 27.数组有没有length方法? String呢?

数组没有length()这个方法，但有length的属性。String有length()这个方法。

### 28.怎么理解值传递和引用传递?

值传递（pass by value）是指在调用函数时将实际参数复制一份传递到函数形式参数中，这样在函数中如果对参数进行修改，将不会影响到实际参数。

引用传递（pass by reference）是指在调用函数时将实际参数的地址直接传递到函数形式参数中，那么在函数中对参数所进行的修改，将影响到实际参数。

> java中只有值传递
>
> 参考：https://blog.csdn.net/bjweimengshu/article/details/79799485

### 29.Java 到底是值传递还是引用传递?

java中只有值传递。

### 30.Java 中的注释有哪些写法?

单行注释：//

多行注释：/* */

文档注释：/** */

### 31.static 关键字有什么用?

static关键字可以用来修饰代码块表示静态代码块，修饰成员变量表示全局静态成员变量，修饰方法表示静态方法

> 参考：https://blog.csdn.net/nobody_1/article/details/92388329

### 32.static 变量和普通变量的区别?

- 所属不同
  - 静态变量属于类变量，
  - 成员变量属于对象变量

- 内存变量不同
  - 静态变量存储在方法区的静态区
  - 成员变量存储在内存的堆区
- 内存出现的时间不同
  - 静态是随着类的加载而加载，随着类的消失而消失
  - 成员变量随着对象的加载而加载，随着对象的消失而消失
- 调用不同
  - 静态通过类名调用。也可以通过对象调用，但是不建议
  - 成员变量通过对象调用

### 33.static 可以修饰局部变量么?

不可以。

### 34.final 关键字有哪些用法?

1. 用来修饰数据，包括成员变量和局部变量，该变量只能被赋值一次且它的值无法被改变。对于成员变量来讲，我们必须在声明时，实例代码块或者构造方法中对它赋值；
2. 用来修饰方法参数，表示在变量的生存期中它的值不能被改变；
3. 修饰方法，表示该方法无法被重写；
4. 修饰类，表示该类无法被继承。

### 35.final、finally、finalize有什么区别?

final：修饰变量，方法，方法参数和类。

finally：finally只能用在try/catch中，finally语句最终总是被执行。

finalize() 方法允许在子类中被重写，用于在对象被回收时进行资源释放。通常在这个方法中进行一些<font color='red'>资源释放和清理的工作</font>，比如关闭文件、套接字和数据库连接等。 使用finalize会导致严重的内存消耗和性能损失。JVM不确保finalize一定会被执行，而且执行finalize的时间也不确定。



> 参考：https://www.cnblogs.com/smart-hwt/p/8257330.html

https://blog.csdn.net/aitangyong/article/details/39450341

### 36.Java 支持多继承吗?

不支持

### 37.Java类可以实现多个接口吗?

可以

### 38.重载和重写有什么区别?

方法的返回值只是作为方法运行后的一个状态，它是保持方法的调用者和被调用者进行通信的一个纽带，但并不能作为某个方法的‘标识’。

> https://blog.csdn.net/qunqunstyle99/article/details/81007712?utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-1.control&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7Edefault-1.control

### 39.构造器可以被重写和重载吗?

可以被重载，但是不可以重写。构造器是类本身所持有的，而不是从父类继承的

重载与重写是 `Java 多态性`的不同表现。
　重写是父类与子类之间多态性的表现，在运行时起作用（动态多态性，譬如实现动态绑定）
　而重载是一个类中多态性的表现，在编译时起作用（静态多态性，譬如实现静态绑定）。

### 40.main方法可以被重写和重载吗?

可以重载。但JVM将始终调用原始的main方法

不可以重写。静态方法在Java中不能被覆盖

### 41.私有方法能被重载或者重写吗?

可以重载

不能重写，private方法默认是final类型的，不能被子类继承。

### 42.静态方法能被重载或者重写吗?

可以重载

不能重写。静态方法是类在加载时就被加载到内存中的方法，在整个运行过程中保持不变，因而不能重写。

如果子类中定义的静态方法（类方法）与父类中静态方法（类方法）具有相同的返回值类型、方法名、方法参数的类型和个数完全相同，则称子类中的该方法“隐藏”了父类中的该方法。

### 43.静态方法可以被继承吗?

可以被继承，但是不能被重写，如果父子类静态方法名相同，则会隐藏derive类方法（调用base类的方法）

静态方法是编译时绑定的，方法重写是运行时绑定的。

### 44.Java 异常有哪些分类?

- 错误(Error)
- 异常(Exception)
  - 运行时异常（RuntimeException）
  - 非运行时异常（也称为检查性异常 ）

### 45.Error和 Exception有什么区别?

Exception是可以抛出的基本类型，在Java类库、方法以及运行时故障中都可能抛出Exception型异常。Exception表示可以恢复的异常，是编译器可以捕捉到的；Exception又分为检查异常和运行时异常。

Error表示编译时和系统错误，表示系统在运行期间出现了严重的错误，属于不可恢复的错误，由于这属于JVM层次的严重错误，因此这种错误会导致程序终止执行。OOM，ClassFormatError

### 46.Java 中常见的异常有哪些?

java.lang.nullpointerexception、 java.lang.classnotfoundexception、java.lang.arithmeticexception。。。

### 47.Java 中常见的运行时异常有哪些?

- java.lang.NullPointerException 空指针异常；出现原因：调用了未经初始化的对象或者是不存在的对象。
- java.lang.ClassNotFoundException 指定的类找不到；出现原因：类的名称和路径加载错误；通常都是程序试图通过字符串来加载某个类时可能引发异常。
- java.lang.NumberFormatException 字符串转换为数字异常；出现原因：字符型数据中包含非数字型字符。
- java.lang.IndexOutOfBoundsException 数组角标越界异常，常见于操作数组对象时发生。
- java.lang.IllegalArgumentException 方法传递参数错误。
- java.lang.ClassCastException 数据类型转换异常。
- java.lang.NoClassDefFoundException 未找到类定义错误。
- SQLException SQL 异常，常见于操作数据库时的 SQL 语句错误。
- java.lang.InstantiationException 实例化异常。
- java.lang.NoSuchMethodException 方法不存在异常

### 48.运行时异常与受检查异常有什么区别?

异常表示程序运行过程中可能出现的非正常状态，运行时异常表示虚拟机的通常操作中可能遇到的异常，是一种常见运行错误，只要程序设计得没有问题通常就不会发生。

受检异常跟程序运行的上下文环境有关，即使程序设计无误，仍然可能因使用的问题而引发。Java编译器要求方法必须声明抛出可能发生的受检异常，但是并不要求必须声明抛出未被捕获的运行时异常。

### 49.什么时候会发生空指针异常?

- 调用 null 对象的实例方法
- 访问或修改 null 对象的字段。
- 如果一个数组为null，试图用属性length获得其长度时。
- 如果一个数组为null，试图访问或修改其中某个元素时。
- 在需要抛出一个异常对象，而该对象为 null 时。

### 50.你知道有哪些避免空指针的方法?

- 字符串比较，常量放前面。如：`"".equals(string)`

- 初始化时给定默认值。如：`Object obj = new Object();`

- 断言

  断言是用来检查程序的安全性的，在使用之前就进行检查条件，如果不符合条件就报异常，符合就继续。Java中自带的断言关键字为：`assert`，如：

  ```java
  assert name == null : "名称不能为空";
  ```

  不过默认是不启动断言检查的，需要带上JVM参数：-anableassertions 才能生效。不过不建议使用，建议使用 Spring 中的，更强大，更方便好用。

  Spring中的用法：

  ```java
  Assert.notNull(name, "名称不能为空");
  ```

- Optional     参考：https://mp.weixin.qq.com/s/uXw4eTZqLfj871FlciPh6Q

### 51.throw和 throws的区别?

throw

- 表示方法内抛出某种异常对象(只能是一个)。用于程序员自行产生并抛出异常
- 位于方法体内部，可以作为单独语句使用
- 如果异常对象是非 RuntimeException则需要在方法申明时加上该异常的抛出，即需要加上throws语句或者在方法体内try catch处理该异常，否则编译报错
- 执行到 throw语句则后面的语句块不再执行

throws:

- 方法的定义上使用throws表示这个方法可能抛出某些异常(可以有多个)
- 用于声明在该方法内抛出了异常
- 必须跟在方法参数列表的后面，不能单独使用
- 需要由方法的调用者进行异常处理

### 52.try-catch-finally中哪个部分可以省略?

catch和finally可以省略其中的一个，但不能同时省略

如果 catch 中 return 了，finally 还会执行吗？
会。

（1）finally的作用就是，无论出现什么状况，finally里的代码一定会被执行。

（2）如果在catch中return了，也会在return之前，先执行finally代码块。

（3）而且如果finally代码块中含有return语句，会覆盖其他地方的return。

（4）对于基本数据类型的数据，在finally块中改变return的值对返回值没有影响，而对引用数据类型的数据会有影响。

什么情形下，finally代码块不会执行？

- 没有进入try代码块；
- System.exit()强制退出程序；

- finally所在的守护线程被终止

### 53.Java可以一次catch多个异常吗?

jdk6及其之前都只能一次catch一个异常

```js
try {
} catch (ExceptionType name) {
} catch (ExceptionType name) {
}
```

jdk7及其之后可以一次catch多个异常

```js
catch (IOException|SQLException ex) {
    logger.log(ex);
    throw ex;
}
```

### 54.int和 Integer有什么区别?

int：

- int是基本数据类型。
- 默认值为0。
- 在内存中是存储在栈中，好处就是速度快（不涉及到对象的构造和回收）；
- 对于int（基本类型）变量，==操作符比较的是两个变量的值是否相等；

Integer：

- Integer是int对应的包装类，有方法和属性，利用这些方法和属性来处理数据。
- 默认值为null

- Integer的引用（值的地址）存储在栈中，而实际的Integer对象（值）是存在堆中，Integer封装类的目的主要是更好的处理数据之间的转换。
- 对于Integer（引用类型）变量，==操作符比较的是两个引用是否指向同一个对象。

JDK5.0开始可以支持自动装箱（int→Integer）拆箱（Integer→int）。

### 55.什么是包装类型?有什么用?

Java设计中一个核心的原则，即万物皆对象，也就是说一切要求用对象的形式描述，但是基本数据类型不是对象。那么该如何解决此问题呢？可以把基本数据类型包装成一个对象，以面向对象的思想去使用这些类型。

作用：

- 采用基本数据类型包装的形式描述，让功能变得更加健壮，例如： Integer默认不是int的 0 而是 null ，那么比起基本数据类型，包装类对象它就多了一个状态。
- 还有一个比较直观的，就是包装类给我们提供了很多方法可以使用，例如：数据可以转二进制，查看最大值最小值等等。
- 除了上面还有一个要点： 集合中不能存放基本数据类型，只能存放对象，所以当使用集合时，我们的就需要使用到包装类对象。

### 56.什么是自动装厢、拆厢?

装箱就是自动将基本数据类型转换为包装器类型；拆箱就是自动将包装器类型转换为基本数据类型。

自动装箱：调用valueOf（）方法将原始类型值转换成对象

自动拆箱：调用intValue()方法，其他的（xxxValue())这类的方法将对象转换成原始类型值。

### 57.你怎么理解Java中的强制类型转换?

强行将一个数据类型转换成另外一个数据类型。如：

```
int i = 1;
long j = (long)i;
```

### 58.你怎么理解Java中的自动类型转换?

数字表示范围小的数据类型可以自动转换成范围大的数据类型。

会有溢出问题；

### 59.你怎么理解Java中的类型提升?

在存在多个数据类型的表达式中，数据类型会自动向表示范围较大的值的数据类型提升

```java
long i = 1;
int j = 0;
long k = i + j;
```

其中，i会自动提升为long类型。

### 60.怎么理解Java中的多态机制?

多态：同一事物的多种状态，也可理解为同一个行为具有多个不同表现形式或形态的能力。

**实现多态的三个条件**

- 继承的存在。继承是多态的基础，没有继承就没有多态
- 子类重写父类的方法，JVM 会调用子类重写后的方法
- 父类引用变量指向子类对象

**向上转型：将一个父类的引用指向一个子类对象，自动进行类型转换。**

- 通过父类引用变量调用的方法是子类覆盖或继承父类的方法，而不是父类的方法。
- 通过父类引用变量无法调用子类特有的方法。

**向下转型：将一个指向父类对象的引用赋给一个子类的引用，必须进行强制类型转换。**

- 向下转型必须转换为父类引用指向的真实子类类型，不是任意的强制转换，否则会出现 ClassCastException
- 向下转型时可以结合使用 `instance of` 运算符进行判断

**多种体现方式**

- 普通子类重写父类方法
- 接口
- 抽象类和抽象方法

**好处：**

- 消除类型之间的耦合关系
- 可替换性(substitutability)
- 可扩充性(extensibility)
- 接口性(interface-ability)
- 灵活性(flexibility)
- 简化性(simplicity)

### 61.Java 如何获取用户的输入?

使用java.util.Scanner类获取用户输入

`Scanner::next()`：获取一个字符

`Scanner::nextLine()`：获取一行

### 62.switch是否能用在 long上?

不能

### 63.switch是否能用在 String上?

可以

### 64.switch case支持哪几种数据类型?

- 早期 JDK，switch(expr)，expr 可以是 byte、short、char、int
- JDK 1.5 开始，引入了枚举(enum)，expr 也可以是枚举
- JDK 1.7 开始，expr 还可以是字符串(String)
- 长整型(long)是不可以的

### 65.String属于基础的数据类型吗?

String 不是基本的数据类型，是 final 修饰的 Java 类，是引用类型。

### 66.String类的常用方法都有那些?

1、求字符串长度

- **public int length()**//返回该字符串的长度

```java
String str = new String("asdfzxc");
int strlength = str.length();//strlength = 7
```

2、求字符串某一位置字符

- **public char charAt(int index)**//返回字符串中指定位置的字符；注意字符串中第一个字符索引是0，最后一个是length()-1。

```java
String str = new String("asdfzxc");
char ch = str.charAt(4);//ch = z
```

3、提取子串

用String类的substring方法可以提取字符串中的子串，该方法有两种常用参数:

- **public String substring(int beginIndex)**//该方法从beginIndex位置起，从当前字符串中取出剩余的字符作为一个新的字符串返回。
- **public String substring(int beginIndex, int endIndex)**//该方法从beginIndex位置起，从当前字符串中取出到endIndex-1位置的字符作为一个新的字符串返回。

```java
String str1 = new String("asdfzxc");
String str2 = str1.substring(2);//str2 = "dfzxc"
String str3 = str1.substring(2,5);//str3 = "dfz"
```

4、字符串比较

- **public int compareTo(String anotherString)**//该方法是对字符串内容按字典顺序进行大小比较，通过返回的整数值指明当前字符串与参数字符串的大小关系。若当前对象比参数大则返回正整数，反之返回负整数，相等返回0。
- **public int compareToIgnore(String anotherString)**//与compareTo方法相似，但忽略大小写。
- **public boolean equals(Object anotherObject)**//比较当前字符串和参数字符串，在两个字符串相等的时候返回true，否则返回false。
- **public boolean equalsIgnoreCase(String anotherString)**//与equals方法相似，但忽略大小写。

```java
1 String str1 = new String("abc");
2 String str2 = new String("ABC");
3 int a = str1.compareTo(str2);//a>0
4 int b = str1.compareToIgnoreCase(str2);//b=0
5 boolean c = str1.equals(str2);//c=false
6 boolean d = str1.equalsIgnoreCase(str2);//d=true
```

5、字符串连接

- **public String concat(String str)**//将参数中的字符串str连接到当前字符串的后面，效果等价于"+"。

```java
String str = "aa".concat("bb").concat("cc");
相当于String str = "aa"+"bb"+"cc";
```

6、字符串中单个字符查找

- **public int indexOf(int ch/String str)**//用于查找当前字符串中字符或子串，返回字符或子串在当前字符串中从左边起首次出现的位置，若没有出现则返回-1。
- **public int indexOf(int ch/String str, int fromIndex)**//改方法与第一种类似，区别在于该方法从fromIndex位置向后查找。
- **public int lastIndexOf(int ch/String str)**//该方法与第一种类似，区别在于该方法从字符串的末尾位置向前查找。
- **public int lastIndexOf(int ch/String str, int fromIndex)**//该方法与第二种方法类似，区别于该方法从fromIndex位置向前查找。

```java
String str = "I am a good student";
int a = str.indexOf('a');//a = 2
int b = str.indexOf("good");//b = 7
int c = str.indexOf("w",2);//c = -1
int d = str.lastIndexOf("a");//d = 5
int e = str.lastIndexOf("a",3);//e = 2
```

7、字符串中字符的大小写转换

- **public String toLowerCase()**//返回将当前字符串中所有字符转换成小写后的新串
- **public String toUpperCase()**//返回将当前字符串中所有字符转换成大写后的新串

```java
1 String str = new String("asDF");
String str1 = str.toLowerCase();//str1 = "asdf"
String str2 = str.toUpperCase();//str2 = "ASDF"
```

8、字符串中字符的替换

- **public String replace(char oldChar, char newChar)**//用字符newChar替换当前字符串中所有的oldChar字符，并返回一个新的字符串。
- **public String replaceFirst(String regex, String replacement)**//该方法用字符replacement的内容替换当前字符串中遇到的第一个和字符串regex相匹配的子串，应将新的字符串返回。
- **public String replaceAll(String regex, String replacement)**//该方法用字符replacement的内容替换当前字符串中遇到的所有和字符串regex相匹配的子串，应将新的字符串返回。

```java
1 String str = "asdzxcasd";
2 String str1 = str.replace('a','g');//str1 = "gsdzxcgsd"
3 String str2 = str.replace("asd","fgh");//str2 = "fghzxcfgh"
4 String str3 = str.replaceFirst("asd","fgh");//str3 = "fghzxcasd"
5 String str4 = str.replaceAll("asd","fgh");//str4 = "fghzxcfgh"
```

9、其他方法

- **String trim()**//截去字符串两端的空格，但对于中间的空格不处理。

```java
String str = " a sd ";
String str1 = str.trim();
int a = str.length();//a = 6
int b = str1.length();//b = 4
```

- **boolean startsWith(String prefix)**或**boolean endWith(String suffix)**//用来比较当前字符串的起始字符或子字符串prefix和终止字符或子字符串suffix是否和当前字符串相同，重载方法中同时还可以指定比较的开始位置offset。

```java
String str = "asdfgh";
boolean a = str.startsWith("as");//a = true
boolean b = str.endWith("gh");//b = true
```

- **regionMatches(boolean b, int firstStart, String other, int otherStart, int length)**//从当前字符串的firstStart位置开始比较，取长度为length的一个子字符串，other字符串从otherStart位置开始，指定另外一个长度为length的字符串，两字符串比较，当b为true时字符串不区分大小写。
- **contains(String** **str)**//判断参数s是否被包含在字符串中，并返回一个布尔类型的值。

```java
String str = "student";
str.contains("stu");//true
str.contains("ok");//false
```

- **String[] split(String str)**//将str作为分隔符进行字符串分解，分解后的字字符串在字符串数组中返回。

```java
String str = "asd!qwe|zxc#";
String[] str1 = str.split("!|#");//str1[0] = "asd";str1[1] = "qwe";str1[2] = "zxc";
```

**五、字符串与基本类型的转换**

1、字符串转换为基本类型

java.lang包中有Byte、Short、Integer、Float、Double类的调用方法：

- **public static byte parseByte(String s)**
- **public static short parseShort(String s)**
- **public static short parseInt(String s)**
- **public static long parseLong(String s)**
- **public static float parseFloat(String s)**
- **public static double parseDouble(String s)**

```java
int n = Integer.parseInt("12");
float f = Float.parseFloat("12.34");
double d = Double.parseDouble("1.124");
```

2、基本类型转换为字符串类型

String类中提供了String valueOf()放法，用作基本类型转换为字符串类型。

- **static String valueOf(char data[])**
- **static String valueOf(char data[], int offset, int count)**
- **static String valueOf(boolean b)**
- **static String valueOf(char c)**
- **static String valueOf(int i)**
- **static String valueOf(long l)**
- **static String valueOf(float f)**
- **static String valueOf(double d)**

```java
String s1 = String.valueOf(12);
String s1 = String.valueOf(12.34);
```

3、进制转换

使用Long类中的方法得到整数之间的各种进制转换的方法：

- **Long.toBinaryString(long l)**
- **Long.toOctalString(long l)**
- **Long.toHexString(long l)**
- **Long.toString(long l, int p)**//p作为任意进制

> https://www.cnblogs.com/ABook/p/5527341.html

### 67.String的底层实现是怎样的?

内部使用 char 数组存储数据，该数组被声明为 final，这意味着 value 数组初始化之后就不能再引用其它数组。并且 String 内部没有改变 value 数组的方法，因此可以保证 String 不可变。

```java
public final class String
    implements java.io.Serializable, Comparable<String>, CharSequence {
    /** The value is used for character storage. */
    private final char value[];
    /** Cache the hash code for the string */
    private int hash; // Default to 0
}
```

### 68.String是可变的吗?为什么?

不可变。

### 69.String类可以被继承吗?

不行。String被声明为final

### 70.String 真的是不可变的吗?

不一定。可以通过反射消除String对象的不可变性，因为final只在编译期有效。一般来说，违反语法结构的都可以使用反射解决

```java
    public static void main(String[] args) throws Exception{
        String str = "hello" ;    //实例化一个String类对象
        String s = str ;    //用于后面的比较测试
        //打印字符串和hashCode编码
        System.out.println(str + "::" + str.hashCode());//hello::99162322
        Class<?> cls = String.class;
        Field value = cls.getDeclaredField("value");
        value.setAccessible(true);
        char[] arr = (char[]) value.get(str);    //反射取得str对象的字符数组
        arr[0] = 's' ;   //修改字符数组的内容
        System.out.println(str + "::" + str.hashCode());//sello::99162322
        System.out.println(s == str); //true,比较两次是否相同
    }
```

### 71.String 字符串如何进行反转?

- StringBuffer或者StringBuilder的reverse方法

- 遍历，insert(0,string.charAt(i))，O(n)空间复杂度

- 首尾指针，交换字符。O(1)空间复杂度

- 递归

- ```javascript
      /**
       * 递归
       * @param str
       * @return
       */
      public static String reverseStringByRecursion(String str) {
          if (str == null || str.length() <= 1) {
              return str;
          }
          return reverseStringByRecursion(str.substring(1)) + str.charAt(0);
      }
  ```

### 72.String 字符串如何实现编码转换?

```java
/** 
  * 字符串编码转换的实现方法 
  * @param str  待转换编码的字符串 
  * @param newCharset 目标编码 
  * @return 
  * @throws UnsupportedEncodingException 
  */  
 public String changeCharset(String str, String newCharset)  
   throws UnsupportedEncodingException {  
  if (str != null) {  
   //用默认字符编码解码字符串。  
   byte[] bs = str.getBytes();  
   //用新的字符编码生成字符串  
   return new String(bs, newCharset);  
  }  
  return null;  
 }  
 /** 
  * 字符串编码转换的实现方法 
  * @param str  待转换编码的字符串 
  * @param oldCharset 原编码 
  * @param newCharset 目标编码 
  * @return 
  * @throws UnsupportedEncodingException 
  */  
 public String changeCharset(String str, String oldCharset, String newCharset)  
   throws UnsupportedEncodingException {  
  if (str != null) {  
   //用旧的字符编码解码字符串。解码可能会出现异常。  
   byte[] bs = str.getBytes(oldCharset);  
   //用新的字符编码生成字符串  
   return new String(bs, newCharset);  
  }  
  return null;  
 }
```

### 73.String有没有长度限制?是多少?

**编译期**

根据构造器`public String(char value[], int offset, int count)`,count是int类型,所以,char value[]最多可以为Interger.MAX_VALUE,即214748367

但是通过测试可得,当超过65534个字符就会编译报错

```java
public static void main(String[] args) {

          String s = "a...a";// 共65534个a
          System.out.println(s.length());
          String s1 = "a...a";// 共65535个a
          System.out.println(s1.length());

}
```

![image-20210914101433019](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210914101433019.png)
这是由于常量池限制。根据《Java虚拟机规范》中第4.4章节常量池的定义，CONSTANT_String_info 用于表示 java.lang.String 类型的常量对象，格式如下：

```java
CONSTANT_String_info {
    u1 tag;
    u2 string_index;
}
```

其中，string_index 项的值必须是对常量池的有效索引， 常量池在该索引处的项必须是CONSTANT_Utf8_info 结构，表示一组 Unicode 码点序列，这组 Unicode 码点序列最终会被初始化为一个 String 对象。

CONSTANT_Utf8_info结构用于表示字符串常量的值：

```java
CONSTANT_Utf8_info {
    u1 tag;
    u2 length;
    u1 bytes[length];
}
```

其中，length则指明了 bytes[]数组的长度，其类型为u2，u2表示两个字节的无符号数，那么1个字节有8位，2个字节就有16位。因此理论上允许的的最大长度是2^16=65536。而 java class 文件是使用一种变体UTF-8格式来存放字符的，null 值使用两位来表示，因此只剩下 65536－ 2 ＝ 65534个字节。

>The length of field and method names, field and method descriptors, and other constant string values is limited to 65535 characters by the 16-bit unsigned length item of the CONSTANTUtf8info structure (§4.4.7).
>Note that the limit is on the number of bytes in the encoding and not on the number of encoded characters. UTF-8 encodes some characters using two or three bytes.
>Thus, strings incorporating multibyte characters are further constrained.

也就是说，在Java中，所有需要保存在常量池中的数据，长度最大不能超过65535。

**运行期**

上面提到的这种String长度的限制是编译期的限制，也就是使用String s= "";这种字面值方式定义的时候才会有的限制。

那么。String在运行期有没有限制呢，答案是有的，就是我们前文提到的那个Integer.MAX_VALUE ，这个值约等于4G，在运行期，如果String的长度超过这个范围，就可能会抛出异常。(在jdk 1.9之前）

int 是一个 32 位变量类型，取正数部分来算的话，他们最长可以有

```
2^31-1 =2147483647 个 16-bit Unicodecharacter
2147483647 * 16 = 34359738352 位
34359738352 / 8 = 4294967294 (Byte)
4294967294 / 1024 = 4194303.998046875 (KB)
4194303.998046875 / 1024 = 4095.9999980926513671875 (MB)
4095.9999980926513671875 / 1024 = 3.99999999813735485076904296875 (GB)
```

### 74.String与byte[]之间如何转换?

- 用String.getBytes()方法将字符串转换为byte数组，通过String构造函数将byte数组转换成String

- 通过Base64 将String转换成byte[]或者byte[]转换成String Base64 是一种将二进制数据编码的方式，正如UTF-8和UTF-16是将文本数据编码的方式一样，所以如果你需要将二进制数据编码为文本数据，那么Base64可以实现这样的需求。从Java 8 开始可以使用Base64这个类

  ```java
  import java.util.Base64;
  public class StringByteArrayExamples 
  {
      public static void main(String[] args) 
      {
          //Original byte[]
          byte[] bytes = "hello world".getBytes();
           
          //Base64 Encoded
          String encoded = Base64.getEncoder().encodeToString(bytes);
           
          //Base64 Decoded
          byte[] decoded = Base64.getDecoder().decode(encoded);
           
          //Verify original content
          System.out.println( new String(decoded) );
      }
  }
  ```

### 75.String.trim（）方法有什么用?

去除首尾两端多余的空格。中间空格并不会被去除

### 76.字符串分割有哪些方式?

1. StringTokenizer类。用法参考：https://www.runoob.com/w3cnote/java-stringtokenizer-intro.html
2. String::split(String)
3. String::subString(int,int)

### 77.字符串拼接+和 concat 的区别?

1. +可以是字符串或者数字及其他基本类型数据，而concat只能接收字符串。
2. +左右可以为null，concat为null会报空指针异常。
3. 如果拼接空字符串，concat会稍快，在速度上两者可以忽略不计，如果拼接更多字符串建议用StringBuilder。
4. 从字节码来看+号编译后就是使用了StringBuiler来拼接，所以一个+的语句就会创建一个StringBuilder，多条+语句就会创建多个，所以为什么建议用StringBuilder的原因。

### 78.StringBuffer和 StringBuilder 的区别?

**相同点：**

- 都可以储存和操作字符串
- 都使用 final 修饰，不能被继承
- 提供的 API 相似

**区别：**

- String 是只读字符串，String 对象内容是不能被改变的
- StringBuffer 和 StringBuilder 的字符串对象可以对字符串内容进行修改，在修改后的内存地址不会发生改变
- StringBuilder 线程不安全；StringBuffer 线程安全

方法体内没有对字符串的并发操作，且存在大量字符串拼接操作，建议使用 StringBuilder，效率较高。

### 79.StringBuilder，StringBuffer默认容量大小?

实例化时，初始化大小容量为16

```java
    /**
     * Constructs a string builder with no characters in it and an
     * initial capacity of 16 characters.
     */
    public StringBuilder() {
        super(16);
    }
```

扩容：如果append的字符串长度超过16，则容量为34 （34=16 * 2 + 2）

要是append的字符串长度超过16，并且大于34，则直接为字符串需要的长度。

```java
    private int newCapacity(int minCapacity) {
        // overflow-conscious code
        int newCapacity = (value.length << 1) + 2;
        if (newCapacity - minCapacity < 0) {
            newCapacity = minCapacity;
        }
        return (newCapacity <= 0 || MAX_ARRAY_SIZE - newCapacity < 0)
            ? hugeCapacity(minCapacity)
            : newCapacity;
    }
```

### 80.Java中的main方法有什么用?

在Java中，main()方法是Java应用程序的入口方法，也就是说，程序在运行的时候，第一个执行的方法就是main()方法，这个方法和其他的方法有很大的不同，比如方法的名字必须是main，方法必须是public static void 类型的，方法必须接收一个字符串数组的参数等等。

### 81.main 方法能同步吗?

main方法可以在Java中同步，synchronized修饰符允许用于main方法的声明中，这样就可以在Java中同步main方法了

### 82.main 方法能不能改为非静态?

不能，main()方法必须声明为静态的，这样JVM才可以调用main()方法而无需实例化它的类。

如果从main()方法去掉“static”这个声明，虽然编译依然可以成功，但在运行时会导致程序失败。

### 83.main 方法为什么是静态的?

main方法一定是静态的，如果main方法是非静态的，那么在调用main方法是JVM就得实例化它的类。在实例化时，还得调用类的构造函数。如果这个类的构造函数有参数，那么届时就会出现歧义。

### 84.怎么向 main 方法传递参数?

通过String数组。可以在控制台输入

```
java xxx.class 1 2 3
```

### 85.不用 main 方法如何运行一个类?

不行，没有main方法我们不能运行Java类。

在Java 7之前，你可以通过使用静态初始化运行Java类。但是，从Java 7开始就行不通了。

可以使用静态代码块来实现一个可以执行但并没有main方法的Java应用程序。如下面的代码是所示：

```java
class MainMethodNot {
    static {
        System.out.println("This java program have run without the run method");
        System.exit(0);
    }
}
```

上面的代码可以运行是因为static代码块会在java类被加载的时候被执行，而且是在main方法被调用之前。在运行时，JVM会在执行静态代码块以后搜索main方法，如果不能找到main方法，就会抛出一个异常，为了避免这个异常，可以使用System.exit(0)来结束应用程序。

### 86.Java 所有类的祖先类是哪个?

Object类

### 87.Object 类有哪些常用的方法?

- public final native Class<?> getClass(); 获取类结构信息
- public native int hashCode() 获取哈希码
- public boolean equals(Object) 默认比较对象的地址值是否相等，子类可以重写比较规则
- protected native Object clone() throws CloneNotSupportedException 用于对象克隆
- public String toString() 把对象转变成字符串
- public final native void notify() 多线程中唤醒功能
- public final native void notifyAll() 多线程中唤醒所有等待线程的功能
- public final void wait() throws InterruptedException 让持有对象锁的线程进入等待
- public final native void wait(long timeout) throws InterruptedException 让持有对象锁的线程进入等待，设置超时毫秒数时间
- public final void wait(long timeout, int nanos) throws InterruptedException 让持有对象锁的线程进入等待，设置超时纳秒数时间
- protected void finalize() throws Throwable 垃圾回收前执行的方法

### 88.普通类和抽象类有什么区别?

- 抽象类不能被实例化
- 抽象类可以有抽象方法，抽象方法只需声明，无需实现
- 含有抽象方法的类必须申明为抽象类
- 抽象类的子类必须实现抽象类中所有抽象方法，或者这个子类也是抽象类
- 抽象方法不能被声明为静态
- 抽象方法不能用 private 修饰
- 抽象方法不能用 final 修饰

89.静态内部类和普通内部类有什么区别?
90.静态方法可以直接调用非静态方法吗?
91.静态变量和实例变量有什么区别?
92.内部类可以访问其外部类的成员吗?

### 93.接口和抽象类有什么区别?

- 抽象类可以有构造方法；接口中不能有构造方法。
- 抽象类中可以有普通成员变量；接口中没有普通成员变量。
- 抽象类中可以包含非抽象普通方法；JDK1.8 以前接口中的所有方法默认都是抽象的，JDK1.8 开始方法可以有 default 实现和 static 方法。
- 抽象类中的抽象方法的访问权限可以是 public、protected 和 default；接口中的抽象方法只能是 public 类型的，并且默认即为 public abstract 类型。
- 抽象类中可以包含静态方法；JDK1.8 前接口中不能包含静态方法，JDK1.8 及以后可以包含已实现的静态方法。

```java
public interface TestInterfaceStaticMethod {
    static String getA() {
        return "a";
    }
}
```

- 抽象类和接口中都可以包含静态成员变量，抽象类中的静态成员变量可以是任意访问权限；接口中变量默认且只能是 public static final 类型。
- 一个类可以实现多个接口，用逗号隔开，但只能继承一个抽象类。
- 接口不可以实现接口，但可以继承接口，并且可以继承多个接口，用逗号隔开。

### 94.接口是否可以继承接口?

可以。接口继承是为了在不修改接口的情况下，扩展接口的功能

### 95.接口里面可以写方法实现吗?

jdk8之前不可以，所有方法必须是抽象的。

但是从jdk8开始可以有默认方法和静态方法。默认方法用 default 修饰，只能用在接口中。

接口默认方法可以被继承并重写，如果继承的多个接口都存在相同的默认方法，那就存在冲突问题。

### 96.接口默认方法和静态方法是什么?

默认方法用 default 修饰，只能用在接口中，静态方法用 static 修饰。

### 97.接口为什么新增了默认方法和静态方法?

在 Java 8 之前，比如要在一个接口中添加一个抽象方法，那所有的接口实现类都要去实现这个方法，不然就会编译错误，而某些实现类根本就不需要实现这个方法也被迫要写一个空实现，改动会非常大。所以，接口默认方法就是为了解决这个问题，只要在一个接口添加了一个默认方法，所有的实现类就自动继承，不需要改动任何实现类，也不会影响业务。

接口静态方法和默认方法类似，只是接口静态方法不可以被接口实现类重写。接口静态方法只可以直接通过静态方法所在的 接口名.静态方法名 来调用。

### 98.接口默认方法有哪些注意的问题?

如果先在一个接口中将一个方法定义为默认方法，然后又在超类或者另一个接口中定义了同样的方法，那么同时实现这两个接口的类或者既继承了超类又实现了接口的类就会发生冲突。Java提供相应的规则：

- **超类优先。**如果超类提供一个具体方法，同名而且有相同参数类型的默认方法会被忽略。
- **接口冲突。**如果一个超接口提供了一个默认方法，另一个接口提供了一个同名而且参数类型相同的方法，就必须解决冲突。

### 99.抽象类必须要有抽象方法吗?

不一定。可以只有普通方法或者静态方法。

### 100.抽象类能使用 final 修饰吗?

不能，抽象类是被用于继承的，final修饰代表不可修改、不可继承的。

### 101.抽象类是否可以继承具体类?

可以。抽象类也属于类，直接或间接继承于Object类

### 102.抽象类是否可以实现接口?

可以。抽象类可以实现自己所需要的接口方法，而无需实现所有接口方法

### 103.如何判断一个对象是某类、接口的实例?

instanceof关键字。

isAssignableFrom()方法与instanceof关键字的区别：

isAssignableFrom()方法是从<font color='red'>类</font>继承或实现的角度去判断，instanceof关键字是从<font color='red'>实例</font>（对象）继承或实现的角度去判断。

isAssignableFrom()方法是判断是否是某个类的父类，instanceof关键字是判断是否某个类的子类。

使用方法：

```
父类.class.isAssignableFrom(子类.class)

子类实例 instanceof 子类/父类类型
```

### 104.如何判断两个类或者接口之间的派生关系?

使用isAssignableFrom()方法

### 105.Java 怎么生成随机数?

得到0到100的随机数

1. Math::random()方法，生成[0, 1.0)的double类型数据

   ```java
   int number =(int) Math.random() * 100;
   ```

2. new Random()

   ```java
   double number = new Random().nextDouble() * 100;
   ```

3. 通过System.currentTimeMillis() 获取一个当前时间毫秒数的long随机数

   ```
   long l = System.currentTimeMillis();
   int random = (int)l%100;
   ```

### 106.什么是 hash冲突?

对应不同的关键字可能获得相同的hash地址，即 key1≠key2，但是f(key1)=f(key2)。这种现象就是冲突，而且这种冲突只能尽可能的减少，不能完全避免。

- 开放定址法（再散列法）：线性探测、二次探测、伪随机探测

- 再哈希法
- 链地址法
- 公共溢出区法：为所有冲突的关键字记录建立一个公共的溢出区来存放。

### 107.equals 和 hashCode 的区别和联系?

关于 hashCode() 和 equals() 是方法是有一些 常规协定：

1、两个对象用 equals() 比较返回true，那么两个对象的hashCode()方法必须返回相同的结果。

2、两个对象用 equals() 比较返回false，不要求hashCode()方法也一定返回不同的值，但是最好返回不同值，以提高哈希表性能。

3、重写 equals() 方法，必须重写 hashCode() 方法，以保证 equals() 方法相等时两个对象 hashcode() 返回相同的值。

> https://www.cnblogs.com/justdojava/p/11271438.html

### 108.两个对象 equals相等，hashCode 呢?

一定相等

### 109.两个对象 hashCode相等，equals 呢?

不一定相等

### 110.为什么重写equals 就要重写 hashCode?

保证两个对象 hashcode() 相同。

### 111.Math.round（1.5） 等于多少?

Math的round方法是四舍五入。

2

### 112.Math.round（-1.5）等于多少?

-1

### 113.动态代理都用到了哪些技术?

反射、泛型

### 114.Java 反射机制有什么用?

反射机制指的是程序在运行时能够获取自身的信息。

Java 反射，就是在运行状态中

- 获取任意类的名称、package 信息、所有属性、方法、注解、类型、类加载器、modifiers（public、static）、父类、现实接口等
- 获取任意对象的属性，并且能改变对象的属性
- 调用任意对象的方法
- 判断任意一个对象所属的类
- 实例化任意一个类的对象

Java 的动态就体现在反射。通过反射我们可以实现动态装配，降低代码的耦合度；动态代理等。反射的过度使用会严重消耗系统资源。

JDK 中 java.lang.Class 类，就是为了实现反射提供的核心类之一。

一个 jvm 中一种 Class 只会被加载一次。

### 115.Java 反射机制的优缺点?

优点：

- 能够运行时动态获取类的实例，大大提高系统的灵活性和扩展性。
- 与 Java 动态编译相结合，可以实现无比强大的功能。
- 对于 Java 这种先编译再运行的语言，能够让我们很方便的创建灵活的代码，这些代码可以在运行时装配，无需在组件之间进行源代码的链接，更加容易实现面向对象。

缺点：

- 反射会消耗一定的系统资源，因此，如果不需要动态地创建一个对象，那么就不需要用反射；
- 反射调用方法时可以忽略权限检查，获取这个类的私有方法和属性，因此可能会破坏类的封装性而导致安全问题。

### 116.Java 反射机制Class类有哪些常用方法?

| 方法名             | 作用                                                         |
| ------------------ | ------------------------------------------------------------ |
| forName()          | (1)获取Class对象的一个引用，但引用的类还没有加载(该类的第一个对象没有生成)就加载了这个类。 (2)为了产生Class引用，forName()立即就进行了初始化。 |
| Object::getClass() | 获取Class对象的一个引用，返回表示该对象的实际类型的Class引用。 |
| getName()          | 取全限定的类名(包括包名)，即类的完整名字。                   |
| getSimpleName()    | 获取类名(不包括包名)                                         |
| getCanonicalName() | 获取全限定的类名(包括包名)                                   |
| isInterface()      | 判断Class对象是否是表示一个接口                              |
| getInterfaces()    | 返回Class对象数组，表示Class对象所引用的类所实现的所有接口。 |
| getSupercalss()    | 返回Class对象，表示Class对象所引用的类所继承的直接基类。应用该方法可在运行时发现一个对象完整的继承结构。 |
| newInstance()      | 返回一个Oject对象，是实现“虚拟构造器”的一种途径。使用该方法创建的类，必须带有无参的构造器。 |
| getDeclaredFields  | 获得某个类的自己声明的字段，即包括public、private和proteced，默认但是不包括父类声明的任何字段。类似的还有getDeclaredMethods和getDeclaredConstructors。 |

### 117.Java 反射可以访问私有方法吗?

AccessibleObject类是Field、Method、和Constructor对象的基类。它提供了将反射的对象标记为在使用时取消默认Java语言访问控制检查的能力。对于公共成员、默认(打包)访问成员、受保护成员和私有成员，在分别使用Field、Method和Constructor对象来设置或获得字段、调用方法，或者创建和初始化类的新实例的时候，会执行访问检查。

当反射对象的accessible标志设为true时，则表示反射的对象在使用时应该取消Java语言访问检查。反之则检查。由于JDK的安全检查耗时较多，所以通过setAccessible(true)的方式关闭安全检查来提升反射速度。

```java
/** 
 * 用Java反射机制来调用private方法 
 * @author WalkingDog 
 * 
 */  
  
public class Reflect {  
      
    public static void main(String[] args) throws Exception {  
          
        //直接创建对象   
        Person person = new Person();  
          
        Class<?> personType = person.getClass();  
          
        //访问私有方法   
       //getDeclaredMethod可以获取到所有方法，而getMethod只能获取public   
        Method method = personType.getDeclaredMethod("say", String.class);            
        //压制Java对访问修饰符的检查   
        method.setAccessible(true);  
          
        //调用方法;person为所在对象   
        method.invoke(person, "Hello World !");  
          
        //访问私有属性   
        Field field = personType.getDeclaredField("name");  
          
        field.setAccessible(true);  
          
        //为属性设置值;person为所在对象   
        field.set(person, "WalkingDog");  
         
        System.out.println("The Value Of The Field is : " + person.getName());  
          
    }  
}  
  
//JavaBean   
class Person{  
    private String name;  
      
    //每个JavaBean都应该实现无参构造方法   
    public Person() {}  
      
    public String getName() {  
        return name;  
    }  
  
    private void say(String message){  
        System.out.println("You want to say : " + message);  
    }  
}
```

### 118.Java反射可以访问私有变量吗?

参考117

### 119.Java 反射可以访问父类的成员吗?

可以。

### 120.Java反射可以访问父类的私有方法吗?

可以。

```java
//先获取到父类
getClass.getSuperClass();
//获取方法
getDeclaredMethod(String name,Class<?>... parameterTypes)
    //或者
getDeclaredMethods()
    //取消安全检查
setAccessible(true)
```

### 121Java反射可以访问父类的私有变量吗?

可以。

### 122.Java 反射有没有性能影响?

使用反射是会有一点性能和效率上的影响，但比起它所带来的好处和便利性，以及应用程序本身所带来的性能问题，反射影响的损耗只是微乎其微，基本可以忽略不计，而且限制主流的Java框架都在大量使用反射。

### 123.Java 反射到底慢在哪?

> https://www.zhihu.com/question/19826278/answer/768578895

反射调用逻辑是委托给MethodAccessor的，而accessor对象会在第一次invoke的时候才创建，是一种lazy init方式。而且默认Class类会cache method对象。目前MethodAccessor的实现有两种，通过设置inflation，一个native方式，一种生成java bytecode方式。native方式启动快，但运行时间长了不如java方式，个人感觉应该是java方式运行长了,jit compiler可以进行优化。所以JDK6的实现，在native方式中，有一个计数器，当调用次数达到阀值，就会转为使用java方式。默认值是15。java方式的实现，基本和非反射方式相同。主要影响性能的问题，1是method.invoke中每次都要进行参数数组包装，2.在method.invoke中要进行方法可见性检查，3在accessor的java实现方式下，invoke时会检查参数的类型匹配。而在JDK7中methodhandle来做反射调用，形参和实参是准确的，所以只需要在链接方法的时候做检查，调用时不用再做检查。并且methodhandle是不可变值，所以jvm可以做激进优化，例如内联。

### 124.Java 有没有 goto 关键字?

 goto是java语言中的保留字，目前还没有在java中使用。

### 125.Java 中有没有指针的概念?

Java 中没有指针，但是有一个类似指针的东西，引用！例如：String str=new String（"Helloworld"）,str 就是引用。

> https://www.zhihu.com/question/20784522/answer/88071991

### 126.Java中的classpath环境变量作用?

classpath是javac编译器的一个环境变量，java命令是按照CLASSPATH变量中的路径来寻找class文件

它的作用与import、package关键字有关。设置Classpath的目的，在于指定类搜索路径，要使用已经编写好的类，前提当然是能够找到它们了，JVM就是通过CLASSPTH来寻找类的.class文件。我们需要把jdk安装目录下的lib子目录中的dt.jar和tools.jar设置到CLASSPATH中，当然，当前目录“.”也必须加入到该变量中。

### 127.为什么不能用+拼接字符串?

不是不能，而是在循环和多个表达式中尽量不用 + 拼接字符串，会频繁创建StringBuilder影响性能。

而在多个字符串字面量拼接可以使用 + ，编译器会自动优化，不会创建StringBuilder。

```java
String a = "a";
String b = "b";
String ab = a + b;//会创建StringBuilder

String ab = "a" + "b";//不会创建StringBuilder。
```

### 128.为什么byte取值范围为-128～127?

java中用补码表示二进制数，补码的最高位是符号位。byte占一个字节空间，最高位是符号位，剩余7位能表示0-127，加上符号位的正负，就是-127至+127，但负0没必要，为充分利用，就用负零表示-128（即原码1000 0000）。（计算机转补码后存储）

### 129.try里面return，finally还会执行吗?

会。

### 130.void 和Void 有什么区别?

void关键字表示函数没有返回结果，是java中的一个关键字。java.lang.Void是一种类型，例如给Void引用赋值null的代码为Void nil=null; Void类型不可以继承与实例化。

### 131.判断两个数字是否相等

基本数据类型只能使用 ==

### 132.IntegerCache 类有什么用?

这是JDK在1.5版本中添加的一项新特性，把-128~127的数字缓存起来了，用于提升性能和节省内存。这个范围内自动装箱（相当于调用valueOf(int i)方法）的数字都会从缓存中获取，返回同一个数字。

### 133.char类型可以存储中文汉字吗?

char型变量是用来存储unicode编码的字符的，unicode编码字符集中包含了汉字，所以char型变量中当然可以存储汉字。

不过，如果某个特殊的汉字没有被包含在unicode编码字符集中，那么，这个char型变量中就不能存储这个特殊汉字。

补充：unicode编码占用两个字节，所以，char类型的变量也是占用两个字节。

### 134.Java中的一个汉字占几个字节?

两个字节

### 135.Java中的一个字符占几个字节?

“字符”指的是 char，那它就是 16 位，2 字节。

如果“字符”是指我们用眼睛看到的那些“抽象的字符”，那么，谈论它占几个字节是没有意义的。

具体地讲，**脱离具体的编码谈某个字符占几个字节是没有意义的**。

> https://www.zhihu.com/question/27562173/answer/37188642

### 136.为什么Java 不支持类多继承?

多继承指一个子类能同时继承于多个父类，从而同时拥有多个父类的特征，但缺点是显著的。

1. 若子类继承的父类中拥有相同的成员变量，子类在引用该变量时将无法判别使用哪个父类的成员变量。

2. 若一个子类继承的多个父类拥有相同方法，同时子类并未覆盖该方法（若覆盖，则直接使用子类中该方法），那么调用该方法时将无法确定调用哪个父类的方法。

Java仅允许单继承，即一个子类只能继承于一个父类。但为了拓展子类的功能，Java使用接口以克服不使用多继承带来的不足。接口是一个特殊的抽象类，接口中成员变量均默认为 static final 类型，即常量，且接口中的方法都为抽象的，都没有方法体。具体方法只能由实现接口的类实现，在调用的时候始终只会调用实现类的方法（不存在歧义），因此不存在 多继承的第二个缺点；而又因为接口只有静态的常量，但是由于静态变量是在编译期决定调用关系的，即使存在一定的冲突也会在编译时提示出错；而引用静态变量一般直接使用类名或接口名，从而避免产生歧义，因此也不存在多继承的第一个缺点。 对于一个接口继承多个父接口的情况也一样不存在这些缺点。

### 137.一个".java"源文件的类有什么限制?

一个 .java 源文件可以创建多个 Java 类，但最多只能创建一个公开类 (public class)，而且文件名必须和公开类的类名完全保持一致

### 138.2*8最有效率的计算方法是什么?

二进制运算效率比较高，2<<3。

### 139.StringJoiner有什么用?

作用是在构造字符串时，可以自动添加前缀、后缀及分隔符，而不需要自己去实现这些添加字符的逻辑

> https://www.cnblogs.com/dagger9527/p/12285758.html

### 140.Java类初始化顺序是怎样的?

1. 父类静态初始化块及静态成员变量
2. 子类静态初始化块及静态成员变量
3. 父类非静态初始化块及非静态成员变量
4. 父类构造函数
5. 子类非静态初始化块及非静态成员变量
6. 子类构造函数

### 141.为什么成员变量命名不建议用isXX?

阿里巴巴的《Java开发手册》：

POJO 类中布尔类型变量都不要加 is 前缀，否则部分框架解析会引起序列化错误。 反例：定义为基本数据类型 Boolean isDeleted 的属性，它的方法也是 isDeleted()，RPC 框架在反向解析的时候，“误以为”对应的属性名称是 deleted，导致属性获取不到，进而抛出异常。

> https://blog.csdn.net/xiaoye319/article/details/85232719

### 142.hashCode有什么用?

hashcode方法返回该对象的哈希码值。

hashCode 的常规协定是： 

- 在 Java 应用程序执行期间，在同一对象上多次调用 hashCode 方法时，必须一致地返回相同的整数，前提是对象上 equals 比较中所用的信息没有被修改。从某一应用程序的一次执行到同一应用程序的另一次执行，该整数无需保持一致。 
- 如果根据 equals(Object) 方法，两个对象是相等的，那么在两个对象中的每个对象上调用 hashCode 方法都必须生成相同的整数结果。 
- 以下情况不是必需的：如果根据 equals(java.lang.Object) 方法，两个对象不相等，那么在两个对象中的任一对象上调用 hashCode 方法必定会生成不同的整数结果。但是，程序员应该知道，为不相等的对象生成不同整数结果可以提高哈希表的性能。 

实际上，由 Object 类定义的 hashCode 方法确实会针对不同的对象返回不同的整数。

当equals方法被重写时，通常有必要重写 hashCode 方法，以维护 hashCode 方法的常规协定，该协定声明相等对象必须具有相等的哈希码。

> hashcode 和内存地址的关系：https://blog.csdn.net/zhipengfang/article/details/119338525

### 143.hashCode和identityHashCode的区别?

- 对象的hashCode，一般是通过将该对象的内部地址转换成一个整数来实现的

 * 当一个类没有重写Object类的hashCode()方法时，它的hashCode和identityHashCode是一致的
 * 当一个类重写了Object类的hashCode()方法时，它的hashCode则有重写的实现逻辑决定，此时的hashCode值一般就不再和对象本身的内部地址有相应的哈希关系了
 * 当null调用hashCode方法时，会抛出空指针异常，但是调用System.identityHashCode(null)方法时能正常的返回0这个值
 * 一个对象的identityHashCode能够始终和该对象的内部地址有一个相对应的关系，从这个角度来讲，它可以用于代表对象的引用地址，所以，在理解==这个操作运算符的时候是比较有用的

### 144.Java中的断言（assert）是什么?

assertion(断言)在软件开发中是一种常用的调试方式，assertion就是在程序中的一条语句，它对一个boolean表达式进行检查，一个正确程序必须保证这个boolean表达式的值为true；如果该值为false，说明程序已经处于不正确的状态下，系统将给出警告并且退出。一般来说，assertion用于保证程序最基本、关键的正确性。assertion检查通常在开发和测试时开启。为了提高性能，在软件发布后，assertion检查通常是关闭的

> https://blog.csdn.net/weixin_41922289/article/details/91428451

### 145.Java 语法糖是什么意思?

语法糖指的是计算机语言中添加的某种语法，这种语法对语言的功能并没有影响，但是更方便程序员使用。因为 Java 代码需要运行在 JVM 中，JVM 是并不支持语法糖的，语法糖在程序编译阶段就会被还原成简单的基础语法结构，这个过程就是解语法糖。

如泛型、自动装箱拆箱、方法变长参数、增强for循环、枚举、try-with-resources、switch、字符串相加+、断言、

### 146.Java 常用的元注解有哪些?

@Target,@Retention,@Documented,@Inherited 

@Repeatable（jdk8）

### 147.Java 金额计算怎么避免精度丢失?

在double，float类型之间做计算经常会出现精度丢失的情况，用BigDecimal类进行计算就不会出现这种精度丢失的情况了，所以封装了加减乘除的方法，方便使用。

### 148.Java中>>>是什么语法?

- << 表示左移，不分正负数，低位补0
- \>>  表示右移，如果该数为正，则高位补0，若为负数，则高位补1
- \>>> 表示无符号右移，也叫逻辑右移，即若该数为正，则高位补0，而若该数为负数，则右移后高位同样补0

### 149.Java 8 都新增了哪些新特性?

常见的：lambda表达式、Stream api、新的日期和时间api

> 具体参考
>
> https://blog.csdn.net/yczz/article/details/50896975
>
> https://www.javacodegeeks.com/java-8-features-tutorial.html#Optional

### 150.Lambda 表达式是什么?

Lambda 表达式（lambda expression）是一个匿名函数，可以不借助对象传递的一个代码段。

### 151.Lambda 表达式的用途有哪些?

1. 目标类型是函数式接口。

2. 集合批量操作
3. 流处理

### 152.写一个Lambda 表达式的使用示例

```
Runnable runnable = ()->{};
```

### 153.Optional类有什么用?

解决 NullPointerException 与繁琐的 null 检查

### 154.Stream （流）是什么?

### 155.Stream （流）分为哪几类?

### 156.Java 中的 :: 是什么语法?

### 157.方法引用是什么?

### 158.方法引用分为哪几类?

### 159.函数式接口是什么?

### 160.函数式接口分为哪几类?

### 161.怎么创建一个 Stream 流?

### 162.@Repeatable 注解有什么用?

### 163.@Repeatable 注解在哪里有用到?

### 164.Oracle JDK和 OpenJDK有啥区别?

### 165.JDK实现定时任务有哪些方式?

```java
1. schedule(TimerTask task, long delay) 延迟 delay 毫秒 执行
public static void main(String[] args) {
        for (int i = 0; i < 10; ++i) {
            new Timer("timer - " + i).schedule(new TimerTask() {
                @Override
                public void run() {
                    println(Thread.currentThread().getName() + " run ");
                }
            }, 1000);
        }
    }

2. schedule(TimerTask task, Date time) 特定時間執行
public static void main(String[] args) {
        for (int i = 0; i < 10; ++i) {
            new Timer("timer - " + i).schedule(new TimerTask() {
                @Override
                public void run() {
                    println(Thread.currentThread().getName() + " run ");
                }
            }, new Date(System.currentTimeMillis() + 2000));
        }
    }

3. schedule(TimerTask task, long delay, long period) 延迟 delay 执行并每隔period 执行一次
public static void main(String[] args) {
        for (int i = 0; i < 10; ++i) {
            new Timer("timer - " + i).schedule(new TimerTask() {
                @Override
                public void run() {
                    println(Thread.currentThread().getName() + " run ");
                }
            }, 2000 , 3000);
        }
    }

```

```java
public static void main(String[] args) throws SchedulerException {
        ScheduledThreadPoolExecutor executor = (ScheduledThreadPoolExecutor)Executors.newScheduledThreadPool(10);
        for (int i = 0; i < 10; ++i) {
            executor.schedule(new Runnable() {
                @Override
                public void run() {
                    System.out.println(Thread.currentThread().getName() + " run ");
                }
            } , 2 , TimeUnit.SECONDS);
        }
        executor.shutdown();
    }

```

> https://blog.csdn.net/kegumingxin2626/article/details/72854823/

### 166.Java事件机制包含哪三部分?

EventObject，EventListener和Source

事件，事件监听器，事件源

### 167.Java中的 UUID是什么?

UUID全称：Universally Unique Identifier，即通用唯一识别码。

UUID是由一组32位数的16进制数字所构成，是故UUID理论上的总数为16^32 = 2^128，约等于3.4 x 10^38。也就是说若每纳秒产生1兆个UUID，要花100亿年才会将所有UUID用完。

UUID的标准型式包含32个16进制数字，以连字号分为五段，形式为8-4-4-4-12的32个字符，如：550e8400-e29b-41d4-a716-446655440000。

**作用：**

UUID的是让分布式系统中的所有元素都能有唯一的辨识信息，而不需要通过中央控制端来做辨识信息的指定。如此一来，每个人都可以创建不与其它人冲突的UUID。在这样的情况下，就不需考虑数据库创建时的名称重复问题。目前最广泛应用的UUID，是微软公司的全局唯一标识符（GUID），而其他重要的应用，则有Linux ext2/ext3文件系统、LUKS加密分区、GNOME、KDE、Mac OS X等等。

> https://www.cnblogs.com/kjgym/p/11614510.html

### 168.什么是 JDBC?

### 169.Java日期格式中YYY与 yyyy 的区别?

jDK6的SimpleDateFormat只有小“y”,没有大“Y”。JDK7开始引入了大“Y”，表示Week year。
Week year意思是当天所在的周属于的年份，一周从周日开始，周六结束，只要本周跨年，那么这周就算入下一年。

### 170.@Deprecated 注解的作用?

用 @Deprecated注解的程序元素，不鼓励程序员使用这样的元素，通常是因为它很危险或存在更好的选择。在使用不被赞成的程序元素或在不被赞成的代码中执行重写时，编译器会发出警告。

### 171.字符串在 JDK内部是用的编码存储?

字符串在 JDK 内部存储的编码是：UTF-16

但这样存储英文肯定是一种浪费，所以在 JDK9 中队这块进行了优化，没有必要使用 UTF-16 的字符会使用 byte 来存储以优化内存。

### 组合拳

StringBuffer和 StringBuilder 的区别?

什么是线程安全？如何保证线程安全？

什么是锁？死锁？

synchronized的实现原理是什么？有了synchronized，还要volatile干什么？synchronized的锁优化是怎么回事？（锁粗化？锁消除？自旋锁？偏向锁？轻量级锁？）

知道JMM吗？（原子性？可见性？有序性？）Java并发包了解吗？

那什么是fail-fast？什么是fail-safe？

什么是CopyOnWrite？

那AQS呢？那CAS呢？CAS都知道，那乐观锁一定知道了？乐观锁悲观锁区别是什么？

数据库如何实现悲观锁和乐观锁？数据库锁有了解么？

行级锁？表级锁？共享锁？排他锁？gap锁？next-key lock？

数据库锁和隔离级别有什么关系？

数据库锁和索引有什么关系？

什么是聚簇索引？非聚簇索引？最左前缀是什么？B+树索引？联合索引？回表？

分布式锁有了解吗？

Redis怎么实现分布式锁？为什么要用Redis？Redis和memcache区别是什么？

Zookeeper怎么实现分布式锁？什么是Zookeeper？

什么是CAP？什么是BASE？和CAP什么区别？CAP怎么推导？如何取舍？

分布式系统怎么保证数据一致性？啥是分布式事务？分布式事务方案？

那么，最后了，来手写一个线程安全的单例吧？不用synchronized和lock能实现线程安全的单例吗？这你都能答上？那好吧，你给我解释下什么是Paxos算法吧？

卒~

