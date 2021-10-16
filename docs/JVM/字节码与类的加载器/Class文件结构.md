# 概述

## 字节码文件的跨平台性

**Java 语言：跨平台的语言(write once, run anywhere)**

- 当 Java 源代码成功编译成字节码后，如果想在不同的平台上面运行， 则无须再次编译

- 但是 这个优势不再那么吸引人了。Python、PHP、Perl、Ruby、Lisp 等有强大的解释器 

- 跨平台似乎已经快称为一门语言必选的特性

**Java 虚拟机：跨语言的平台**

- Java 虚拟机不和包括 Java 在内的任何语言绑定，它只与"Class 文件"这种特定的二进制文件格式所关联。无论使用何种语言进行软件开发， 只要能将源文件编译为正确的 Class 文件，那么这种语言就可以在 Java 虚拟机上执行，可以说，统一而强大的 Class 文件结构，就是 Java 虚拟机的基石、桥梁。

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/1617514205368-68f1993b-10b2-4604-9984-14825033e95e.png)



![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/1617514378709-8b070865-7217-4649-9192-d727fd230e83.png)

https://docs.oracle.com/javase/specs/index.html

中篇以java8为主体进行讲解https://docs.oracle.com/javase/specs/jvms/se8/html/index.html

3.想要让一个Java程序正确地运行在JVM中,Java源码就必须要编译为符合JVM规范的字节码。

- 前端编译器的主要任务就是负责将符合Java语法规范的Java代码转换为符合JVM规范的字节码文件。

- javac是一种能够将Java源码编译为字节码的前端编译器

- javac编译器在将Java源码编译为一个有效的字节码文件过程中经历了4个步骤:分别是词法解析,语法解析,语义解析,生成字节码

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/1617514748491-d7b67953-dd7c-44d9-917e-0340ddce63aa.png)

Oracle的JDK软件包括两部分内容:

- 一部分是将Java源代码编译成Java虚拟机的指令集的编译器(前端编译器不包含在jvm中)

- 另一部分是用于实现Java虚拟机的运行时环境

------

## java的前端编译器

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/1617514947346-fa42c335-a7a0-4d31-afe6-861c3bb858ee.png)

**前端编译器 vs 后端编译器**

- Java源代码的编译结果是字节码,需要有一种编译器能够将 Java 源码编译为字节码，承担这个重要责任的就是配置在path环境变量中的 javac 编译器,它是一种能够将 Java 源码编译为字节码的前端编译器。

- HotSpot VM并没有强制要求前端编译器只能使用 javac 来编译字节码,其实只要编译结果符合JVM规范都可以被JVM所识别即可。在Java的前端编译器领域,除了 javac 之外,还有一种被大家经常用到的前端编译器,那就是内置在 Eclipse 中的 ECJ(Eclipse Compiler for Java) 编译器。和 javac 的全量式编译不同,ECJ 是一种增量式编译器。

- - 在Eclipse中,当开发人员编写完代码后,使用"Ctrl+S"快捷键时,ECJ编译器所采取的编译方案是把未编译部分的源代码逐行进行编译,而非每次都全量编译。因此ECJ的编译效率会比javac更加迅速和高效,而编译质量和javac相比大致还是一样的。
  - ECJ不仅是 Eclipse 的默认内置前端编译器,在Tomcat中同样也是使用ECJ编译器来编译jsp文件。
    由于 ECJ 编译器是采用 GPLv2 的开源协议进行源代码公开,所以大家可以登录 Eclipse 官网下载ECJ编译器的源码进行二次开发。

- - 默认情况下,IntelliJ IDEA使用javac编译器。(可自行设置为AspectJ编译器 ajc)

- 前端编译器并不会直接涉及编译优化等方面的技术,而是将这些具体优化细节移交给 HotSpot 的 JIT 编译器负责。

- AOT Compiler（Ahead Of Time Compiler）,静态提前编译器,程序运行之前将字节码文件直接翻译成机器指令

------

## 通过字节码指令看代码细节

BAT 面试题

- 类文件结构有几个部分？
- 知道字节码吗？字节码都有哪些？Integer x = 5; int y = 5;比较 x == y 都经过哪些步骤？

代码举例1

```java
public class IntegerTest {
    public static void main(String[] args) {
        /*
        * 通过字节码和源码可以看出,当Integer的范围在 -128 ~ 127 之间会在数组中直接拿取数值
        * 超过这个范围会重新 new 对象
        * */
        Integer x = 5;
        int y = 5;
        System.out.println(x == y);    // true,拆箱,比较数值
        Integer i1 = 10;
        Integer i2 = 10;
        System.out.println(i1 == i2);  // true
        Integer i3 = 128;
        Integer i4 = 128;
        System.out.println(i3 == i4);  // false
    }
}
```

代码举例2:

```java
package com.atguigu.java;
public class StringTest {
    public static void main(String[] args) {
//通过字节码发现new了StringBuilder,append后再toString返回str
        //toString方法重新new了一个String对象
        String str = new String("hello") + new String("world");
        String str1 = "helloworld";
        System.out.println(str == str1);        //false
        String str2 = new String("helloworld");
        System.out.println(str == str2);       //false
    }
}
```

代码举例3:

```java
/*
成员变量（非静态的）的赋值过程： ① 默认初始化 - ② 显式初始化 /代码块中初始化 - ③ 构造器中初始化 - ④ 有了对象之后，可以“对象.属性”或"对象.方法"
 的方式对成员变量进行赋值。
 */
class Father {
    int x = 10;

    public Father() {
        this.print();
        x = 20;
    }
    public void print() {
        System.out.println("Father.x = " + x);
    }
}

class Son extends Father {
    int x = 30;
//    float x = 30.1F;
    public Son() {
        this.print();
        x = 40;
    }
    public void print() {
        System.out.println("Son.x = " + x);
    }
}

public class SonTest {
    public static void main(String[] args) {
        Father f = new Son();
        System.out.println(f.x);
    }
}
```

先看第一种情况比较简单:`Father f = new Father();`

运行结果:

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/1617526544559-01970ec4-db6f-44c8-b949-c2ae7fe5a9c6.png)

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/1617526883132-210bacac-8aff-46b5-812e-3239ea0c82dd.png)



再看情况2：`Father f = new Son();`

运行结果：

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617527033000-b0122b55-4ec7-4d79-8a74-fbc7784e1434.png)

由于创建的是子类对象，print方法被重写,所以父类构造器的this.print调用的是子类的print

