---
 
typora-root-url: ./
typora-copy-images-to: upload
---



## JVM

### 1. Java为什么能一次编写，处处运行?

高级语言按照程序执行方式可以分为两种：编译型、解释型。1.编译型语言使用专门的编译器，针对特定平台，将源代码一次性“翻译”成为可在该平台执行的机器码，例如C 、C++。2.解释型语言使用专门的解释器将源代码逐行解释成特定平台的机器码并立即执行，例如Python，Ruby。

Java是一种特殊的高级语言，Java程序的执行过程必须经过先编译、后解释两个步骤。先简要说一下Java程序执行过程：首先Java源文件被便以为字节码文件，然后由JVM解释执行。

Java编译产生的不是针对特定平台的机器码，而是一种与平台无关的字节码文件（即*.class文件）。相同的字节码在不同平台上直接运行原本是不可能的，但通过中间的转换器实现了“一次编译，到处运行”的效果，JVM就是这个转换器。不同平台上的JVM是不同的，但他们提供给Java字节码程序的接口是完全相同的。因此，这些字节码不面向任何平台，只面向JVM，也就是说，JVM充当了中介或者叫做翻译的角色。

### 2. JVM是什么?

Java程序的跨平台特性主要是指字节码文件可以在任何具有Java虚拟机的计算机或者电子设备上运行，Java虚拟机中的Java解释器负责将字节码文件解释成为特定的机器码进行运行。

1. Java虚拟机是一台执行Java字节码的虚拟计算机，它拥有独立的运行机制，其运行的<font color='red'>Java字节码也未必由Java语言编译而成</font>。（只要遵循java虚拟机规范的字节码指令要求都可解释运行）
2. JVM平台的各种语言可以共享Java虚拟机带来的跨平台性、优秀的垃圾回器，以及可靠的即时编译器。

3. <font color='red'>Java技术的核心就是Java虚拟机</font>（JVM，Java  Virtual Machine），因为所有的Java程序都运行在Java虚拟机内部。

Java虚拟机就是<font color='red'>二进制字节码的运行环境</font>，负责装载字节码到其内部，解释/编译为对应平台上的机器指令执行。每一条Java指令，Java虚拟机规范中都有详细定义，如怎么取操作数，怎么处理操作数，处理结果放在哪里。

特点：

1. 一次编译，到处运行
2. 自动内存管理
3. 自动垃圾回收功能

### 3. HotSpot 是什么?

​	HotSpot VM，是Sun JDK和OpenJDK中所带的虚拟机，也是目前使用范围最广的Java虚拟机。名称中的HotSpot指的就是它的热点代码探测技术。

### 4. JVM 内存区域分类哪些?

类加载器，运行时数据区（java栈，本地方法栈、程序计数器、堆、方法区），执行引擎

### 5. 堆和栈区别是什么?

**各司其职**

最主要的区别就是栈内存用来存储局部变量和方法调用。而堆内存用来存储Java中的对象。无论是成员变量，局部变量，还是类变量，它们指向的对象都存储在堆内存中。

**独有还是共享**

栈内存归属于单个线程，每个线程都会有一个栈内存，其存储的变量只能在其所属线程中可见，即栈内存可以理解成线程的私有内存。而堆内存中的对象对所有线程可见。堆内存中的对象可以被所有线程访问。

**异常错误**

如果栈内存没有可用的空间存储方法调用和局部变量，JVM会抛出java.lang.StackOverFlowError。而如果是堆内存没有可用的空间存储生成的对象，JVM会抛出java.lang.OutOfMemoryError。

**空间大小**

栈的内存要远远小于堆内存，如果你使用递归的话，那么你的栈很快就会充满。如果递归没有及时跳出，很可能发生StackOverFlowError问题。你可以通过-Xss选项设置栈内存的大小。-Xms选项可以设置堆的开始时的大小，-Xmx选项可以设置堆的最大值。

这就是Java中堆和栈的区别。理解好这个问题的话，可以对你解决开发中的问题，分析堆内存和栈内存使用，甚至性能调优都有帮助。

**查看默认值(Updated)** 

查看堆的默认值，使用下面的代码，其中InitialHeapSize为最开始的堆的大小，MaxHeapSize为堆的最大值。

 ![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/918723-20190305235205825-627752724.png)

查看栈的默认值,其中ThreadStackSize为栈内存的大小。

 ![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/918723-20190305235230716-560860090.png)

### 6. JVM哪块内存区别不会发生内存溢出?

程序计数器

### 7.什么情况下会发生栈内存溢出?

-Xss可以设置线程栈的大小，当线程方法递归调用层次太深或者栈帧中的局部变量过多时，会出现栈溢出错误 java.lang.StackOverflowError

### 8.对象都是在堆上分配的吗?

不一定。随着JIT编译器的发展，在编译期间，如果JIT经过逃逸分析，没有发生线程逃逸则支持栈上分配，没有发生方法逃逸则支持标量替换，对象可以在栈上分配，但不是一定会发生。

### 9.怎么在运行时动态生成一个类?

在加载阶段，Java虚拟机需要完成以下三件事情： 

1. 通过一个类的全限定名来获取定义此类的二进制字节流。 
2. 将这个字节流所代表的静态存储结构转化为方法区的运行时数据结构。 
3. 在内存中生成一个代表这个类的java.lang.Class对象，作为方法区这个类的各种数据的访问入口。

《Java虚拟机规范》对这三点要求其实并不是特别具体，留给虚拟机实现与Java应用的灵活度都是 相当大的。例如“通过一个类的全限定名来获取定义此类的二进制字节流”这条规则，它并没有指明二 进制字节流必须得从某个Class文件中获取，确切地说是根本没有指明要从哪里获取、如何获取。仅仅这一点空隙，Java虚拟机的使用者们就可以在加载阶段搭构建出一个相当开放广阔的舞台，Java发展历 程中，充满创造力的开发人员则在这个舞台上玩出了各种花样，许多举足轻重的Java技术都建立在这一基础之上，例如： 

- 从ZIP压缩包中读取class文件，这很常见，最终成为日后JAR、EAR、WAR格式的基础。 
- 从网络中获取，这种场景最典型的应用就是Web Applet。 
- 运行时计算生成，这种场景使用得最多的就是动态代理技术，在java.lang.reflect.Proxy中，就是用 了ProxyGenerator.generateProxyClass()来为特定接口生成形式为“*$Proxy”的代理类的二进制字节流。 
- 由其他文件生成，典型场景是JSP应用，由JSP文件生成对应的Class文件。 
- 从数据库中读取，这种场景相对少见些，例如有些中间件服务器（如SAP Netweaver）可以选择把程序安装到数据库中来完成程序代码在集群间的分发。 
- 可以从加密文件中获取，这是典型的防Class文件被反编译的保护措施，通过加载时解密Class文 件来保障程序运行逻辑不被窥探。 

在获取到类的二进制信息后，Java 虚拟机就会处理这些数据，并最终转为一个 java.lang.Class 的实例

如果输入数据不是 ClassFile 的结构，则会抛出 ClassFormatError

![类的生命周期](https://note-java.oss-cn-beijing.aliyuncs.com/img/image.png)

### 10.String str="R";创建了几个对象?

1. 如果 String 常量池中已经创建了 "R"，此时创建了 0 个对象；

2. 如果 String 常量池中没有创建 "R"，此时在常量池中创建了 1 个对象。

### 11.new String（"R"）创建了几个对象?

1. 如果 String 常量池中已经创建了 "R"，此时创建了 1 个对象；

2. 如果 String 常量池中没有创建 "R"，此时在常量池中创建了 2 个对象。

### 12.判断两个字符串是否相等

使用“=”比较两个字符串，是比较两个对象的的“地址”是否一致，本质就是判断两个变量是否指向同一个对象，如果是则返回true，否则返回的是false。而String类的equals方法则是比较两个字符串的内容是否一致，返回值也是一个布尔类型。

### 13.String.intern（） 方法有什么用?

String::intern方法是一个本地方法。作用：如果字符串常量池中已经包含一个等于此对象的字符串，则返回代表<font color='red'>池中这个字符串的String对象的引用</font>；否则，会将此String对象包含的字符串添加到常量池中，并且返回<font color='red'>此String对象的引用</font>。

### 14.你怎么理解强、软、弱、虚引用?

- 强引用，就是普通的对象引用关系，如 String s = new String("ConstXiong")
- 软引用，用于维护一些可有可无的对象。只有在内存不足时，系统则会回收软引用对象，如果回收了软引用对象之后仍然没有足够的内存，才会抛出内存溢出异常。SoftReference 实现
- 弱引用，相比软引用来说，要更加无用一些，它拥有更短的生命周期，当 JVM 进行垃圾回收时，无论内存是否充足，都会回收被弱引用关联的对象。WeakReference 实现
- 虚引用是一种形同虚设的引用，在现实场景中用的不是很多，它主要用来跟踪对象被垃圾回收的活动。PhantomReference 实现

### 15.常用的 JVM 参数有哪些?

- -Xms:初始大小内存，默认为物理内存的1/64等价于-XX:InitialHeapSize

- -Xmx:最大分配内存，默认为物理内存的1/4等价于-XX:MaxHeapSize
- -Xss:设置单个线程栈的大小，一般默认为512k~1024k等价于-XX:ThreadStackSize。当值等于0的时候，代表使用得是默认大小
- -Xmn：设置年轻代大小
- -XX:MetaspaceSize：设置元空间大小（元空间与永久代最大的区别为：元空间并不在虚拟机中，而使用的是本地内存，因此，元空间只收本地内存的限制）手动设置：-XX：MetaspaceSize=1024m
- -XX：+PrintGCDetails：输出详细GC收集日志信息

### 16.Java 8中的内存结构有什么变化?

使用元空间取代永久代

### 17.Java 8中的永久代为什么被移除了?

- 永久代空间大小很难确定，存在OOM。
  - 在某些场景下，如果动态加载类过多，容易产生Perm区的OOM。比如某个实际Web工程中，因为功能点比较多，在运行过程中，要不断动态加载很多类，经常出现致命错误。`Exception in thread 'dubbo client x.x connector' java.lang.OutOfMemoryError:PermGen space`
  - 而元空间和永久代之间最大的区别在于：元空间并不在虚拟机中，而是使用本地内存。 因此，默认情况下，元空间的大小仅受本地内存限制。
- 永久代调优困难。
  - 方法区的垃圾收集主要回收两部分内容：常量池中废弃的常量和不再用的类型，方法区的调优主要是为了降低Full GC

### 18. 什么是类加载器?

实现通过类的权限定名获取该类的二进制字节流的代码块叫做类加载器。		

类加载器（ClassLoader）用来加载Java类到Java虚拟机中。

一般来说，java虚拟机使用Java类的方式如下：

1、Java源程序（.java文件）在经过java编译器编译之后就被转换成Java字节代码（.class文件）

2、类加载器负责通过类的权限定名读取 Java class类 字节码，并转换成`java.lang.Class` 类的一个实例

基本上所有类加载器都是 `java.lang.ClassLoader`类的一个实例，除了 引导类加载器（启动类加载器）

24. ### 类加载器（ClassLoader）有哪些方法?

| 方法名称                                            | 描述                                                         |
| --------------------------------------------------- | ------------------------------------------------------------ |
| `getParent()`                                       | 返回该类加载器的超类加载器                                   |
| `loadClass(String name)`                            | 加载名称为name的类，返回结果为java.lang.Class的实例          |
| `findClass(String name)`                            | 查找名称为name的类，返回结果为java.lang.Class的实例          |
| `findLoadClass(String name)`                        | 查找名称为name的已经被加载过的类，返回结果为java.lang.Class的实例 |
| `defineClass(String name,byte[] b,int off,int len)` | 把字节数据b中的内容转换为一个Java类，返回结构为java.lang.Class类的实例 |
| `resolveClass(Class<?> c)`                          | 返回指定的一个Java类                                         |

### 19.类加载器的分类及作用?

**启动类加载器**（引导类加载器，Bootstrap ClassLoader）

- 这个类加载使用<font color='red'>C/C++</font>语言实现的，嵌套在JVM内部
- 它用来加载Java的核心库（JAVA_HOME/jre/lib/rt.jar、resources.jar或sun.boot.class.path路径下的内容），用于提供JVM自身需要的类

- 并不继承自java.lang.ClassLoader，没有父加载器
- 加载扩展类和应用程序类加载器，并作为他们的父类加载器

- 出于安全考虑，Bootstrap启动类加载器只加载包名为java、javax、sun等开头的类
- 可以通过启动jvm时指定`-Xbootclasspath`和路径来改变Bootstrap ClassLoader的加载目录。比如`java -Xbootclasspath/a:path`被指定的文件追加到默认的bootstrap路径中。我们可以打开我的电脑，在上面的目录下查看，看看这些jar包是不是存在于这个目录。

**扩展类加载器**（Extension ClassLoader）

- Java语言编写，由sun.misc.Launcher$ExtClassLoader实现
- 派生于ClassLoader类

- 父类加载器为启动类加载器
- 从java.ext.dirs系统属性所指定的目录中加载类库，或从JDK的安装目录的jre/lib/ext子目录（扩展目录）下加载类库。<font color='red'>如果用户创建的JAR放在此目录下，也会自动由扩展类加载器加载</font>
- 可以加载`-D java.ext.dirs`选项指定的目录

**应用程序类加载器**（也称为系统类加载器，AppClassLoader）

- <font color='red'>Java语言编写</font>，由sun.misc.Launchers$AppClassLoader实现
- 派生于ClassLoader类

- 父类加载器为扩展类加载器
- 它负责<font color='red'>加载环境变量classpath</font>或<font color='red'>系统属性java.class.path指定路径下的类库</font>

- 该类加载是程序中<font color='red'>默认的类加载器</font>，一般来说，Java应用的类都是由它来完成加载
- 通过classLoader.getSystemclassLoader()方法可以获取到该类加载器

### 20.什么是双亲委派模型?

1. 如果一个类加载器收到了类加载请求，它并不会自己先去加载，而是把这个请求委托给父类的加载器去执行；
2. 如果父类加载器还存在其父类加载器，则进一步向上委托，依次递归，请求最终将到达顶层的启动类加载器；
3. 如果父类加载器可以完成类加载任务，就成功返回，倘若父类加载器无法完成此加载任务，子加载器才会尝试自己去加载，这就是双亲委派模式。
4. 父类加载器一层一层往下分配任务，如果子类加载器能加载，则加载此类，如果将加载任务分配至系统类加载器也无法加载此类，则抛出异常

好处：

Java类随着它的类加载器一起具备了一种带有优先级的层次关系。例如类java.lang.Object，它存放在rt.jar中，无论哪一个类加载器要加载这个类，最终都是委派给处于模型最顶端的启动类加载器进行加载，因此Object类在程序的各种类加载器环境中都是同一个类。相反，如果没有使用双亲委派模型，由各个类加载器自行去加载的话，如果用户自己编写了一个称为java.lang.object的类，并放在程序的ClassPath中，那系统中将会出现多个不同的Object类，Java类型体系中最基础的行为也就无法保证，应用程序也将会变得一片混乱。

其次是考虑到安全因素。假设通过网络传递一个名为java.lang.Integer的类，通过双亲委托模式传递到启动类加载器，而启动类加载器在核心Java API发现这个名字的类，发现该类已被加载，并不会重新加载网络传递的过来的java.lang.Integer，而直接返回已加载过的Integer.class，这样便可以防止核心API库被随意篡改。

弊端：

检查类是否加载的委托过程是单向的，这个方式虽然从结构上说比较清晰，使各个ClassLoader的职责非常明确，但是同时会带来一个问题，即<font color="red">顶层的ClassLoader无法访问底层的ClassLoader所加载的类</font>。

通常情况下，启动类加载器中的类为系统核心类，包括一些重要的系统接口，而在应用类加载器中，为应用类。按照这种模式，应用类访问系统类自然是没有问题，但是系统类访问应用类就会出现问题。比如在系统类中提供了一个接口，该接口需要在应用类中得以实现，该接口还绑定一个工厂方法，用于创建该接口的实例，而接口和工厂方法都在启动类加载器中。这时，就会出现该工厂方法无法创建由应用类加载器加载的应用实例的问题。

### 21.为什么要打破双亲委派模型?

上层的ClassLoader无法访问下层的ClassLoader所加载的类

**破坏双亲委派机制1**

双亲委派模型并不是一个具有强制性约束的模型，而是Java设计者推荐给开发者们的类加载器实现方式。

在Java的世界中大部分的类加载器都遵循这个模型，但也有例外的情况，直到Java模块化出现为止，双亲委派模型主要出现过3次较大规模“被破坏”的情况。

第一次破坏双亲委派机制：

双亲委派模型的第一次“被破坏”其实发生在双亲委派模型出现之前--即JDK1.2面世以前的“远古”时代。

由于双亲委派模型在JDK 1.2之后才被引入，但是类加载器的概念和抽象类java.lang.ClassLoader则在Java的第一个版本中就已经存在，面对已经存在的用户自定义类加载器的代码，Java设计者们引入双亲委派模型时不得不做出一些妥协，<font color="red">为了兼容这些已有代码，无法再以技术手段避免loadClass()被子类覆盖的可能性</font>，只能在JDK1.2之后的java.lang.ClassLoader中添加一个新的protected方法findClass()，并引导用户编写的类加载逻辑时尽可能去重写这个方法，而不是在loadClass()中编写代码。上节我们已经分析过loadClass()方法，双亲委派的具体逻辑就实现在这里面，按照loadClass()方法的逻辑，如果父类加载失败，会自动调用自己的findClass()方法来完成加载，这样既不影响用户按照自己的意愿去加载类，又可以保证新写出来的类加载器是符合双亲委派规则的。

**破坏双亲委派机制2**

第二次破坏双亲委派机制：线程上下文类加载器

双亲委派模型的第二次“被破坏”是由这个模型自身的缺陷导致的，双亲委派很好地解决了各个类加载器协作时基础类型的一致性问题〈<font color="red">越基础的类由越上层的加载器进行加载</font>），基础类型之所以被称为“基础”，是因为它们总是作为被用户代码继承、调用的API存在，但程序设计往往没有绝对不变的完美规则，如果有基础类型又要调用回用户的代码,那该怎么办呢?

这并非是不可能出现的事情，一个典型的例子便是JNDI服务，JNDI（Java Naming and Directory Interface）现在已经是Java的标准服务，它的代码由启动类加载器来完成加载（在JDK 1.3时加入到rt.jar的)，肯定属于Java中很基础的类型了。但JNDI存在的目的就是对资源进行查找和集中管理，它需要调用由其他厂商实现并部署在应用程序的ClassPath下的NDI服务提供者接口（Service Provider Interface，SPI）的代码，现在问题来了，启动类加载器是绝不可能认识、加载这些代码的，那该怎么办?(SPI：在Java平台中，通常把核心类rt.jar中提供外部服务、可由应用层自行实现的接口称为SPI)