但是属性没有多态，所以f.x=20

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/1617527155890-bbc55bc7-6c1d-430e-9965-44ecd92a7ee6.png)

# 虚拟机的基石：Class文件

字节码文件是什么？

- 源代码经过编译器编译之后会生成一个或多个字节码文件，字节码是一种二进制的类文件，内容是 JVM 指令，而不像 C、C++ 经由编译器直接生成机器码。

什么是字节码指令（byte code）?

- Java 虚拟机的指令由一个字节长度的、代表着某种特定操作含义的操作码（opcode） 以及跟随其后的 0 个至多个 代表此操作所需参数的操作数（operand） 所构成。虚拟机中许多指令并不包含操作数，只有一个操作码。

- 比如： 操作码（操作数）

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617527596493-c62f1a91-2e6d-4b28-88eb-3549e0322856.png)



如何解读供虚拟机解释执行的二进制字节码？

- Notepad++ 中安装 HEX-Editor 插件，或者使用 Binary Viewer
- javap -v xxx.class > xxx.txt
- ![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617528151874-8bece6f9-2bce-45bf-a616-561ac914cfd5.png)

- 使用 IDEA 插件：jclasslib 或者 jclasslib bytecode viewer 客户端工具。(可视化更好)


![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617527840551-b04ed841-0c8d-4aeb-a079-ef614066c513.png)

# Class文件结构

## 概述

官方文档位置: https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html

Class 类的本质

- 任何一个 Class 文件都对应着唯一一个类或接口的定义信息。但反过来说，Class 文件实际上并不一定以磁盘文件的形式存在（也通过网络传输）。Class 文件是一组以 8 位字节为基础单位的 二进制流。


Class 文件格式

- Class 的结构不像 XML 等描述语言，它没有任何分隔符号。所以在其中的数据项，无论是字节顺序还是数量，都是被严格限定的，哪个字节代表什么含义，长度是多少，先后顺序如何，都不允许改变。


Class 文件格式采用一种类似于 C 语言结构体的方式进行数据存储，这种结构中只有两种数据类型：无符号数和表。

- 无符号数：属于基本数据类型，以 u1、u2、u4、u8 类分别代表 1 个字节、2 个字节、4 个字节、8 个字节的无符号数，无符号数可以用来描述数字、索引引用、数量值或按照 UTF-8 编码构成字符串值。
- 表：由多个无符号数或者其他表作为数据项构成的复合数据类型，所有表都习惯地以 “_info” 结尾。表用于描述有层次关系的复合结构的数据，整个 Class 文件本质上就是一张表。由于表没有固定长度，所以通常会在其前面加上个数说明。

随着 Java 平台的不断发展，在将来，Class 文件的内容也一定会做进一步的扩充，但是其基本的格式和结构不会做重大调整。

从 Java 虚拟机的角度看，通过 Class 文件，可以让更多的计算机语言支持 Java 虚拟机平台。因此，Class 文件结构不仅仅是 Java 虚拟机的执行入口，更是 Java 生态圈的基础和核心。

代码举例

```
public class Demo {
    
	private int num = 1;
    
	public int add(){
        num = num + 2;
        return num;
    }
}
```

- 对应的字节码文件

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617530052240-fbb797c4-6645-41f4-b073-fef9e8ce3a14.png)

-  解析后的效果

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617530066616-fd1a36a7-fe1b-486a-a375-a60c4d24739e.png)

- 换句话说，充分理解了每一个字节码文件的细节，自己也可以反编译出Java源文件来。



- class文件结构概述

- - Class 文件的结构并不是一成不变的，随着 Java 虚拟机的不断发展，总是不可避免地会对 Class 文件结构做出一些调整，但是其基本结构和框架是非常稳定的。



- Class 文件的总体结构

- - 魔数
  - Class 文件版本

- - 常量池
  - 访问标志

- - 类索引，父类索引，接口索引集合
  - 字段表集合

- - 方法表集合
  - 属性表集合

- - ![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617530768252-a864eabb-4aad-470c-b622-05608c9425dc.png)

这是一张Java字节码总的结构表，我们按照上面的顺序逐一进行解读就可以了。

| 类型           | 名称                | 说明                   | 长度    | 数量                  |
| -------------- | ------------------- | ---------------------- | ------- | --------------------- |
| u4             | magic               | 魔数,识别Class文件格式 | 4个字节 | 1                     |
| u2             | minor_version       | 副版本号(小版本)       | 2个字节 | 1                     |
| u2             | major_version       | 主版本号(大版本)       | 2个字节 | 1                     |
| u2             | constant_pool_count | 常量池计数器           | 2个字节 | 1                     |
| cp_info        | constant_pool       | 常量池表               | n个字节 | constant_pool_count-1 |
| u2             | access_flags        | 访问标识               | 2个字节 | 1                     |
| u2             | this_class          | 类索引                 | 2个字节 | 1                     |
| u2             | super_class         | 父类索引               | 2个字节 | 1                     |
| u2             | interfaces_count    | 接口计数器             | 2个字节 | 1                     |
| u2             | interfaces          | 接口索引集合           | 2个字节 | interfaces_count      |
| u2             | fields_count        | 字段计数器             | 2个字节 | 1                     |
| field_info     | fields              | 字段表                 | n个字节 | fields_count          |
| u2             | methods_count       | 方法计数器             | 2个字节 | 1                     |
| method_info    | methods             | 方法表                 | n个字节 | methods_count         |
| u2             | attributes_count    | 属性计数器             | 2个字节 | 1                     |
| attribute_info | attributes          | 属性表                 | n个字节 | attributes_count      |



这里整体给大家讲解一遍，这里需要注意听。否则大家以后也很难有动力，踏实认真的一个字节一个字节的解读一遍。

[📎Demo字节码的解析.xlsx](https://www.yuque.com/attachments/yuque/0/2021/xlsx/12731578/1617531040446-390bafdf-ec0c-44b0-956b-a42800405c48.xlsx)

------

## 魔数：Class文件的标志（Magic Number）

- 每个 Class 文件开头的 4 个字节的无符号整数称为魔数。



- 它的唯一作用是校验这个文件是否为一个能被虚拟机接受的有效合法的 Class 文件。即:魔数是 Class 文件的标识符。



- 魔数值固定为 0xCAFEBABE，不会改变。



- 如果一个 Class 文件不以 0xCAFEBABE 开头，虚拟机在进行文件校验的时候就会直接抛出以下错误：

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617531785855-6e0058c4-374d-4555-9fac-7bdc1e778337.png)