为了解决这个困境，Java的设计团队只好引入了一个不太优雅的设计：<font color="red">线程上下文类加载器（Thread ContextClassLoader)</font>。这个类加载器可以通过java.lang.Thread类的setContextClassLoader()方法进行设置，如果创建线程时还未设置，它将会从父线程中继承一个，如果在应用程序的全局范围内都没有设置过的话，那这个类加载器默认就是应用程序类加载器。

有了线程上下文类加载器，程序就可以做一些“舞弊”的事情了。JNDI服务使用这个线程上下文类加载器去加载所需的SPI服务代码，这是一种父类加载器去请求子类加载器完成类加载的行为，这种行为实际上是打通了双亲委派模型的层次结构来逆向使用类加载器，已经违背了双亲委派模型的一般性原则，但也是无可奈何的事情。Java中涉及SPI的加载基本上都采用这种方式来完成，例如NDI、JDBC、JCE、JAXB和BT等。不过，当SPI的服务提供者多于一个的时候，代码就只能根据具体提供者的类型来硬编码判断，为了消除这种极不优雅的实现方式，在JDK 6时，JDK提供了java.util.ServiceLoader类，以META-INF/services中的配置信息，辅以责任链模式，这才算是给SPI的加载提供了一种相对合理的解决方案。

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/0D36AFBC-A3F1-4572-B7E8-D8839DBEC7C6.png)

默认上下文加载器就是应用类加载器，这样以上下文加载器为中介，使得启动类加载器中的代码也可以访问应用类加载器中的类。

**破坏双亲委派机制3**

第三次破坏双亲委派机制：

双亲委派模型的第三次“被破坏”是由于用户对程序动态性的追求而导致的。如：<font color="red">代码热替换（Hot Swap)、模块热部署（Hot Deployment）</font>等

IBM公司主导的JSR-291(即OSGi R4.2）实现模块化热部署的关键是它自定义的类加载器机制的实现，每一个程序模块（OSGi中称为Bundle)都有一个自己的类加载器，当需要更换一个Bundle时，就把Bundle连同类加载器一起换掉以实现代码的热替换。在OSGi环境下，类加载器不再双亲委派模型推荐的树状结构，而是进一步发展为更加复杂的网状结构。

当收到类加载请求时，OSGi将按照下面的顺序进行类搜索：（不细讲）

1）<font color="red">将以java.*开头的类，委派给父类加载器加载。</font>

2）<font color="red">否则，将委派列表名单内的类，委派给父类加载器加载。</font>

3）否则，将Import列表中的类，委派给Export这个类的Bundle的类加载器加载。

4）否则，查找当前Bundle的ClassPath，使用自己的类加载器加载。

5）否则，查找类是否在自己的Fragment Bundle中，如果在，则委派给Fragment Bundle的类加载器加载。

6）否则，查找Dynamic Import列表的Bundle，委派给对应Bundle的类加载器加载。

7）否则，类查找失败。

说明：只有开头两点仍然符合双亲委派模型的原则，其余的类查找都是在平级的类加载器中进行的

小结：

这里，我们使用了“被破坏”这个词来形容上述不符合双亲委派模型原则的行为，但这里“被破坏”并不一定是带有贬义的。只要有明确的目的和充分的理由，突破旧有原则无疑是一种创新。

正如：OSGi中的类加载器的设计不符合传统的双亲委派的类加载器架构，且业界对其为了实现热部署而带来的额外的高复杂度还存在不少争议，但对这方面有了解的技术人员基本还是能达成一个共识，认为OSGi中对类加载器的运用是值得学习的，完全弄懂了OSGi的实现，就算是掌握了类加载器的精粹。

### 22.可以自定义一个java.lang.String吗?

不行。

自定义String类时：在加载自定义String类的时候会率先使用引导类加载器加载，而引导类加载器在加载的过程中会先加载 jdk 自带的文件（rt.jar包中java.lang.String.class），报错信息说没有main方法，就是因为加载的是rt.jar包中的String类。这样可以保证对java核心源代码的保护，这就是沙箱安全机制。

Java 安全模型的核心就是 Java 沙箱(Sandbox)。什么是沙箱？沙箱就是一个限制程序运行的环境

沙箱机制就是将 Java 代码限定在虚拟机(JVM)特定的运行范围中，并且严格限制代码对本地系统资源访问。通过这样的措施来保证对代码的有限隔离，防止对本地系统造成破坏

### 23.Class.forName和 ClassLoader的区别?

ClassLoader就是遵循双亲委派模型最终调用启动类加载器的类加载器，实现的功能是“通过一个类的全限定名来获取描述此类的二进制字节流”，获取到二进制流后放到JVM中，加载的类默认不会进行初始化。

Class.forName()方法实际上也是调用的ClassLoader来实现的，但是加载的类默认会进行初始化，也可以使用重载版本进行手动指定是否会进行初始化

> 参考：https://www.cnblogs.com/jimoer/p/9185662.html

### 24.一个类的静态块是否可能被加载多次?

正常情况下Class类通过双亲委派模型的类加载器只会被加载一次

但是可以通过指定不同的类加载器加载，实现类被加载多次，同时静态代码块也会被加载多次。

### 25.什么是 JVM内存模型?

JMM是和多线程相关的，他描述了一组规则或规范，这个规范定义了一个线程对共享变量的写入时对另一个线程是可见的。

《Java虚拟机规范》中曾试图定义一种“Java内存模型”（Java Memory Model，JMM）来屏蔽各种硬件和操作系统的内存访问差异，以实现让Java程序在各种平台下都能达到一致的内存访问效果。

它分为工作内存和主内存，线程无法对主存储器直接进行操作，如果一个线程要和另外一个线程通信，那么只能通过主存进行交换。

Java线程之间的通信由Java内存模型（本文简称为JMM）控制，JMM决定一个线程对共享变量的写入何时对另一个线程可见。从抽象的角度来看，JMM定义了线程和主内存之间的抽象关系：线程之间的共享变量存储在主内存（main memory）中，每个线程都有一个私有的本地内存（local memory），本地内存中存储了该线程以读/写共享变量的副本。本地内存是JMM的一个抽象概念，并不真实存在。它涵盖了缓存，写缓冲区，寄存器以及其他的硬件和编译器优化。

### 26.JVM内存模型和 JVM内存结构的区别?

- jvm 运行时内存结构和 java虚拟机运行时数据区域有关
- java 内存模型 和 java并发编程有关，三大特性：可见性、原子性、有序性。

### 27.什么是指令重排序?

普通的变量仅会保证在该方法的执行过程中所有依赖赋值结果的地方都能获取到正确的结果，而不能保证变量赋值操作的顺序与程序代码中的执行顺序一致。

单线程环境里面确保最终执行结果和代码顺序的结果一致

处理器在进行重排序时，必须要考虑指令之间的<font color='red'>数据依赖性</font>

多线程环境中线程交替执行，由于编译器优化重排的存在，两个线程中使用的变量能否保证一致性是无法确定的，结果无法预测。

### 28.内存屏障是什么?

内存屏障（Memory Barrier）又称内存栅栏，指 重排序时不能把后面的指令重排序到内存屏障之间的位置。 它是一个CPU指令，作用有两个：

- 保证特定操作的顺序
- 保证某些变量的内存可见性（利用该特性实现volatile的内存可见性）

由于编译器和处理器都能执行指令重排的优化，如果在指令间插入一条Memory Barrier则会告诉编译器和CPU，不管什么指令都不能和这条Memory Barrier指令重排序，也就是说<font color='red'>通过插入内存屏障禁止在内存屏障前后的指令执行重排序优化</font>。 内存屏障另外一个作用是刷新出各种CPU的缓存数，因此任何CPU上的线程都能读取到这些数据的最新版本。

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20200310162654437.png" alt="image-20200310162654437" style="zoom:150%;" />

也就是过在Volatile的写 和 读的时候，加入屏障，防止出现指令重排的

### 29.什么是Happens-Before原则?

先行发生是Java内存模型中定义的两项操作之间的偏序关系，比如说操作A先行发生于操作B，其实就是说在发生操作B之前，操作A产生的影响能被操作B观察到，“影响”包括修改了内存中共享变量的值、发送了消息、调用了方法等。

happens-before 关系是用来描述两个操作的内存可见性的。如果操作 X happens-before 操作 Y，那么 X 的结果对于 Y 可见。 

### 30.GC是什么?为什么需要 GC?

GC是垃圾收集的意思，内存处理是编程人员容易出现问题的地方，忘记或者错误的内存回收会导致程序或系统的不稳定甚至崩溃，Java提供的GC功能可以自动监测对象是否超过作用域从而达到自动回收内存的目的，Java语言没有提供释放已分配内存的显示操作方法。Java程序员不用担心内存管理，因为垃圾收集器会自动进行管理。要请求垃圾收集，可以调用下面的方法之一:

System.gc() 或Runtime.getRuntime().gc() 。

垃圾回收可以有效的防止内存泄露，有效的使用可以使用的内存。垃圾回收器通常是作为一个单独的低优先级的线程运行，不可预知的情况下对内存堆中已经死亡的或者长时间没有使用的对象进行清除和回收，程序员不能实时的调用垃圾回收器对某个对象或所有对象进行垃圾回收。回收机制有分代复制垃圾回收、标记垃圾回收、增量垃圾回收等方式。

### 31.什么是 MinorGC和 FullGC?

部分收集（Partial GC）：指目标不是完整收集整个Java堆的垃圾收集，其中又分为： 

- 新生代收集（Minor GC/Young GC）：指目标只是新生代的垃圾收集。 
- 老年代收集（Major GC/Old GC）：指目标只是老年代的垃圾收集。目前只有CMS收集器会有单独收集老年代的行为。另外请注意“Major GC”这个说法现在有点混淆，在不同资料上常有不同所指， 需按上下文区分到底是指老年代的收集还是整堆收集。 

- 混合收集（Mixed GC）：指目标是收集整个新生代以及部分老年代的垃圾收集。目前只有G1收集器会有这种行为。 

整堆收集（Full GC）：收集整个Java堆和方法区的垃圾收集。 

### 32.一次完整的 GC 流程是怎样的?

1. 新创建对象存放在eden区，eden区不足，GC 触发。
2. JDK 6 Update24 之前，Minor GC 触发前，JVM 必须先检查老年代最大可用的连续空间是否大于新生代所有对象总空间
   1. 是，那这一次 Minor GC 可以确保是安全的
   2. 否，JVM 会先查看 -XX:HandlePromotionFailure 参数的设置值是否允许担保失败
      - 允许，继续检查老年代最大可用的连续空间是否大于历次晋升到老年代对象的平均大小
        - 大于，尝试进行一次 Minor GC（有风险）
        - 小于，进行一次 Full GC
      - 不允许，进行一次 Full GC