- 使用魔数而不是扩展名来进行识别主要是基于安全方面的考虑，扩展名可随意改动。

------

## Class文件版本号

- 紧接着魔数的 4 个字节存储的是 Class 文件的版本号，同样也是 4 个字节。第 5 个和第 6 个字节所代表的含义就是编译的副版本号 minor_version，而第 7 个和第 8 个字节是编译的主版本号 major_version。



- 它们共同构成了 Class 文件的格式版本号。如，某个 Class 文件的主版本号为 M，副版本号为 m，那么这个 Class 文件的格式版本号为 M.m。



- 版本号和 Java 编译器的对应关系如下表：

| 主版本（十进制） | 副版本（十进制） | 编译器版本 |
| ---------------- | ---------------- | ---------- |
| 45               | 3                | 1.1        |
| 46               | 0                | 1.2        |
| 47               | 0                | 1.3        |
| 48               | 0                | 1.4        |
| 49               | 0                | 1.5        |
| 50               | 0                | 1.6        |
| 51               | 0                | 1.7        |
| 52               | 0                | 1.8        |
| 53               | 0                | 1.9        |
| 54               | 0                | 1.10       |
| 55               | 0                | 1.11       |

- Java 的版本号是从 45 开始，JDK 1.1 之后的每个 JDK 大版本发布主版本号向上加 1。



- 不同版本的 Java 编译器编译的 Class 文件对应的版本是不一样的。目前，高版本的 Java 虚拟机可以执行由低版本编译器生成的 Class 文件。但是低版本的 Java 虚拟机不能执行由高版本编译器生成的 Class 文件。否则 JVM 会抛出 java.lang.UnsupportedClassVersionError异常。

 

- 在实际应用中，由于开发环境和生产环境不同，可能会导致该问题的发生。因此需要在开发时，特别注意开发编译的 JDK 版本和生产环境中的 JDK 版本是否一致。



- 虚拟机 JDK 版本为 1.k（k >= 2）时，对应的 Class 文件格式版本号的范围为 45.0 - 44 + k.0（含两端）。

------

## 常量池：存放所有常量

- 常量池是 Class 文件中内容最为丰富的区域之一。常量池对于 Class 文件中的字段和方法解析也有着至关重要的作用。



- 随着 Java 虚拟机的不断发展，常量池的内容也日渐丰富。可以说，常量池是整个 Class 文件的基石。

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617541316016-16768348-b0f4-4581-ac2f-06475a7b070a.png)

- 在版本号之后，紧跟着的是常量池的数量，以及若干个常量池表项。



- 常量池中常量的数量是不固定的，所以在常量池的入口需要放置一项 u2 类型的无符号数，代表常量池容量计数值(constant_pool_count),与 Java 中语言习惯不一样的是，这个容量计数器是从 1 而不是 0 开始的。



| u2      | constant_pool_count | 常量池计数器 | 2个字节 | 1                     |
| ------- | ------------------- | ------------ | ------- | --------------------- |
| cp_info | constant_pool       | 常量池表     | n个字节 | constant_pool_count-1 |

- 由上表可见，Class文件使用了一个前置的容量计数器(constant_pool_count)加若干个连续的数据项（constant_poo）的形式来描述常量池内容。我们把这一系列连续常量池数据称为常量池集合。



- 常量池表项中，用于存放编译时期生成的各种字面量和符号引用，这部分内容将在类加载后进入方法区的运行时常量池中存放

### 常量池计数器（constant_pool_count）

- 由于常量池的数量不固定，时长时短，所以需要放置两个字节来表示常量池容量计数值。



- 常量池容量计数值（u2 类型）：从 1 开始，表示常量池中有多少项常量。即constant_pool_count = 1 表示常量池中有 0 个常量项。



- Demo 的值为：

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617541695356-428bdea7-037f-49a9-b662-9eecd6fc8852.png)

- 其值为 0x0016，对应的十进制为 22。



- 需要注意的是，实际上只有 21 项常量。所以索引范围时 1 ~ 21。



- 为什么索引是从 1 开始？



- 常量池索引从 1 开始，因为把第 0 项常量空出来了。这是为了满足后面某些指向常量池的索引值的数据在特定情况下需要表达“不引用任何一个常量池项目”的含义，这种情况可用索引 0 来表示。

### 常量池表（constant_pool）

- constant_pool 是一种表结构，以 1 ~ constant_pool_count - 1 为索引。表明了后面有多少个常量项。



- 常量池主要存放两大类常量：字面量（Literal）和符号引用（Symbolic References）



- 它包含了 Class 文件结构及其子结构中引用的所有字符串常量、类或接口名、字段名和其他常量。常量池中的每一项都具备相同的特征。第 1 个字节作为类型标记，用于确定该项的格式，这个字节称为 tag byte （标记字节、标签字节）。

| 类型                             | 标志(或标识) | 描述                   |
| -------------------------------- | ------------ | ---------------------- |
| CONSTANT_utf8_info               | 1            | UTF-8编码的字符串      |
| CONSTANT_Integer_info            | 3            | 整型字面量             |
| CONSTANT_Float_info              | 4            | 浮点型字面量           |
| CONSTANT_Long_info               | 5            | 长整型字面量           |
| CONSTANT_Double_info             | 6            | 双精度浮点型字面量     |
| CONSTANT_Class_info              | 7            | 类或接口的符号引用     |
| CONSTANT_String_info             | 8            | 字符串类型字面量       |
| CONSTANT_Fieldref_info           | 9            | 字段的符号引用         |
| CONSTANT_Methodref_info          | 10           | 类中方法的符号引用     |
| CONSTANT_InterfaceMethodref_info | 11           | 接口中方法的符号引用   |
| CONSTANT_NameAndType_info        | 12           | 字段或方法的符号引用   |
| CONSTANT_MethodHandle_info       | 15           | 表示方法句柄           |
| CONSTANT_MethodType_info         | 16           | 标志方法类型           |
| CONSTANT_InvokeDynamic_info      | 18           | 表示一个动态方法调用点 |



**字面量和符号引用**

- 常量池主要存放两大类型常量：字面量（Literal）和符号引用（Symbolic Reference）。
- ![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617542728389-9ec355e6-55a2-461b-9858-4a17b010e06f.png)