3. JDK 6 Update24 之后，-XX:HandlePromotionFailure 参数不会再影响到虚拟机的空间分配担保策略。规则变为：只要老年代的连续空间大于新生代对象总大小或者历次晋升的平均大小，就会进行 Minor GC，否则将进行 Full GC。
4. 担保通过，Minor GC 之后
   1. eden 区空间足够，GC 结束结束①
   2. eden 区空间不足，尝试放入 survivor 区
      - survivor 区空间足够，GC 结束。②
      - survivor 区空间不够，直接晋升为老年代。
        - 老年代空间足够，GC结束 ③
        - 若老年代空间不足，进行一次 Full GC。FGC 之后老年代还放不下就报 OOM 了
5. 担保不通过，Full  GC 之后老年代还放不下就报 OOM

### 33.对象内存分配策略

**针对不同年龄段的对象分配原则如下所示：**

- 优先分配到Eden
- 大对象直接分配到老年代

  - 尽量避免程序中出现过多的大对象

- 长期存活的对象分配到老年代。默认阈值15
- <font color='red'>动态对象年龄判断</font>
  - 如果Survivor区中<font color='red'>相同年龄</font>的所有对象大小的总和大于Survivor空间的一半，年龄大于或等于该年龄的对象可以直接进入老年代，无须等到MaxTenuringThreshold中要求的年龄。

### 34.JVM 如何判断一个对象可被回收?

**引用计数算法**

在对象中添加一个引用计数器，每当有一个地方引用它时，计数器值就加一；当引用失效时，计数器值就减一；任何时刻计数器为零的对象就是不可能再被使用的，也就是可回收的。

难于处理循环引用关系。解决方法：<font color='red'>手动解除</font>：很好理解，就是在合适的时机，解除引用关系；<font color='red'>使用弱引用weakref</font>，发生 GC 即回收。

**可达性分析算法**

通过一系列“GC Roots”根对象作为起始节点集，从这些节点开始，根据引用关系向下搜索，搜索过程所走过的路径称为“引用链”（Reference Chain），如果某个对象到GC Roots间没有任何引用链相连，或者用图论的话来说就是从GC Roots到这个对象不可达时，则证明此对象是不可能再被使用的。 

在Java技术体系里面，固定可作为GC Roots的对象包括以下几种： 

- 在虚拟机栈（栈帧中的本地变量表）中引用的对象，譬如各个线程被调用的方法堆栈中使用到的参数、局部变量、临时变量等。 
- 在方法区中类静态属性引用的对象，譬如Java类的引用类型静态变量。 
- 在方法区中常量引用的对象，譬如字符串常量池（String Table）里的引用。·在本地方法栈中JNI（即通常所说的Native方法）引用的对象。 
- Java虚拟机内部的引用，如基本数据类型对应的Class对象，一些常驻的异常对象（比如NullPointExcepiton、OutOfMemoryError）等，还有系统类加载器。 
- 所有被同步锁（synchronized关键字）持有的对象。   
- 反映Java虚拟机内部情况的JMXBean、JVMTI中注册的回调、本地代码缓存等。 

### 35.常用的垃圾收集器有哪些?

1. 串行回收器：Serial、Serial old
2. 并行回收器：ParNew、Parallel Scavenge、Parallel old
3. 并发回收器：CMS、G1 
4. 低延迟收集器：Shenandoah、ZGC

[D:\Typora笔记\note\docs\JVM\内存与垃圾回收\16.垃圾回收器.md]()

### 36.常用的垃圾回收算法有哪些?

判断对象是否可回收的算法有两种：

- Reference Counting GC，引用计数算法
- Tracing GC，可达性分析算法

JVM 各厂商基本都是用的 Tracing GC 实现

大部分垃圾收集器遵从了分代收集(Generational Collection)理论。

针对新生代与老年代回收垃圾内存的特点，提出了 3 种不同的算法：

1、标记-清除算法(Mark-Sweep)

标记需回收对象，统一回收；或标记存活对象，回收未标记对象。
缺点：

- 大量对象需要标记与清除时，效率不高
- 在进行GC的时候，需要停止整个应用程序，用户体验较差
- 标记、清除产生的大量不连续内存碎片，导致无法分配大对象

2、标记-复制算法(Mark-Copy)

可用内存等分两块，使用其中一块 A，用完将存活的对象复制到另外一块 B，一次性清空 A，然后改分配新对象到 B，如此循环。
缺点：

- 不适合大量对象不可回收的情况，换句话说就是仅适合大量对象可回收，少量对象需复制的区域
- 只能使用内存容量的一半，浪费较多内存空间

3、标记-整理算法(Mark-Compact)

标记存活的对象，统一移到内存区域的一边，清空占用内存边界以外的内存。
缺点：

- 移动大量存活对象并更新引用，需暂停程序运行

### 37.什么是内存泄漏?

也称作“存储渗漏”。严格来说，只有对象不会再被程序用到了，但是GC又不能回收它们的情况，才叫内存泄漏。

但实际情况很多时候一些不太好的实践（或疏忽）会导致对象的生命周期变得很长甚至导致OOM，也可以叫做宽泛意义上的“内存泄漏”。（如类变量）

尽管内存泄漏并不会立刻引起程序崩溃，但是一旦发生内存泄漏，程序中的可用内存就会被逐步蚕食，直至耗尽所有内存，最终出现OutofMemory异常，导致程序崩溃。

注意，这里的存储空间并不是指物理内存，而是指虚拟内存大小，这个虚拟内存大小取决于磁盘交换区设定的大小。

### 38.Java 中会存在内存泄漏吗?

> https://blog.csdn.net/weter_drop/article/details/89387564

### 39.为什么会发生内存泄漏?

对象不会再被程序用到了，但是GC又不能回收它们

### 40.如何防止内存泄漏?

1.尽量减少使用静态变量，类的静态变量的生命周期和类同步的。  

2.声明对象引用之前，明确内存对象的有效作用域，尽量减小对象的作用域，将类的成员变量改写为方法内的局部变量；

3.减少长生命周期的对象持有短生命周期的引用；

4.使用StringBuilder和StringBuffer进行字符串连接，Sting和StringBuilder以及StringBuffer等都可以代表字符串，其中String字符串代表的是不可变的字符串，后两者表示可变的字符串。如果使用多个String对象进行字符串连接运算，在运行时可能产生大量临时字符串，这些字符串会保存在内存中从而导致程序性能下降。  

5.对于不需要使用的对象手动设置null值，不管GC何时会开始清理，我们都应及时的将无用的对象标记为可被清理的对象；

6.各种连接（数据库连接，网络连接，IO连接）操作，务必显示调用close关闭。

### 41.一个线程 OOM后，其他线程还能运行吗?

可以运行。一个线程抛出OOM异常后，它所占据的内存资源会全部被释放掉，不会影响其他线程的运行！

但是有一个例外情况，如果这些子线程都是守护线程，那么子线程会随着主线程OOM结束而结束。

### 42.native 关键字有什么用?

声明该方法为本地方法，由 C/C++ 实现

### 43.native 能和 abstract一起使用吗?

`native`方法不能与`abstract`方法一起使用，因为`native`表示这些方法是有实现体的，但是`abstract`却表示这些方法是没有实现体的，那么两者矛盾，肯定也不能一起使用。

### 44.怎么实现一个 native 方法?

参考：https://www.cnblogs.com/KingIceMou/p/7239668.html