- - `String str = "atguigu";`
  - `final int NUM = 10`



- 全限定名

- - 如，`com/test/Demo` 就是类的全限定名，仅仅是把包名的 “ . ” 替换成了 “ / ”，为了使连续的多个全限定名之间不混淆产生，使用时最后一般会加入一个“ ; ”表示全限定名结束。



- 简单名称

- - 指没有类型和参数修饰的方法或字段名称，上面例子中的类的 add() 方法和 num 字段的简单名称分别是add和 num。



- 描述符

- - 用来描述字段的数据类型、方法的参数列表（包括数量、类型及顺序）和返回值。根据描述符规则，基本数据类型（byte、char、double、float、int、long、short、boolean）以及代表无返回值的 void 类型都用一个大写字符来表示，而对象类型则用字符 L 加对象的全限定名来表示：

| 标志符 | 含义                                                 |
| ------ | ---------------------------------------------------- |
| B      | 基本数据类型byte                                     |
| C      | 基本数据类型char                                     |
| D      | 基本数据类型double                                   |
| F      | 基本数据类型float                                    |
| I      | 基本数据类型int                                      |
| J      | 基本数据类型long                                     |
| S      | 基本数据类型short                                    |
| Z      | 基本数据类型boolean                                  |
| V      | 代表void类型                                         |
| L      | 对象类型，比如：`Ljava/lang/Object;`                 |
| [      | 数组类型，代表一维数组。比如：`double[][][] is [[[D` |

- 用描述符来描述方法时,按照先参数列表,后返回值的顺序描述，参数列表按照参数的严格顺序放在一组小括号“()”之内。

- - 如：方法 java.lang.String.toString() 的描述符为()Ljava/lang/String；方法 int abc(int[] x, int y) 的描述符为([II)I。

```
public class ArrayTest {
    public static void main(String[] args) {
        Object[] arr = new Object[10];
        System.out.println(arr);//[Ljava.lang.Object;@1540e19d

        String[] arr1 = new String[10];
        System.out.println(arr1);//[Ljava.lang.String;@677327b6

        long[][] arr2 = new long[10][];
        System.out.println(arr2);//[[J@14ae5a5
    }
}
```

**补充说明**

- 虚拟机在加载 Class 文件时才会进行动态链接，也就是说，Class 文件中不会保存各个方法和字段的最终内存布局信息。因此，这些字段和方法的符号引用不经过转换是无法直接被虚拟机使用。当虚拟机运行时，需要从常量池中获得对应的符号引用，再在类加载过程中的解析阶段将其替换为直接引用，并翻译到具体的内存地址中。



- 符号引用和直接引用的区别与关联：
- **符号引用**

- - 以一组符号来描述所引用的目标，符号可以是任何形式的字面量，只要使用时能无歧义地定位到目标即可。符号引用与虚拟机实现的内存布局无关，引用的目标不一定已经加载到了内存中。

- **直接引用**

- - 可以是直接指向目标的指针、相对偏移量或是一个能间接定位到目标的句柄。直接引用时与虚拟机实现的内存布局相关的，同一个符号引用在不同虚拟机实例上翻译出来的直接引用一般不会相同。如果有了直接引用，那说明引用的目标必定已经存在于内存之中了。



**常量类型和结构**

常量池中每一项常量都是一个表，JDK 1.7 之后（9 和 11 有增加）共有 14 种不同的表结构数据，如下表：

要注意标志tag=1时为字符串,长度是不确定的,比如该字节码文件的第二行

| 01   | 00   | 03   | 6e   | 75   | 6d   |
| ---- | ---- | ---- | ---- | ---- | ---- |
|      |      |      |      |      |      |

通过查表发现tag后面是length,表示字符串占用的字符数为3，使用u2存放,所以后面3个字节是字符串本身

[📎Demo字节码的解析.xlsx](https://www.yuque.com/attachments/yuque/0/2021/xlsx/12731578/1617549773964-2d63dca5-f23b-477f-b0e0-cb3d602e58e5.xlsx)

[📎常量类型和结构.xls](https://www.yuque.com/attachments/yuque/0/2021/xls/12731578/1617549631967-83f4b68d-5e9a-4bc2-9731-37578dc36db8.xls)

解读：https://www.bilibili.com/video/BV1PJ411n7xZ?p=220&spm_id_from=pageDriver

| 常量类型和结构        |                                  |                                                              |      |      |          |
| --------------------- | -------------------------------- | ------------------------------------------------------------ | ---- | ---- | -------- |
|                       |                                  |                                                              |      |      |          |
| 标志                  | 常量                             | 描述                                                         | 细节 | 长度 | 细节描述 |
| 1                     | CONSTANT_utf8_info               | UTF-8编码的字符串                                            | tag  | u1   | 值为1    |
| length                | u2                               | UTF-8编码的字符串占用的字符数                                |      |      |          |
| bytes                 | u1                               | 长度为length的UTF-8编码的字符串                              |      |      |          |
| 3                     | CONSTANT_Integer_info            | 整型字面量                                                   | tag  | u1   | 值为3    |
| bytes                 | u4                               | 按照高位在前存储的int值                                      |      |      |          |
| 4                     | CONSTANT_Float_info              | 浮点型字面量                                                 | tag  | u1   | 值为4    |
| bytes                 | u4                               | 按照高位在前存储的float值                                    |      |      |          |
| 5                     | CONSTANT_Long_info               | 长整型字面量                                                 | tag  | u1   | 值为5    |
| bytes                 | u8                               | 按照高位在前存储的long值                                     |      |      |          |
| 6                     | CONSTANT_Double_info             | 双精度浮点型字面量                                           | tag  | u1   | 值为6    |
| bytes                 | u8                               | 按照高位在前存储的double值                                   |      |      |          |
| 7                     | CONSTANT_Class_info              | 类或接口的符号引用                                           | tag  | u1   | 值为7    |
| index                 | u2                               | 指向全限定名常量项的索引                                     |      |      |          |
| 8                     | CONSTANT_String_info             | 字符串类型字面量                                             | tag  | u1   | 值为8    |
| index                 | u2                               | 指向字符串字面量的索引                                       |      |      |          |
| 9                     | CONSTANT_Fieldref_info           | 字段的符号引用                                               | tag  | u1   | 值为9    |
| index                 | u2                               | 指向声明字段的类或接口描述符CONSTANT_Class_info的索引项      |      |      |          |
| index                 | u2                               | 指向字段描述符CONSTANT_NameAndType的索引项                   |      |      |          |
| 10                    | CONSTANT_Methodref_info          | 类中方法的符号引用                                           | tag  | u1   | 值为10   |
| index                 | u2                               | 指向声明方法的类描述符CONSTANT_Class_Info的索引项            |      |      |          |
| index                 | u2                               | 指向名称及类型描述符CONSTANT_NameAndType的索引项             |      |      |          |
| 11                    | CONSTANT_InterfaceMethodref_info | 接口中方法的符号引用                                         | tag  | u1   | 值为11   |
| index                 | u2                               | 指向声明方法的接口描述符CONSTANT_Class_Info的索引项          |      |      |          |
| index                 | u2                               | 指向名称及类型描述符CONSTANT_NameAndType的索引项             |      |      |          |
| 12                    | CONSTANT_NameAndType_info        | 字段或方法的符号引用                                         | tag  | u1   | 值为12   |
| index                 | u2                               | 指向该字段或方法名称常量项的索引                             |      |      |          |
| index                 | u2                               | 指向该字段或方法描述符常量项的索引                           |      |      |          |
| 15                    | CONSTANT_MethodHandle_info       | 表示方法句柄                                                 | tag  | u1   | 值为15   |
| reference_kind        | u1                               | 值必须在1-9之间，它决定了方法句柄的类型方法句柄类型的值表示方法句柄的字节码行为 |      |      |          |
| reference_index       | u2                               | 值必须是对常量池的有效索引                                   |      |      |          |
| 16                    | CONSTANT_MethodType_info         | 标志方法类型                                                 | tag  | u1   | 值为16   |
| descriptor_index      | u2                               | 值必须是对常量池的有效索引，常量池在该索引处的项必须是CONSTANT_Utf8_info结构，表示方法的描述符 |      |      |          |
| 18                    | CONSTANT_InvokeDynamic_info      | 表示一个动态方法调用点                                       | tag  | u1   | 值为18   |
| bootstrap_method_attr | u2                               | 值必须是对当前Class文件中引导方法表的bootstrap_methods[]数组的有效索引 |      |      |          |
| name_and_type_index   | u2                               | 值必须是对当前常量池的有效索引，常量池在该索引处的项必须是CONSTANT_NameAndType_Info结构，表示方法名和方法描述符 |      |      |          |

（索引:指向字符串常量池的某一项）



- 根据上图每个类型的描述可以知道每个类型是用来描述常量池中哪些内容（主要是字面量、符号引用）的。



- 如：CONSTANT_Integer_info 是用来描述常量池中字面量信息的，而且只是整型字面量信息。



- 标志为 15、16、18 的常量项类型是用来支持动态语言调用的（jdk 1.7 时加入）



- jdk 9 增加了模块化相关的两项类型，而 jdk 11 增加了动态常量。



细节说明：

- CONSTANT_Class_info 结构用于表示类或接口



- CONSTANT_Fieldref_info、CONSTANT_Methodref_info 和 CONSTANT_InterfaceMehodref_info 结构表示字段、方法和接口方法



- CONSTANT_String_info 结构用于表示 String 类型的常量对象



- CONSTANT_Integer_info 和 CONSTANT_Float_info表示 4 字节（int 和 float）的数值常量



- CONSTANT_Long_info 和 CONSTANT_Double_info结构表示 8 字节（long 和 double）的数值常量



- 在 Class 文件的常量池表中，所有的 8 字节常量均占两个表成员（项）的空间。
  如果一个 CONSTANT_Long_info 或  CONSTANT_Double_info 结构的项在常量池表中的索引位 n，则常量池表中下一个可用项的索引位为 n + 2，此时常量池表中索引为 n + 1 的项仍然有效但必须视为不可用的。



- CONSTANT_NameAndType_info 结构用于表示字段或方法，但是和之前的 3 个结构不同，它没有指明该字段或方法所属的类或接口。



- CONSTANT_Utf8_info 用于表示字符常量的值



- CONSTANT_MethodHandle_info 结构用于表示方法句柄



- CONSTANT_MethodType_info 结构表示方法类型



- CONSTANT_InvokeDynamic_info 结构用于表示 invokedynamic 指令所用到的引导方法（bootstrap method）、引导方法所用到的动态调用名称（dynamic invocation name）、参数和返回类型，并可以给引导方法传入一系列称为静态参数（static argument）的常量。



解析方式：

- 一个字节一个字节地解析



- 使用 javap 命令解析：javap -verbose Demo.class 或 jclasslib 工具



总结1:

- 这 14 中表（或者常量项结构）的共同点是：表开始的第一位是一个 u1 类型的标志位（tag），代表当前这个常量项使用的是哪种表结构，即哪种常量类型。



- 在常量池列表中，CONSTANT_Utf8_info 常量项是一种使用改进过的 UTF-8 编码格式来存储诸如文字字符串、类或接口的全限定名、字段或方法的简单名称以及描述符等常量字符串信息。



- 这 14 中常量项结构还有一个特点是，其中 13 个常量项占用的字节固定，只有 CONSTANT_Utf8_info 占用字节不固定，其大小由 length 决定。因为从常量池存放的内容可知，其存放的是字面量和符号引用，最终这些内容都会是一个字符串，这些字符串的大小是在编写程序时才确定。比如定义一个类，类名可以取长取短，在没编译前，大小不固定，编译后，通过 utf-8 编码，就可以知道其长度。



总结2:

- 常量池：可以理解为 Class 文件之中的资源仓库，它是 Class 文件结构中与其他项目关联最多的数据类型（后面的很多数据类型都会指向此处），也是占用 Class 文件空间最大的数据项目之一。



- 常量池中为什么要包含这些内容？

- - Java 代码在进行 javac 编译时，并不像 C / C++ 那样有“连接”这一步骤，而是在虚拟机加载 Class 文件的时候进行动态链接。也就是说，在 Class 文件中不会保存各个方法、字段的最终内存布局信息，因此这些字段、方法的符号引用不经过运行期转换的话无法得到真正的内存入口地址，也就无法直接被虚拟机使用。
  - 当虚拟机运行时，需要从常量池获得对应的符号引用，再在类创建时或运行时解析、翻译到具体的内存地址中。（关于类的创建和动态链接内容，在后续虚拟机类加载过程时再细讲。）

------

## 访问标识（access_flag、访问标志、访问标记）

- 在常量池后，紧跟着访问标记。该标记使用两个字节 u2 表示，用于识别一些类或接口层次的访问信息。包括：该 Class 是类还是接口；是否定义为 public 类型；是否定义为 abstract 类型；如果是类的话，是否被声明为 final 等，各种访问标记如下表所示：

（所有类都是标志值是一个相加的十六进制数，如果标记值是21，说明该标志是public类型的）

| 标志名称       | 标志值 | 含义                                                         |
| -------------- | ------ | ------------------------------------------------------------ |
| ACC_PUBLIC     | 0x0001 | 标志为public类型                                             |
| ACC_FINAL      | 0x0010 | 标志被声明为final，只有类可以设置                            |
| ACC_SUPER      | 0x0020 | 标志允许使用invokespecial字节码指令的新语义，JDK1.0.2之后编译出来的类的这个标志默认为真。（使用增强的方法调用父类方法） |
| ACC_INTERFACE  | 0x0200 | 标志这是一个接口                                             |
| ACC_ABSTRACT   | 0x0400 | 是否为abstract类型，对于接口或者抽象类来说，次标志值为真，其他类型为假 |
| ACC_SYNTHETIC  | 0x1000 | 标志此类并非由用户代码产生（即：由编译器产生的类，没有源码对应） |
| ACC_ANNOTATION | 0x2000 | 标志这是一个注解                                             |
| ACC_ENUM       | 0x4000 | 标志这是一个枚举                                             |



- 类的访问权限通常为 ACC_开头的常量



- 每一种类型的表示都是通过设置访问标记的 32 位中的特定位来实现的。如，若是 public final 的类，则该标记位 ACC_PUBLIC | ACC_FINAL。



- 使用 ACC_SUPER 可以让类更准确地定位到父类的方法 super.method()，现代编译器都会设置并使用这个标记。



**补充说明：**

- 带有 ACC_INTERFACE 标志的 Class 文件表示的是接口而不是类，反之则表示的是类而不是接口。

- - 如果一个 Class 文件被设置了 ACC_INTERFACE 标志，那么同时也得设置 ACC_ABSTRACT 标志。并且不能再设置 ACC_FINAL、ACC_SUPER 或 ACC_ENUM 标志。
  - 如果没有设置 ACC_INTERFACE 标志，那么这个 Class 文件可以具有上表中除 ACC_ANNOTATION外的其他所有标志。当然，ACC_FINAL 和 ACC_ABSTRACT 这类互斥的标志除外。这两个标志不能同时设置。



- ACC_SUPER 标志用于确定类或接口里面的 invokespecial 指令使用的是哪一种执行语义。针对 Java 虚拟机指令集的编译器都应当设置这个标志。对于 Java SE 8 及后续版本来说，无论 Class 文件中这个标志的实际值是什么，也不管 Class 文件的版本号是多少，Java 虚拟机都认为每个 Class 文件均设置了 ACC_SUPER 标志。

- - ACC_SUPER 标志是为了向后兼容由旧 Java 编译器所编译的代码而设计的。目前的 ACC_SUPER 标志在由 JDK 1.0.2 之前的编译器所生成的 access_flags 中是没有确定含义的，如果设置了该标志，那么 Oracle 的 Java 虚拟机实现会将其忽略。



- ACC_SYNTHETIC 标志意味着该类或接口是由编译器生成的，而不是由源代码生成的。



- 注解类型必须设置 ACC_ANNOTATION 标志。如果设置了 ACC_ANNOTATION 标志，那么也必须设置 ACC_INTERFACE 标志。



- ACC_ENUM标志表明该类或其父类为枚举类型。



- 表中没有使用的access_flags标志是为未来扩充而预留的，这些预留的标志在编译器中应该设置为0，Java虚拟机实现也应该忽略它们。

------

## 类索引、父类索引、接口索引集合

在访问标记后，会指定该类的类别、父类类别以及实现的接口，格式如下：

| 长度 | 含义                         |
| ---- | ---------------------------- |
| u2   | this_class                   |
| u2   | super_class                  |
| u2   | interfaces_count             |
| u2   | interfaces[interfaces_count] |

这三项数据来确定这个类的继承关系

- 类索引用于确定这个类的全限定名



- 父类索引用于确定这个类的父类的全限定名。由于 Java 语言不允许多重继承，所以父类索引只有一个，除了 java.lang.Object之外，所有的 Java 类都有父类，因此除了 java.lang.Object外，所有 Java 类的父类索引都不为 0。



- 接口索引集合就用来描述这个类实现了哪些接口，这些被实现的接口将按 implements语句（如果该类本身是一个接口，则是 extends 语句）后的接口顺序从左到右排列在接口索引集合中。



**this_class（类索引）**

- 2 字节无符号整数，指向常量池的索引。它提供了类的全限定类名，如 com/java/Demo。this_class 的值必须是对常量池表中某项的一个有效索引值。常量池在这个索引处的成员必须为 CONSTANT_Class_info 类型结构体，该结构体表示这个 Class 文件所定义的类或接口。



**super_class（父类索引）**

- 2 字节无符号整数，指向常量池的索引。它提供了当前类的父类的全限定名。如果没有继承任何类，其默认继承的是 java/lang/Object 类。同时，由于 Java 不支持多继承，所以其父类只有一个。
- super_class 指向的父类不能是 final



**interfaces**

- 指向常量池索引集合，它提供了一个符号引用到所有已实现的接口



- 由于一个类可以实现多个接口，因此需要以数组形式保存多个接口的索引，表示接口的每个索引也是一个指向常量池的CONSTANT_Class（必须是接口）



- interfaces_count（接口计数器）

- - interfaces_count 项的值表示当前类或接口的直接超接口数量。



- interfaces [ ]（接口索引集合）

- - interfaces [ ] 中每个成员的值必须是对常量池表中某项的有效索引值，它的长度为interfaces_count。 每个成员 interfaces [i] 必须为 CONSTANT_Class_info 结构，其中 0 <= i < interfeaces_count。在 interfaces [ ] 中，各成员所表示的接口顺序和对应的源代码中给定的接口顺序（左至右）一样，即interfaces[0] 对应的是源代码中最左边的接口。

------

## 字段表集合

**fields**

- 用于描述接口或类中声明的变量。字段（field）包括类级变量及实例级变量，但不包括方法内部、代码块内部声明的局部变量(local variables)。



- 字段的名字、字段被定义的数据类型，这些都是无法固定的，只能引用常量池中的常量来描述。



- 它指向常量池索引集合，它描述了每个字段的完整信息。比如字段的标识符、访问修饰符（public、private 或 protected）、是类变量还是实例变量（static 修饰符）、是否是常量（final 修饰符）等。



**注意事项：**

- 字段表集合中不会列出从父类或实现的接口中继承而来的字段，但有可能列出原本 Java 代码中不存在的字段。比如在内部类中为了保持对外部类的访问性，会自动添加指向外部类实例的字段。



- 在 Java 语言中字段是无法重载的，两个字段的数据类型、修饰符不管是否相同，都必须使用不一样的名称，但对于字节码来讲，如果两个字段的描述符不一样，那字段重名就是合法的。 



### 字段计数器

- fields_count（字段计数器）



- fields_count 的值表示当前 Class 文件 fields 表的成员个数，使用两个字节来表示。



- fields 表中每个成员都是一个 field_info 结构，用于表示该类或接口所声明的所有类字段或者实例字段，



- 不包括方法内部声明的变量，也不包括从父类或父接口继承的字段。



### fields []（字段表）

- fields 表中的每个成员都必须是一个 fields_info 结构的数据项，用于表示当前类或接口中某个字段的完整描述。



- 一个字段的信息包括如下这些信息，这些信息中，各个修饰符都是布尔值，要么有，要么没有。

- - 作用域（public、private、protected 修饰符）
  - 是实例变量还是类变量（static 修饰符）

- - 可变性（final）
  - 并发可见性（volatile 修饰符，是否强制从主内存读写）

- - 可否序列化（transient 修饰符）
  - 字段数据类型（基本数据类型、对象、数组）

- - 字段名称



**字段表结构：**

- 字段表作为一个表，同样拥有自己的结构

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617589960453-63ce71a7-de35-4824-8fcf-3b264f1cecca.png)



**字段表访问标识:**

- 一个字段可以被各种关键字去修饰，比如：作用域修饰符（public、private、protected）、static 修饰符、final 修饰符、volatile 修饰符等等。因此，其可像类的访问标志那样，使用一些标志来标记字段。字段的访问标志有如下这些：

| 标志名称      | 标志值 | 含义                       |
| ------------- | ------ | -------------------------- |
| ACC_PUBLIC    | 0x0001 | 字段是否为public           |
| ACC_PRIVATE   | 0x0002 | 字段是否为private          |
| ACC_PROTECTED | 0x0004 | 字段是否为protected        |
| ACC_STATIC    | 0x0008 | 字段是否为static           |
| ACC_FINAL     | 0x0010 | 字段是否为final            |
| ACC_VOLATILE  | 0x0040 | 字段是否为volatile         |
| ACC_TRANSTENT | 0x0080 | 字段是否为transient        |
| ACC_SYNCHETIC | 0x1000 | 字段是否为由编译器自动产生 |
| ACC_ENUM      | 0x4000 | 字段是否为enum             |



**字段名索引:**

- 根据字段名索引的值，查询常量池中的指定索引项即可。

**描述符索引:**

- 描述符的作用是用来描述字段的数据类型、方法的参数列表（包括数量、类型以及顺序）和返回值。根据描述符规则，基本数据类型（byte、char、double、float、int、long、short、boolean）及代表无返回值的 void 类型都用一个大写字符来表示，而对象则用字符 L 加对象的全限定名来表示，如下所示 

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617590310814-85878a37-288d-4ba8-a608-6f99c34e586f.png)



**属性表集合**

- 一个字段还可能拥有一些属性，用于存储更多的额外信息。比如初始化值（常量）、一些注释信息等。属性个数存放在 attribute_count 中，属性具体内容存放在 attributes 数组中

以常量属性为例，结构为：

```
ConstantValue_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 constantvalue_index;
}
```

说明：对于常量属性而言，attribute_length 值恒为 2

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617590602290-b121d746-4623-4e59-94b6-ef2b01024cff.png)

------

## 方法表集合

methods：指向常量池索引集合，它完整描述了每个方法的签名

- 在字节码文件中，每一个 method_info 项都对应着一个类或者接口中的方法信息。比如方法的访问修饰符（public、private 或 protected），方法的返回值类型以及方法的参数信息等



- 如果这个方法不是抽象的或者不是 native 的，那么字节码中会体现出来



- 一方面，methods 表只描述当前类或接口中声明的方法，不包括从父类或父接口继承的方法。另一方面，methods 表有可能会出现由编译器自动添加的方法，最典型的便是编译器产生的方法信息(比如：类（接口）初始化方法 () 和实例初始化方法()）



**注意事项**

- 在 Java 语言中，要重载（Overload）一个方法，除了要与原方法具有相同的简单名称之外，还要求必须拥有一个与原方法不同的特征签名。



- 特征签名就是一个方法中各个参数在常量池中的字段符号引用的集合，也就是因为返回值不会包含在特征签名之中，因此 Java 语言里无法仅仅依靠返回值的不同来对一个已有方法进行重载。但在 Class 文件格式中，特征签名的范围更大一些，只要描述符不是完全一致的两个方法就可以共存。也就是说，如果两个方法有相同的名称和特征签名，但返回值不同，那么也是可以合法共存于同一个 Class 文件中。



- 也就是说，尽管 Java 语法规范并不允许在一个类或者接口中声明多个方法签名相同的方法，但是和 Java 语法规范相反，字节码文件中却恰恰允许存放多个方法签名相同的方法，唯一的条件就是这些方法之间的返回值不能相同。



**方法计数器**

- methods_count（方法计数器）
- methods_count 的值表示当前 Class 文件 methods 表的成员个数，使用两个字节来表示

- methods 表中每个成员都是一个 method_info 结构



**methods []（方法表）**

- methods 表中的每个成员都必须是一个 method_info 结构，用于表示当前类或接口中某个方法的完整描述。如果某个 method_info 结构的 access_flags 项既没有设置 ACC_NATIVE 标志也没有设置 ACC_ABSTRACT 标志，那么该结构中也应包含实现这个方法所有的 Java 虚拟机指令



- method_info 结构可以表示类和接口中定义的所有方法，包括实例方法、类方法、实例初始化方法和类或接口初始化方法



- 方法表的结构实际跟字段表是一样的，方法表结构如下：

  ![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617591188687-97d2509d-48bd-4e19-b776-9f443d40d3af.png)

方法表访问标志

- 跟字段表一样，方法表也有访问标志，而且他们的标志有部分相同，部分则不同，方法表的具体访问标志如下：

  ![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617591281428-df67ea09-3b05-4100-86dd-48dcda877648.png)

------

## 属性表集合

- 方法表集合之后的属性表集合，指的是 Class 文件所携带的辅助信息。比如该 Class 文件的源文件的名称，以及任何带有 RetentionPolicy.CLASS 或者 RetentionPolicy.RUNTIME的注解。这类信息通常被用于 Java 虚拟机的验证和运行，以及 Java 程序的调试，一般无需深入了解。



- 此外，字段表、方法表都可以有自己的属性表。用于描述某些场景专有的信息。



- 属性表集合的限制没有那么严格，不再要求各个属性表具有严格的顺序，并且只要不与已有的属性名重复，任何人实现的编译器都可以向属性表中写入自己定义的属性信息，但 Java 虚拟机运行时会忽略掉它不认识的属性。



**attributes_count（属性计数器）**

- attributes_count 的值表示当前 Class 文件属性表的成员个数。属性表中每一项都是一个attribute_info 结构。



**attributes [ ]（属性表）**

- 属性表的每个项的值必须是 attribute_info 结构。属性表的结构比较灵活，各种不同的属性只要满足以下结构即可。



**属性的通用格式**

| 类型 | 名称                 | 数量             | 含义       |
| ---- | -------------------- | ---------------- | ---------- |
| u2   | attribute_name_index | 1                | 属性名索引 |
| u4   | attribute_length     | 1                | 属性长度   |
| u1   | info                 | attribute_length | 属性表     |

即只需说明属性的名称以及占用位数的长度即可，属性表具体的结构可以去自定义。



**属性类型**

- 属性表实际上可以有很多类型，上面看到的 Code 属性只是其中一种， Java 8 里面定义了23种属性

下面这些是虚拟机中预定义的属性：

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617592461799-b9a981a8-64a4-4fc2-869c-71b3756e5e8f.png)

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617592479512-323bfcec-a8d3-41bb-83bb-58185e54a946.png)