### 45.Unsafe 类有什么用?

java不能直接访问操作系统底层，而是通过本地方法来访问。Unsafe类提供了硬件级别的原子操作，主要提供一些用于执行低级别、不安全操作的方法，如直接访问系统内存资源、自主管理内存资源等，这些方法在提升Java运行效率、增强Java语言底层资源操作能力方面起到了很大的作用。

参考：https://www.cnblogs.com/rickiyang/p/11334887.html

### 46.什么是直接内存?

根据官方文档的描述：

> A byte buffer is either direct or non-direct. Given a direct byte buffer, the Java virtual machine will make a best effort to perform native I/O operations directly upon it. That is, it will attempt to avoid copying the buffer's content to (or from) an intermediate buffer before (or after) each invocation of one of the underlying operating system's native I/O operations.

byte byffer可以是两种类型，一种是基于直接内存(也就是非堆内存)；另一种是非直接内存(也就是堆内存)。

对于直接内存来说，JVM将会在IO操作上具有更高的性能，因为它直接作用于本地系统的IO操作。而非直接内存，也就是堆内存中的数据，如果要作IO操作，会先复制到直接内存，再利用本地IO处理。

### 47.直接内存有什么用?

直接内存（Direct Memory）并不是虚拟机运行时数据区的一部分，也不是《Java虚拟机规范》中定义的内存区域。

在JDK 1.4中新加入了NIO（New Input/Output）类，引入了一种基于通道（Channel）与缓冲区（Buffer）的I/O方式，它可以使用Native函数库直接分配堆外内存，然后通过一个存储在Java堆里面的 DirectByteBuffer 对象作为这块内存的引用进行操作。这样能在一些场景中显著提高性能，因为避免了在Java堆和Native堆中来回复制数据。 

本机直接内存的分配不会受到Java堆大小的限制，但是，既然是内存，则肯定还是会受到本机总内存（包括物理内存、SWAP分区或者分页文件）大小以及处理器寻址空间的限制，一般服务器管理员配置虚拟机参数时，会根据实际内存去设置-Xmx等参数信息，但经常忽略掉直接内存，使得各个内存区域总和大于物理内存限制（包括物理的和操作系统级的限制），从而导致动态扩展时出现 OutOfMemoryError 异常。

### 48.怎样访问直接内存?

在JDK 1.4中新加入了NIO（New Input/Output）类，引入了一种基于通道（Channel）与缓冲区（Buffer）的I/O方式，它可以使用Native函数库直接分配堆外内存，然后通过一个存储在Java堆里面的 DirectByteBuffer 对象作为这块内存的引用进行操作。这样能在一些场景中显著提高性能，因为避免了在Java堆和Native堆中来回复制数据。 

```java
class DirectMemory {

    // 分配堆内存
    public static void bufferAccess() {
        long startTime = System.currentTimeMillis();
        ByteBuffer b = ByteBuffer.allocate(500);
        for (int i = 0; i < 1000000; i++) {
            for (int j = 0; j < 99; j++)
                b.putInt(j);
            b.flip();
            for (int j = 0; j < 99; j++)
                b.getInt();
            b.clear();
        }
        long endTime = System.currentTimeMillis();
        System.out.println("access_nondirect:" + (endTime - startTime));
    }

    // 直接分配内存
    public static void directAccess() {
        long startTime = System.currentTimeMillis();
        ByteBuffer b = ByteBuffer.allocateDirect(500);
        for (int i = 0; i < 1000000; i++) {
            for (int j = 0; j < 99; j++)
                b.putInt(j);
            b.flip();
            for (int j = 0; j < 99; j++)
                b.getInt();
            b.clear();
        }
        long endTime = System.currentTimeMillis();
        System.out.println("access_direct:" + (endTime - startTime));
    }

    public static void bufferAllocate() {
        long startTime = System.currentTimeMillis();
        for (int i = 0; i < 1000000; i++) {
            ByteBuffer.allocate(1000);
        }
        long endTime = System.currentTimeMillis();
        System.out.println("allocate_nondirect:" + (endTime - startTime));
    }

    public static void directAllocate() {
        long startTime = System.currentTimeMillis();
        for (int i = 0; i < 1000000; i++) {
            ByteBuffer.allocateDirect(1000);
        }
        long endTime = System.currentTimeMillis();
        System.out.println("allocate_direct:" + (endTime - startTime));
    }

    public static void main(String args[]) {
        System.out.println("访问性能测试：");
        bufferAccess();
        directAccess();

        System.out.println();

        System.out.println("分配性能测试：");
        bufferAllocate();
        directAllocate();
    }
}
/**
访问性能测试：
access_nondirect:157
access_direct:134

分配性能测试：
allocate_nondirect:231
allocate_direct:613
*/
```

49.常用的 JVM 调优命令有哪些?

50.常用的 JVM 问题定位工具有哪些?

### 51.常用的主流 JVM 虚拟机都有哪些?

- **HotSpot VM**
- **J9 VM**
- **Zing VM**

### 52.什么是伪共享?有什么解决方案?

伪共享是处理并发底层细节时一种经常需要考虑的问题，现代中央处理器的缓存系统中是以缓存行（Cache Line）为单位存储的，当多线程修改互相独立的变量时，如果这些变量恰好共享同一个缓存行，就会彼此影响（写回、无效化或者同步）而导致性能降低，这就是伪共享问题。

例如：线程1和线程2共享一个缓存行，线程1只读取缓存行中的变量1，线程2修改缓存行中的变量2，虽然线程1和线程2操作的是不同的变量，由于变量1和变量2同处于一个缓存行中，当变量2被修改后，缓存行失效，线程1要重新从主存中读取，因此导致缓存失效，从而产生性能问题。

可以通过填充来解决伪共享问题，Java8 中引入了@sun.misc.Contended注解来自动填充。

卡表更新：为了避免伪共享问题，一种简单的解决方案是不采用无条件的写屏障，而是先检查卡表标记，只有当该卡表元素未被标记过时才将其标记为变脏

> https://www.cnblogs.com/caomaoboy/p/12044038.html

### 53.Object obj=new Object（）占用几个字 节?

16个字节

> https://blog.csdn.net/weixin_38405253/article/details/114255710

### 54.为什么一个对象的字节大小为 8的整数倍?

HotSpot 虚拟机的自动内存管理要求对象起始地址必须是8字节的整数倍。

对齐填充，允许以某些空间为代价更快地访问内存。如果数据未对齐，那么处理器需要在加载内存后进行一些调整才能访问它。

### 55.对象不再使用时，需要赋值为 null吗?

可以，但是没必要。手动置为null或者后续复用局部变量表的槽会让GC在第一时间回收它

> https://www.polarxiong.com/archives/Java-%E5%AF%B9%E8%B1%A1%E4%B8%8D%E5%86%8D%E4%BD%BF%E7%94%A8%E6%97%B6%E8%B5%8B%E5%80%BC%E4%B8%BAnull%E7%9A%84%E4%BD%9C%E7%94%A8%E5%92%8C%E5%8E%9F%E7%90%86.html

### 56.如何实现对象克隆?

实现 Cloneable 接口，重写 clone() 方法。

- Object 的 clone() 方法是浅拷贝，即如果类中属性有自定义引用类型，只拷贝引用，不拷贝引用指向的对象。

```java

	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
```

实现 Serializable 接口，通过对象的序列化和反序列化实现克隆，可以实现真正的深度克隆