**部分属性详解：**

**ConstantValue 属性**

- ConstantValue 属性表示一个常量字段的值。位于 field_info 结构的属性表中。

```
ConstantValue_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
    u2 constantvalue_index; //字段值在常量池中的索引，常量池在该索引处的项给出该属性表示的常量值。
//(例如，值是 long 型的，在常量池中便是 CONSTANT_Long)
}
```



**Deprecated 属性**

- Deprecated 属性是在 JDK 1.1 为了支持注释中的关键词 @deprecated 而引入的。

```
Deprecated_attribute {
    u2 attribute_name_index;
    u4 attribute_length;
}
```



**Code 属性**

- Code 属性就是存放方法体里面的代码，但是，并非所有方法表都有 Code 属性，像接口或者抽象方法，他们没有具体的方法体，因此也就不会有 Code 属性了。
- Code 属性表的结构，如下： 

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617592610859-328ec3cc-084e-4011-98a8-ae1d50f9f7f2.png)

可以看到：Code 属性表的前两项跟属性表是一致的，即 Code 属性表遵循属性表的结构，后面那些则是他自定义的结构。 



**InnerClasses 属性**

- 为了方便说明特别定义一个表示类或接口的 Class 格式为 C。如果 C 的常量池中包含某个 CONSTANT_Class_info 成员，且这个成员所表示的类或接口不属于任何一个包，那么 C 的 ClassFile 结构的属性表中就必须含有对应的 InnerClasses 属性。
- InnerClasses 属性是在 JDK 1.1 中为了支持内部类和内部接口而引入的，位于 ClassFile 结构的属性表。