- 基于序列化和反序列化实现的克隆不仅仅是深度克隆，更重要的是通过泛型限定，可以检查出要克隆的对象是否支持序列化。这项检查是编译器完成的，不是在运行时抛出异常，这种方案是明显优于使用Object类的clone方法克隆对象。让问题在编译的时候暴露出来总是优于把问题留到运行时。但比较耗时

```java
public class CloneUtil {
 
    private CloneUtil() {
        throw new AssertionError();
    }
 
    /**
     * Clone.
     * 调用ByteArrayInputStream或ByteArrayOutputStream对象的close方法没有任何意义，
     * 这两个基于内存的流只要垃圾回收器清理对象时就能够释放资源，这一点不同于对外部资源（如文件流）的释放。
     *
     * @param obj The object.
     * @param <T> The type.
     * @return The cloned object.
     * @throws Exception The exception.
     */
    public static <T> T clone(T obj) throws Exception {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ObjectOutputStream objectOutputStream = new ObjectOutputStream(byteArrayOutputStream);
        objectOutputStream.writeObject(obj);
 
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        ObjectInputStream objectInputStream = new ObjectInputStream(byteArrayInputStream);
        return (T) objectInputStream.readObject();
    }
}
```

### 57.对象克隆浅拷贝和深拷贝的区别?

浅拷贝是指拷贝对象时仅仅拷贝对象本身（包括对象中的基本变量），而不拷贝对象包含的引用指向的对象。深拷贝不仅拷贝对象本身，而且拷贝对象包含的引用指向的所有对象。

### 58.什么是宏变量和宏替换?

Java中，一个用final定义的变量，不管它是类型的变量，只要用final定义了并同时指定了初始值，并且这个初始值是在编译时就被确定下来的，那么这个final变量就是一个宏变量。编译器会把程序所有用到该变量的地方直接替换成该变量的值，也就是说编译器能对宏变量进行宏替换

如：

```java
final String a = "hello";
final String b = a;
final String c = getHello();
```

a在编译期间就能确定下来，而b、c不行，所以a是宏变量，b、c不是。

所以，再回到上面的程序，finalWorld2和finalWorld4是final定义的，也是在编译期间能确定下来的，所以它能被宏替换，编译器就会让finalWorld2和finalWorld4指向字符串池中缓存的字符串”“hello world”，所以它们就是同一个对象。

### 59.什么是逃逸分析?

分析对象动态作用域

- 当一个对象在方法里面被定义后，它可能被外部方法所引用，例如作为调用参数传递到其他方法中，这种称为方法逃逸；
- 被外部线程访问到，譬如赋值给可以在其他线程中访问的实例变量，这种称为线程逃逸；
- 从不逃逸

如果能证明一个对象不会逃逸到方法或线程之外，或者逃逸程度比较低（只逃逸出方法而不会逃逸出线程），则可能为这个对象实例采取不同程度的优化，如栈上分配、标量替换、同步消除。

### 60.怎么查看一个Java 类的字节码?

javap

### 61.JVM 对频繁调用的方法做了哪些优化?

Java程序最初都是通过解释器（Interpreter）进行解释执行的，当虚拟机发现某个方法或代码块的运行特别频繁，就会把这些代码认定为“热点代码”（Hot Spot Code），为了提高热点代码的执行效率，在运行时，虚拟机将会把这些代码编译成本地机器码，并以各种手段尽可能地进行代码优化，运行时完成这个任务的后端编译器被称为即时编译器。

### 62.什么是热点代码?

某个方法或代码块的运行特别频繁。主要有两类，包括： 

- 被多次调用的方法。 

- 被多次执行的循环体。

### 63.什么是方法内联？

为了减少方法调用的开销，可以把一些短小的方法，纳入到目标方法的调用范围之内，这样就少了一次方法调用，提升速度

### 64.new一个对象的过程

1. **判断对象对应的类是否加载、链接、初始化**

   - 虚拟机遇到一条new指令，首先去检查这个指令的参数能否在Metaspace的常量池中定位到一个类的符号引用，并且检查这个符号引用代表的类是否已经被加载，解析和初始化。（即<font color='red'>判断类元信息是否存在</font>）。
   - 如果该类没有加载，那么在双亲委派模式下，使用当前类加载器以ClassLoader + 包名 + 类名为key进行查找对应的.class文件，如果没有找到文件，则抛出ClassNotFoundException异常，如果找到，则进行类加载，并生成对应的Class对象。（即<font color='red'>执行相应的类加载过程</font>）

2. **为对象分配内存**

   首先计算对象占用空间的大小，接着在堆中划分一块内存给新对象。如果实例成员变量是<font color='red'>引用变量</font>，仅分配引用变量空间即可，即<font color='red'>4个字节大小</font>。

   - 如果内存规整：<font color='red'>指针碰撞</font>
     - 如果内存是规整的，那么虚拟机将采用的是指针碰撞法（Bump The Point）来为对象分配内存。
     - 意思是所有用过的内存都被放在一边，空闲的内存被放另外一边，中间放着一个指针作为分界点的指示器，分配内存就仅仅是把指针往空闲内存那边挪动一段与对象大小相等的距离。如果垃圾收集器选择的是Serial ，ParNew这种基于压缩算法的，虚拟机采用这种分配方式——“指针碰撞”。一般使用带Compact（整理）过程的收集器时，使用指针碰撞。（标记压缩算法）
   - 如果内存不规整
     - 如果内存不是规整的，已使用的内存和未使用的内存相互交错，那么虚拟机将采用的是<font color='red'>空闲列表</font>方式来为对象分配内存。（标记清除算法）
     - 意思是虚拟机维护了一个列表，记录上哪些内存块是可用的，在分配的时候从列表中找到一块足够大的空间划分给对象实例，并更新列表上的内容。这种分配方式成为了 “<font color='red'>空闲列表</font>（Free List）”
   - 选择哪种分配方式由Java堆是否规整所决定，而Java堆是否规整又由所采用的<font color='red'>垃圾收集器是否带有空间压缩整理功能</font>决定 
     - 当使用Serial、ParNew等带压缩整理过程的收集器时，系统采用的分配算法是指针碰撞，既简单又高效；
     - 而当使用CMS这种基于清除（Sweep）算法的收集器时，<font color='red'>理论上</font>就只能采用较为复杂的空闲列表来分配内存。  
       - 强调“理论上”是因为在CMS的实现里面，为了能在多数情况下分配得更快，设计了一个叫作<font color='red'>Linear Allocation Buffer</font>的分配缓冲区，通过空闲列表拿到一大块分配缓冲区之后，在它里面仍然可以使用指针碰撞方式来分配。

3. **处理并发问题**

   可能出现对象A分配内存，指针还没来得及修改，对象B又同时使用了原来的指针来分配内存的情况。

   - 对分配内存空间的动作进行同步处理——实际上虚拟机是采用<font color='red'>CAS</font>配上<font color='red'>失败重试</font>的方式保证更新操作的原子性。
   - 每个线程在Java堆中预先分配一小块内存——<font color='red'>本地线程分配缓冲</font>（Thread Local Allocation Buffer，TLAB），哪个线程要分配内存，就在哪个线程的本地缓冲区中分配，只有本地缓冲区用完了，分配新的缓存区时才需要同步锁定。是否使用TLAB，通过设置` -XX:+UseTLAB`参数来设置（区域加锁机制）

4. **初始化分配到的空间**

   - 内存分配完成之后，虚拟机必须将分配到的内存空间（但不包括对象头）都初始化为零值，如果使用了TLAB的话，这一项工作也可以提前至TLAB分配时顺便进行。

   - 所有属性设置默认值，<font color='red'>保证对象实例字段在不赋值可以直接使用</font>
   - 给对象属性赋值的操作：

  - 属性的默认值初始化
    - 显示初始化/代码块初始化（在步骤6执行）
    - 构造器初始化（在步骤6执行）

5. **设置对象的对象头**

   - 将对象的所属类（即类的元数据信息）、对象的HashCode（实际上对象的哈希码会延后到真正调用Object::hashCode()方法时才计算）和对象的GC分代年龄、锁信息等数据存储在对象的对象头中。这个过程的具体设置方式取决于JVM实现。

6. **执行init方法进行初始化**

   - 从虚拟机的视角来看，一个新的对象已经产生了。

   - 在Java程序的视角看来，对象创建才正式开始——构造函数，即Class文件中的`<init>`方法还没执行。
     初始化成员变量，执行实例化代码块，调用类的构造方法，并把堆内对象的首地址赋值给引用变量
   - 因此一般来说（由字节码流中new指令后面是否跟随invokespecial指令所决定，Java编译器在遇到new关键字的地方同时生成这两条字节码指令，但如果直接通过其它方式则不一定如此），new指令之后会接着就是执行\<init>方法，按照程序员的意愿对对象进行初始化，这样一个真正可用的对象才算完成被构造出来。

### 65.GCroot

- 虚拟机栈中引用的对象

  - 比如：各个线程被调用的方法中使用到的参数、局部变量等。
- 本地方法栈内JNI（通常说的本地方法）引用的对象
- 方法区中类静态属性引用的对象

  - 比如：Java类的引用类型静态变量
- 方法区中常量引用的对象

  - 比如：字符串常量池（StringTable）里的引用
- 所有被同步锁 synchronized 持有的对象
- Java虚拟机内部的引用。

  - 基本数据类型对应的 Class 对象，一些常驻的异常对象（如：NullPointerException、OutofMemoryError），系统类加载器。
- 反映java虚拟机内部情况的 JMXBean、JVMTI 中注册的回调、本地代码缓存等。

### 66.请讲下java内存模型？

分析：该问题比较容易和jvm内存区域（java内存结构）这样的问题混淆，其实他们是两个概念，jvm内存区域指的是运行时的几块数据区域，包括堆、方法区、虚拟机栈、本地方法栈、程序计数器，强调的是在java程序运行的时候，内存是怎么划分的；而内存模型是另外的一个概念。

回答要点：

主要从以下几点去考虑，

1、java内存模型的作用，保证程序执行的可见性、有序性、原子性；

2、内存模型定义了什么，内存模型定义了多线程读写共享内存的规范；

3、内存模型怎么实现多线程共享变量的读写；

java内存模型简称JMM，是一种规范，通过这些规范定义java程序中各个变量的访问方式，解决并发编程中可能出现的线程安全问题。jvm运行程序的实体是线程，每个线程创建时jvm都会为其创建一个工作内存，用于存放线程私有的数据；Java内存模型规定所有的变量均保存在主内存中，主内存是共享内存，所有的线程都可以访问，但对变量的所有操作（包括读取赋值）都在工作内存中进行，线程无法直接操作主内存中的变量，所以就有了JMM。

主内存

主要存储的是Java实例对象，所有线程创建的实例对象都在主内存中，不管是成员变量还是在方法中创建的局部变量，同时也包含类信息、常量（static final）、静态变量(static)。由于主内存是共享区域，所以多个线程对同一个变量访问就会有线程安全问题；可以把主内存想象为java内存区域的堆、方法区

工作内存

主要存储当前线程正在执行的方法的所有本地变量（工作内存中存储着主内存中变量的副本），工作内存只对当前线程可见，其他线程无法访问当前线程的变量；可以把工作内存想象为Java内存区域的虚拟机栈、本地方法栈、程序计数器；是在java程序运行时的内存；

一个实例对象中的成员方法，如果方法中包含本地变量是基本数据类型（8种，boolean byte short int long double float char），这些基本类型的变量存储在工作内存中；如果本地变量是引用类型，那么该变量的引用存储在工作内存中，对象实例则存储在主内存中，对应对象实例中的成员变量不论是基本类型还是引用类型都存储在主内存中；

https://www.cnblogs.com/teach/p/14604636.html

67.JVM从GC角度看，堆的分区情况？
6.为什么堆要分新生代和老年代？而不是一个老年代就行？
27,为什么新生代要分成Eden和Survivor两个区？ 
28,为什么新生代Survivor区又分为两个区？一个不行吗？
29.新生代各分区的默认比例是怎样的？ 
30.哪些情况下存活对象会进入老年代？

31. GC是什么？为什么需要GC? 
32.什么是 Young GC? 
33.什么是 Minor GC? 
34.什么是 FullGC? 
35.什么时候会触发Minor GC? 
36.什么时候会触发FullGC? 
37,-次完整的GC流程是怎样的？ 
38.什么是GC停顿？为什么要停顿？ 
39.如何减少长时间的GC停顿？ 
40. JVM如何判断一个对象可被回收？ 
41.常用的垃圾收集器有哪些？
42.JVM中的默认垃圾收集器是？
43.什么是G1垃圾收集器？ 
44.有了 CMS收集器，为什么又搞出了 G1? 
45. G1垃圾收集器的适用场景？ 
46. G1垃圾收集器有什么优缺点？ 
47. G1收集器对于堆是怎么划分的？ 
48. G1收集器为什么重新划分了堆？ 
49. G1收集器是怎么处理大对象的？ 
50. G1收集器为什么新增Humongous区域？有什么 用？ s	>
si. gi垃圾回收的过程是怎样的？ a	>
52. G1回收停顿了几次，为什么？ a	>
53,怎么启用G1收集器？有哪些设置参数？ a	>
54.什么是CMS垃圾收集器？ @	>
55. CMS垃圾收集器的适用场景？ «	>
56. CMS垃圾收集器有什么优缺点？	>
57. CMS收集器触发GC的条件？ H	>
58. CMS垃圾回收的过程是怎样的？	>
59. CMS垃圾收集器能处理浮动垃圾吗？为什么？ 顽	>
60. CMS回收停顿了几次，为什么？ S	>
61. CMS垃圾收集器为什么会被废弃？画	>
62. CMS垃圾收集器废弃后有什么替代方案？ S	>
63.怎么启用CMS收集器？有哪些设置参数？ a	>
64. CMS和G1收集器的区别？ @	>
65. CMS和G1收集器怎么选？ S	>
66.常用的垃圾回收算法有哪些？ a	>
67.你怎么理解GC引用计数算法？ a	>
68.你怎么理解GC复制算法？ a	>
69.你怎么理解GC标记清除算法？ @	>
70.你怎么理解GC标记整理算法？ @	>
71.你怎么理解GC分代算法？ S	>
72. System.gc()和 Runtime.gcQ 的作用？有什么区别？
73.什么是三色标记法？ 
74.什么是浮动垃圾？ 
75.什么是内存泄漏？
76. Java中会存在内存泄漏吗？
77.为什么会发生内存泄漏？
78.如何防止内存泄漏？
79. —个线程00M后，其他线程还能运行吗？
80.什么是直接内存？
81.直接内存有什么用？
82.怎样访问直接内存？
83,常用的JVM调优命令有哪些？
84.常用的JVM问题定位工具有哪些？
85.常用的主流JVM虚拟机都有哪些？
86.JVM对频繁调用的方法做了哪些优化？
87.什么是热点代码？
23. GraalVM是什么技术？