**LineNumberTable 属性**

- LineNumberTable 属性是可选变长属性，位于 Code 结构的属性表。



- LineNumberTable 属性是用来描述 Java 源码行号与字节码行号之间的对应关系，这个属性可以用来在调试的时候定位代码执行的行数。

- - start_pc，即字节码行号；line_number，即 Java 源代码行号



- 在 Code 属性的属性表中，LineNumberTable 属性可以按照任意顺序出现，此外，多个 LineNumberTable 属性可以共同表示一个行号在源文件中表示的内容，即 LineNumberTable 属性不需要与源文件的行一一对应。



- LineNumberTable 属性表结构：

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617593683017-46274965-32d9-463c-89fb-5a38979e411c.png)



**LocalVariableTable 属性**

LocalVariableTable 是可选变长属性，位于 Code 属性的属性表中。它被调试器用于确定方法在执行过程中局部变量的信息。

在 Code 属性的属性中，LocalVariableTable 属性可以按照任意顺序出现。Code 属性中的每个局部变量最多只能有一个 LocalVariableTable 属性。

- start_pc + length 表示这个变量在字节码中的生命周期起始和结束的偏移位置（this 生命周期从头 0 到结尾 10）
- index 就是这个变量在局部变量表中的槽位（槽位可复用）

- name 就是变量名称
- Descriptor 表示局部变量类型描述

LocalVariableTable 属性表结构：

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617593712734-a10193f5-40da-4ddd-bb60-9cdff689a8e2.png)



**Signature 属性**

- Signature 属性是可选的定长属性，位于 ClassFile，field_info 或 method_info 结构的属性表中。
- 在 Java 语言中，任何类、接口、初始化方法或成员的泛型签名如果包含了类型变量（Type Variables）或参数化类型（Parameterized Types），则 Signature 属性会为它记录泛型签名信息。



**SourceFile 属性**

SourceFile 属性结构

![img](https://cdn.nlark.com/yuque/0/2021/png/12731578/1617609740934-86b1c83c-c6c2-4f35-b6bd-9cb66daf9b4b.png)

在官网可以看到,其长度总是固定的8个字节。



**其他属性**

Java虚拟机中预定义的属性有20多个，这里就不一一介绍了，通过上面几个属性的介绍，

只要领会其精髓，其他属性的解读也是易如反掌。



## 小结

- 本章主要介绍了 Class 文件的基本格式。



- 随着 Java 平台的不断发展，在将来，Class 文件的内容也一定会做进一步的扩充，但是其基本的格式和结构不会做重大调整。



- 从 Java 虚拟机的角度看，通过 Class 文件，可以让更多的计算机语言支持 Java 虚拟机平台。因此，Class 文件结构不仅仅是 Java 虚拟机的执行入口，更是 Java 生态圈的基础和核心。