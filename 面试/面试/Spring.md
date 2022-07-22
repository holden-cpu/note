## spring

为什么使用spring

spring提供一个轻量级 JavaBean 容器框架，通过IOC统一管理应用对象的配置和生命周期，AOP应用业务逻辑和系统服务分开

### 1.Spring 框架是什么?

spring 是一个开源的轻量级 JavaBean 容器框架。使用 JavaBean 代替 EJB ，并提供了丰富的企业应用功能，降低应用开发的复杂性。

### 2.Spring 常用的注解有哪些?

@Component、@Repository、@Service、@Controller

@Autowired

@Configuration、@Bean

…..

### 3.Spring框架的好处有哪些?

- 轻量：非入侵性的、所依赖的东西少、资源占用少、部署简单，不同功能选择不同的 jar 组合
- 容器：工厂模式实现对 JavaBean 进行管理，通过控制反转（IOC）将应用程序的配置和依赖性与应用代码分开
- 松耦合：通过 xml 配置或注解即可完成 bean 的依赖注入
- AOP：通过 xml 配置 或注解即可加入面向切面编程的能力，完成切面功能，如：日志，事务...的统一处理
- 方便集成：通过配置和简单的对象注入即可集成其他框架，如 Mybatis、Hibernate、Shiro...
- 丰富的功能：JDBC 层抽象、事务管理、MVC、Java Mail、任务调度、JMX、JMS、JNDI、EJB、动态语言、远程访问、Web Service... 

### 4.Spring由哪些主要模块组成?

核心容器、数据访问/集成,、Web、AOP（面向切面编程）、工具、消息和测试模块。

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/image__20210406093356.png)



### 5.Spring lOC 容器是什么?

IOC，Inversion of Control（控制反转）。

是一种设计思想，在Java开发中，将你设计好的对象交给容器控制，而不是显示地用代码进行对象的创建。 

把创建和查找依赖对象的控制权交给 IOC 容器，由 IOC 容器进行注入、组合对象。这样对象与对象之间是松耦合、便于测试、功能可复用（减少对象的创建和内存消耗），使得程序的整个体系结构可维护性、灵活性、扩展性变高。

spring 提供了三种主要的方式来配置 IoC 容器中的 bean

- 基于 XML 文件配置
- 基于注解配置
- 基于注解 + java 代码显式配置

Spring 中 IOC 容器的底层实现就是 BeanFactory，BeanFactory 可以通过配置文件（xml、properties）、注解的方式加载 bean；提供根据 bean 的名称或类型类型查找 bean 的能力。功能最全的一个 BeanFactory 实现就是 DefaultListableBeanFactory。

常见两种实现方式

简单来说，依赖查找是一个主动获取的过程，例如我需要某个Bean，通过BeanFactory的getBean方法来获取；依赖注入是一个被动接受的过程，例如我需要某个Bean，我只需在类中方法或字段上添加@Autowired或@Resource注解即可，由IoC容器来帮我完成查找并注入。

> https://blog.csdn.net/m0_43448868/article/details/111866510

### 6.Spring lOC的好处有哪些?

- 资源集中管理，实现资源的可配置和易管理
- 降低了资源的依赖程度，即松耦合
- 便于测试
- 功能可复用（减少对象的创建和内存消耗）
- 使得程序的整个体系结构可维护性、灵活性、扩展性变高

### 7.Spring ApplicationContext是什么?

 Spring 应用上下文，它不仅继承了 BeanFactory 体系，还提供更加高级的功能，更加适用于我们的正式应用环境。如以下几个功能：

- 继承 MessageSource，提供国际化的标准访问策略
- 继承 ApplicationEventPublisher ，提供强大的事件机制
- 扩展 ResourceLoader，可以用来加载多个 Resource，可以灵活访问不同的资源
- 对 Web 应用的支持

> https://www.jianshu.com/p/2854d8984dfc

### 8.BeanFactory和ApplicationContext的区别?

![image-20220315150421961](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20220315150421961.png)

1.  BeanFactory和ApplicationContext是Spring的两大核心接口，都可以当做Spring的容器。其中ApplicationContext是BeanFactory的子接口, 包含 BeanFactory 的所有特性,它的主要功能是支持大型的业务应用的创建。


   （1）BeanFactory：是Spring里面最底层的接口，包含了各种Bean的定义，读取bean配置文档，管理bean的加载、实例化，控制bean的生命周期，维护bean之间的依赖关系。ApplicationContext接口作为BeanFactory的派生，除了提供BeanFactory所具有的功能外，还提供了更完整的框架功能：

   ①继承MessageSource，因此支持国际化。

   ②统一的资源文件访问方式。

   ③提供在监听器中注册bean的事件。

   ④同时加载多个配置文件。

   ⑤载入多个（有继承关系）上下文 ，使得每一个上下文都专注于一个特定的层次，比如应用的web层。

   （2）①BeanFactroy采用的是延迟加载形式来注入Bean的，即只有在使用到某个Bean时(调用getBean())，才对该Bean进行加载实例化。这样，我们就不能发现一些存在的Spring的配置问题。如果Bean的某一个属性没有注入，BeanFacotry加载后，直至第一次使用调用getBean方法才会抛出异常。

   ​      ②ApplicationContext，它是在容器启动时，一次性创建了所有的Bean。这样，在容器启动时，我们就可以发现Spring中存在的配置错误，这样有利于检查所依赖属性是否注入。 ApplicationContext启动后预载入所有的单实例Bean，通过预载入单实例bean ,确保当你需要的时候，你就不用等待，因为它们已经创建好了。它还可以为Bean配置lazy-init=true来让Bean延迟实例化；

   ​     ③相对于基本的BeanFactory，ApplicationContext 唯一的不足是占用内存空间。当应用程序配置Bean较多时，程序启动较慢。
   （3）BeanFactory通常以编程的方式被创建，ApplicationContext还能以声明的方式创建，如使用ContextLoader。

   （4）BeanFactory和ApplicationContext都支持BeanPostProcessor、BeanFactoryPostProcessor的使用，但两者之间的区别是：BeanFactory需要手动注册，而ApplicationContext则是自动注册。

### 9.Spring获取ApplicationContext的方法?

1. 使用@Autowired注入

2. 通过构造方法获取
3. 实现spring提供的接口ApplicationContextAware

https://blog.csdn.net/qq_41378597/article/details/106306411

### 10.Spring 依赖注入是什么?

DI（Dependency Injection）依赖注入，是 IoC 容器装配、注入对象的一种方式。
通过依赖注入机制，简单的配置即可注入需要的资源，完成自身的业务逻辑，不需要关心资源的出处和具体实现。

所谓依赖注入，是指程序运行过程中，如果需要调用另一个对象协助时，无须在代码中创建被调用者，而是依赖于外部的注入。

控制反转：创建对象实例的控制权从代码控制剥离到IOC容器控制，侧重于原理。
依赖注入：创建对象实例时，为这个对象注入属性值或其它对象实例，侧重于实现。

### 11.Spring 依赖注入有哪几种方式?

1. setting注入
2. 构造器注入
   - 根据构造器参数索引注入
   - 根据构造器参数类型注入
   - 根据构造器参数名称注入
3. 注解注入

### 12.Spring可以注入null和空字符串吗?

可以

### 13.Spring bean 支持哪几种作用域?

spring容器自带的有2种作用域，分别是singleton和prototype；还有3种分别是spring web容器环境中才支持的request、session、application、

### 14.Spring bean生命周期是怎样的?

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/v2-baaf7d50702f6d0935820b9415ff364c_1440w.jpg)

>  https://juejin.cn/post/6844904065457979405

重点接口：BeanDefinitionRegistry、InstantiationAwareBeanPostProcessor、MergedBeanDefinitionPostProcessor、

1. Bean元信息配置阶段

2. Bean元信息解析阶段

3. 将Bean注册到容器中 

4. BeanDefinition合并阶段
5. Bean Class加载阶段

6. Bean实例化阶段（2个小阶段）

   - Bean实例化前阶段

   - Bean实例化阶段

7. 合并后的BeanDefinition处理

8. 属性赋值阶段（3个小阶段）

   - Bean实例化后阶段

   - Bean属性赋值前阶段

   - Bean属性赋值阶段

9. Bean初始化阶段（5个小阶段）

   - Bean Aware接口回调阶段

   - Bean初始化前阶段

   - Bean初始化阶段

   - Bean初始化后阶段

10. 所有单例bean初始化完成后阶段

11. Bean的使用阶段

12. Bean销毁前阶段

13. Bean销毁阶段

> https://www.jianshu.com/p/1dec08d290c1

### 15.Spring bean 默认是单例还是多例?

单例

### 16.Spring bean 为什么默认为单例?

提高性能。

- 减少了新生成实例的消耗
- 减少jvm垃圾回收
- 可以快速获取到bean

### 17.Spring bean怎么配置为多例模式?

 xml配置：

```xml
<bean id="xxx" class="xxx" scope="prototype">
```


 注解配置：

```java
@Scope("prototype")
public class CustInfoList extends HttpServlet {}
```

### 18.Spring bean 是线程安全的吗?

「原型Bean」对于原型Bean,每次创建一个新对象，也就是线程之间并不存在Bean共享，自然是不会有线程安全的问题。如果存在静态变量也是线程不安全的，一定要定义变量的话，用ThreadLocal来封装，使其线程安全的

「单例Bean」对于单例Bean,所有线程都共享一个单例实例Bean,因此是存在资源的竞争。

> https://www.cnblogs.com/myseries/p/11729800.html

### 19.Spring bean怎么设置为默认 bean?

使用 @Primary 注解

### 20.Spring怎么防止相同类型 bean注入异常?

被注入的类型有多个的时候，可以使用@Qulifier来指定需要注入那个bean，将@Qulifier的value设置

为需要注入bean的值。

### 21.Spring如何在 bean初始化时、销毁时进行操作?

- Bean的方法加上@PostConstruct和@PreDestroy注解
- 在xml中定义init-method和destory-method方法
- Bean实现InitializingBean和DisposableBean接口

> https://blog.csdn.net/zbw18297786698/article/details/73656460

### 22.Spring @Autowired 注解有什么用?

@Autowired 是一个注释，它可以对类成员变量、方法及构造函数进行标注，让 spring 完成 bean 自动装配的工作。
@Autowired 默认是按照类去匹配，配合 @Qualifier 指定按照名称去装配 bean。

### 23.@Autowired注入request线程安全吗?

通过@Autowired注入的Request对象，其实并非是原生的HttpServletRequest对象，而是由Spring通过JDK动态代理技术生成的一个代理对象，也就不会有线程安全

> https://blog.csdn.net/qq_32099833/article/details/109207732
>
> https://fangshixiang.blog.csdn.net/article/details/104579949

### 26.@Resource，@Autowired，@Inject的区别?

1. @Autowired是Spring自带的，@Inject和@Resource都是JDK提供的，其中@Inject是JSR330规范的实现，@Resource是JSR250规范的实现。
2. @Autowired和@Inject基本是一样的，因为两者都是使AutowiredAnnotationBeanPostProcessor来处理依赖注入。但是@Resource不一样，它使用的是CommonAnnotationBeanPostProcessor来处理依赖注入。当然，两者都是BeanPostProcessor。
3. @Autowired和@Inject主要区别是@Autowired可以设置required属性为false，而@Inject并没有这个设置选项。
4. @Resource默认是按照byName进行注入，而@Autowired和@Inject默认是按照byType进行注入。
5. @Autowired通过@Qualifier指定注入特定bean,@Resource可以通过参数name指定注入bean,@Inject需要@Named注解指定注入bean。

> https://juejin.cn/post/6844904158252761102

### 27.Spring @Required 注解有什么用?

**@Required** 注释应用于 bean 属性的 setter 方法，**是用于检查一个Bean的属性在配置期间是否被赋值。**

> https://niocoder.com/2019/10/28/Spring%E7%B3%BB%E5%88%97%E5%8D%81%E4%BA%8C-Spring-@Required%E6%B3%A8%E8%A7%A3/

### 28.Spring @Qualifier注解有什么用?

如果创建了多个相同类型的Bean，那么Spring在初始化IOC容器时，不知道应该装配那个Bean，这时候可以使用 @Qualifier 注解来指定应该装配哪个具体的Bean，主要作用是指定装配的Bean，避免歧义。

### 29.Spring怎么注入 Java 集合类型?

\<list>类型用于注入一列值，允许有相同的值。

\<set> 类型用于注入一组值，不允许有相同的值。

\<map> 类型用于注入一组键值对，键和值都可以为任意类型。

\<props>类型用于注入一组键值对，键和值都只能为String类型。

### 30.Spring 装配是指什么?

当 bean 在 Spring 容器中组合在一起时，它被称为装配或 bean 装配。Spring 容器需要知道需要什么 bean 以及容器应该如何使用依赖注入来将 bean 绑定在一起，同时装配 bean。

### 31.Spring 自动装配有哪些方式?

- default - 默认的方式和 "no" 方式一样
- no - 不自动装配，需要使用 <ref />节点或参数
- byName - 根据名称进行装配
- byType - 根据类型进行装配
- constructor - 根据构造函数进行装配

> https://juejin.cn/post/6844903793637720071

### 32.Spring自动装配有什么局限性

在property和constructor-arg设置中的依赖总是重载自动装配，我们无法对原始类型（如int，long，boolean等就是首字母小写的那些类型），还有String，Classes做自动装配。这是受限于设计。

自动装配跟直接装配（explicit wiring）相比较，在准确性方便还是差那么点，虽然没有明确地说明，但是Spring还是尽量避免这种模棱两可的情况，导致出现没预料到的结果。

Spring容器生成文档的工具可能会不能使用装配的信息。

容器中多个bean的定义可能要对setter和构造器参数做类型匹配才能做依赖注入，虽然对于array，collection和map来说不是啥问题，但是对于只有单一值的依赖来讲，这就有点讲不清楚了，所以如果没有唯一的bean定义，那只能抛出异常。

> https://blog.csdn.net/sinat_36246371/article/details/78154022

### 33.Spring AOP是什么?

AOP（Aspect Orient Programming）是一种设计思想，是软件设计领域中的面向切面编程，它是面向对象编程(OOP)的一种补充和完善。它以通过预编译方式和运行期动态代理方式，实现在不修改源代码的情况下给程序动态统一添加额外功能的一种技术

> https://developer.huawei.com/consumer/cn/forum/topic/0204428908571400020

### 34.SpringAOP有什么作用?

实现在不修改源代码的情况下给程序动态统一添加额外功能。

利用AOP可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的耦合度降低，提高程序的可重用性，同时提高了开发的效率。

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/0070086000197679238.20201209100604.78383991388246432325585539193110:50521001102535:2800:56C5665118F794668324F2EFD478646675960CDCB9C6B9A3677C02164EA9FCDF.png)

### 35.SpringAOP有哪些实现方式?

声明的方式来实现（基于XML）

采用注解的方式来实现（基于AspectJ）

### 36.SpringAOP和AspectJ AOP的区别?

- AspectJ可以做Spring AOP干不了的事情，它是AOP编程的完全解决方案，Spring AOP则致力于解决企业级开发中最普遍的AOP（方法织入）。而不是成为像AspectJ一样的AOP方案
- 因为AspectJ可以在实际运行之前就完成了织入，所以说它生成的类是没有额外运行时开销的

| Spring AOP                                       | AspectJ                                                      |
| ------------------------------------------------ | ------------------------------------------------------------ |
| 在纯 Java 中实现                                 | 使用 Java 编程语言的扩展实现                                 |
| 不需要单独的编译过程                             | 除非设置 LTW，否则需要 AspectJ 编译器 (ajc)                  |
| 只能使用运行时织入                               | 运行时织入不可用。支持编译时、编译后和加载时织入             |
| 功能不强-仅支持方法级编织                        | 更强大 - 可以编织字段、方法、构造函数、静态初始值设定项、最终类/方法等......。 |
| 只能在由 Spring 容器管理的 bean 上实现           | 可以在所有域对象上实现                                       |
| 仅支持方法执行切入点                             | 支持所有切入点                                               |
| 代理是由目标对象创建的, 并且切面应用在这些代理上 | 在执行应用程序之前 (在运行时) 前, 各方面直接在代码中进行织入 |
| 比 AspectJ 慢多了                                | 更好的性能                                                   |
| 易于学习和应用                                   | 相对于 Spring AOP 来说更复杂                                 |

> https://destiny1020.blog.csdn.net/article/details/57526325

### 37.Spring 支持哪些事务管理类型?

- 编程式事务：硬编码的方式
- 声明式事务
  - 配置文件的方式
  - 注解的方式

1.propagation_required: 默认事务类型，如果没有，就新建一个事务；如果有，就加入当前事务。适合绝大多数情况。

2.propagation_required_new: 如果没有，就新建一个事务；如果有，就将当前事务挂起。

3.propagation_nested: 如果没有，就新建一个事务；如果有，就在当前事务中嵌套其他事务。

4.propagation_supports: 如果没有，就以非事务方式执行；如果有，就使用当前事务。

5.propagation_not_supported: 如果没有，就以非事务方式执行；如果有，就将当前事务挂起。即无论如何不支持事务。

6.propagation_never: 如果没有，就以非事务方式执行；如果有，就抛出异常。

7.propagation_mandatory: 如果没有，就抛出异常；如果有，就使用当前事务

### 38.Spring用哪种事务管理类型比较合适?

声明式事务，

### 39.Spring 用什么注解开启事务?

@EnableTransactionManagement：开启spring事务管理功能

@Transaction：将其加在需要spring管理事务的类、方法、接口上，只会对public方法有效。

### 40.Spring事务默认回滚的异常是什么?

Spring的事务管理默认只对出现运行期异常(java.lang.RuntimeException及其子类)，Error进行回滚。 
如果一个方法抛出Exception或者Checked异常，Spring事务管理默认不进行回滚。

### 41.Spring  事务怎么指定是否回滚的异常?

在@Transaction注解中定义noRollbackFor和RollbackFor指定某种异常是否回滚。 
@Transaction(noRollbackFor=RuntimeException.class) 
@Transaction(RollbackFor=Exception.class) 
这样就改变了默认的事务处理方式。

### 42.Spring 事务失效的原因有哪些?

> https://segmentfault.com/a/1190000021510031?utm_source=sf-similar-article

底层数据库引擎不支持事务

- 如果数据库引擎不支持事务，则Spring自然无法支持事务。

在非public修饰的方法使用

- @Transactional注解使用的是AOP，在使用动态代理的时候只能针对`public`方法进行代理

没有被 Spring 管理

调用自身的方法

```java
@Service
public class OrderServiceImpl implements OrderService {

    public void update(Order order) {
        updateOrder(order);
    }
    
    @Transactional
    public void updateOrder(Order order) {
        // update order
    }
}
```

数据源没有配置事务管理器

传播行为设置为`@Transactional(propagation = Propagation.NOT_SUPPORTED)`

异常被catch处理掉，不向外抛

不是运行时异常和error

### 44.Spring只读事务（readOnly）是什么?

在将事务设置成只读后，当前只读事务就不能进行写的操作，否则报错。如下

```
Cause: java.sql.SQLException: Connection is read-only. Queries leading to data modification are not allowed;
```

> https://www.jianshu.com/p/f2ab7aee4e95

### 45.Spring只读事务（readOnly）的应用场景?

- 如果你一次执行单条查询语句，则没有必要启用事务支持，数据库默认支持SQL执行期间的读一致性；

- 如果你一次执行多条查询语句，例如统计查询，报表查询，在这种场景下，多条查询SQL必须保证整体的读一致性，否则，在前条SQL查询之后，后条SQL查询之前，数据被其他用户改变，则该次整体的统计查询将会出现读数据不一致的状态，此时，应该启用事务支持。

> https://www.cnblogs.com/jtlgb/p/10435450.html

### 46.Spring怎么配置只读事务?

```
@Transactional(readOnly=true
```

### 47.Spring超时事务（timeout）是什么?

https://juejin.cn/post/6844903768459313159#2_Spring_Transactional

https://blog.csdn.net/qq_18860653/article/details/79907984

48.Spring 怎么配置超时事务?

### 49.Spring怎么开启方法异步执行?

@EnableAsync注解即开启Spring对方法异步执行的能力，需要和注解@Configuration配合使用。

在要异步执行的方法上使用@Async注解，下面是一个没有返回值，一个带有返回值的异步调用的示例

> https://zhuanlan.zhihu.com/p/64108111

### 50.Spring 怎么开启定时任务?

### 51.Spring中的 Aware接口有啥用?

```java
/**
 * Marker superinterface indicating that a bean is eligible to be
 * notified by the Spring container of a particular framework object
 * through a callback-style method. Actual method signature is
 * determined by individual subinterfaces, but should typically
 * consist of just one void-returning method that accepts a single
 * argument.
 */
public interface Aware {

}
```

注释的大致意思是：Aware是一个标记性的超接口（顶级接口），指示了一个Bean有资格通过回调方法的形式获取Spring容器底层组件。实际回调方法被定义在每一个子接口中，而且通常一个子接口只包含一个接口一个参数并且返回值为void的方法。

说白了：只要实现了Aware子接口的Bean都能获取到一个Spring底层组件。

> https://zhuanlan.zhihu.com/p/99985852

### 52.Spring常用的Aware接口有哪些?

BeanFactoryAware、EnvironmentAware、ResourceLoaderAware、ImportAware、BeanNameAware、ApplicationContextAware。

### 53.Spring中的@Enable有什么用?

一般用于开启某一类功能。类似于一种开关，只有加了这个注解，才能使用某些功能。

54.Spring中的@Enable什么原理?
55.Spring中的事件监听机制是什么?
56.Spring可以不要xml配置文件吗?
57.Spring5.0都有什么新功能?

## SpringMVC

### 1.Spring MVC 框架有什么用?

### 2.Spring MVC和 Struts2的区别?

https://www.jianshu.com/p/f1e5f789939c

### 3.Spring MVC DispatcherServlet 流程?

Spring MVC 有哪些处理组件?
5.Spring MVC的 HandlerMapping作用?
6.Spring MVC的 HandlerAdapter作用?
7.HandlerMapping、HandlerAdapter关系?
8.Spring MVC怎么获取当前request?（-10）
9.Spring MVC怎么映射一个控制器类?（-10）
10.Spring MVC控制器是单例模式吗?（-10）
11.Spring MVC常用的注解有哪些?（-10）
12.Spring MVC可以用在控制器上的注解有?（-10）
13.Spring MVC可以用在方法上的注解有?（-10）
14.Spring MVC可以用在方法参数上的注解有?（-10）
15.Spring MVC@RequestMapping有啥用?（10）
16.Spring MVC获取请求参数有哪些方式?（-10）
17.Spring MVC怎么进行请求转发?（-10）
18.Spring MVC怎么进行请求重定向?（-10）
19.SpringMVC怎么只接收POST请求?（-10）
20.Spring MVC怎么限制请求数据格式?（-10）
21.Spring MVC怎么指定响应数据格式?（-10）
22.Spring MVC怎么返回JSON格式数据?（-10）
23.SpringMVC怎么向前台页面传递数据?

### 24.Spring MVC怎么解决请求乱码问题?

https://www.cnblogs.com/yangmingxianshen/p/12521530.html

### 25. **SpringMVC执行流程:**

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/249993-20161212142542042-2117679195.jpg)

 1.用户发送请求至前端控制器DispatcherServlet
 2.DispatcherServlet收到请求调用处理器映射器HandlerMapping。
 3.处理器映射器根据请求url找到具体的处理器，生成处理器执行链HandlerExecutionChain(包括处理器对象和处理器拦截器)一并返回给DispatcherServlet。
 4.DispatcherServlet根据处理器Handler获取处理器适配器HandlerAdapter执行HandlerAdapter处理一系列的操作，如：参数封装，数据格式转换，数据验证等操作
 5.执行处理器Handler(Controller，也叫页面控制器)。
 6.Handler执行完成返回ModelAndView
 7.HandlerAdapter将Handler执行结果ModelAndView返回到DispatcherServlet
 8.DispatcherServlet将ModelAndView传给ViewReslover视图解析器
 9.ViewReslover解析后返回具体View
 10.DispatcherServlet对View进行渲染视图（即将模型数据model填充至视图中）。
 11.DispatcherServlet响应用户。

## SpringBoot

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/9824247-a2cb38eec09c5d5c.jpg)

1. 通过 `SpringFactoriesLoader` 加载 `META-INF/spring.factories` 文件，获取并创建 `SpringApplicationRunListener` 对象

2. 然后由 `SpringApplicationRunListener` 来发出 starting 消息

3. 创建参数，并配置当前 SpringBoot 应用将要使用的 Environment

4. 完成之后，依然由 `SpringApplicationRunListener` 来发出 environmentPrepared 消息

5. 创建 `ApplicationContext`

6. 初始化 `ApplicationContext`，并设置 Environment，加载相关配置等

7. 由 `SpringApplicationRunListener` 来发出 `contextPrepared` 消息，告知SpringBoot 应用使用的 `ApplicationContext` 已准备OK

8. 将各种 beans 装载入 `ApplicationContext`，继续由 `SpringApplicationRunListener` 来发出 contextLoaded 消息，告知 SpringBoot 应用使用的 `ApplicationContext` 已装填OK

9. refresh ApplicationContext，完成IoC容器可用的最后一步

10. 由 `SpringApplicationRunListener` 来发出 started 消息

11. 完成最终的程序的启动

12. 由 `SpringApplicationRunListener` 来发出 running 消息，告知程序已运行起来了

> 链接：https://www.jianshu.com/p/90e580798559

  上午9∶25会 C6J
  O
  Java面试库
  SpringBoot
  60
  1.Spring Boot是什么?（-5）
  2.Spring Boot 有哪些优缺点?（-5）
  3.Spring Boot 框架的核心思想是什么?
  4.Spring Boot 有哪些核心模块?（-5）
  5.Spring Boot 的核心配置文件有哪些?（-10）
  6.bootstrap和 application配置的区别?（-10）
  7.application 配置文件的应用场景?（-5）
  8.bootstrap 配置文件的应用场景?（-5）
  9.Spring Boot 的配置文件有哪几种格式?（-5）
  10.Spring Boot 的核心注解是哪个?
  11.SpringBootApplication注解的子注解有?（-5）
  12.Spring Boot最核心的注解有哪些?（-10）
  13.SpringBoot怎么根据指定条件注册 bean?（-5
  14.Spring Boot 有哪些条件注解?（-10）
  15.Spring Boot有哪两种方式集成?（-10）
  16.Spring Boot需要独立的容器运行吗?（-5）
  17.Spring Boot支持哪几种内嵌容器?（-5）
  18.Spring Boot 中的默认内嵌容器是?（-5）
  19.Spring Boot中的内嵌容器可以替换么?（-5）
  20.Spring Boot自动配置原理是什么?（-10）
  21.Spring Boot 开启自动配置的注解是?（-5）
  22.Spring Boot 自动配置的类在哪注册?（-5）
  23.Spring Boot 自动配置报告怎么查看?（5）
  24.Spring Boot怎么排除某些自动配置?（-10）
  25.Spring Boot怎么开启和关闭自动配置?（-10）
  26.Spring Boot 的目录结构是怎样的?（-5）
  27.Spring Boot中的 Starters是什么?（-5）
  28.Spring Boot Starters有什么命名规范?（-10）
  29.SpringBoot Starters官方有哪些分类?（10）
  30.Spring Boot怎么自定义一个Starter?（-10）
  31.Spring Boot有哪几种运行方式?（-10）
  32.Spring Boot支持哪些应用打包方式?（-10）
  33.Spring Boot 默认的打包方式是?（-10）
  34.Spring Boot应用怎么 Debug 调试?（-10）
  35.Spring Boot可以配置随机端口吗?（-5）
  36.Spring Boot怎么打一个可执行Jar包?（-10）
  37.Spring Boot怎么运行可执行 Jar包?（-5）
  38.Spring Boot支持https 配置吗?（-5）
  39.Spring Boot怎么注册 Servlet?（-10）
  40.SpringBoot Runner是什么?（-5）
  41.Spring Boot 支持哪些模板引擎?（-5）
  42.Spring Boot支持Velocity模板引擎吗?（-5）
  43.Spring Boot怎么做单元测试?（-10）
  44.Spring Boot 支持哪些日志框架?（-5）
  45.Spring Boot默认使用哪个日志框架?（-5）
  46.Spring Boot有哪几种热部署方式?（-10）
  47.Spring Boot配置加载顺序是怎样的?（-10）
  48.Spring Boot 如何定义不同环境配置?（-10）
  49.Spring Boot怎么兼容老 Spring项目?（-5）
  50.Spring Boot 应用有哪些保护手法?（-5）
  51.Spring Boot怎么注册事件监听器?（-10）
  52.Spring Boot应用如何监控和健康检查?（-5）
  53.Spring Boot怎么解决跨域问题?（-10）
  54.Spring Boot 2.X有什么新特性?（-10）
  55.Spring Boot怎么定制启动图案?（-5）
  56.Spring Boot怎么关闭启动图案?（-5）
  57.Spring Boot 的默认编码是?（-5）
  58.Spring Boot怎么指定编码格式?（-5）
  59.Spring BootFailureAnalyzers是什么?（10）
  60.Spring Boot应用如何优雅关闭?（10）
  34

## Spring Cloud

1.Spring Cloud 是什么?（-5）
2.Spring Cloud 有哪些优势?（-5）
3.Spring Cloud 和Spring Boot的关系?
4.Spring Cloud有哪些重要的组件?（-10）
5.Spring Cloud 和 Dubbo 的区别?
6.Spring Cloud 版本号怎么理解?（-10）
7.Spring Cloud Eureka保护机制是什么?（-10）
8.Spring Cloud怎么实现服务注册和发现?（5）
9.Spring Cloud 注册中心有哪些实现方案?
10.Spring Cloud 配置中心有哪些实现方案?
11.Spring Cloud 如何保证微服务调用安全性?
12.Spring Cloud服务之间是哪种调用方式?
13.Spring Cloud 怎么实现服务负载均衡?
14.Spring Cloud Netflix有哪些组件弃用了?
15.Spring Cloud Ribbon是什么?（-5）
16.Spring Cloud Feign是什么?（-5）
17.Spring Cloud Feign和ribbon的区别?（-5）
18.Spring Cloud OpenFeign是什么?（-5）
19.SpringCloud OpenFeign和Feign的区别?（-5）
20.Spring Cloud Zuul是什么?（-5）
21.Spring Cloud Gateway是什么?（5）
22.Spring Cloud GatewayVSZuul怎么选?（5
23.SpringCloud for Alibaba是什么?（5）
24.Spring Cloud Commons是什么?（-5）
25.SpringCloud Contract是什么?（5）
26.Spring Cloud Consul是什么?（-5）
27.Spring Cloud Connectors是什么?（-5）
28.Spring Cloud Config是什么?（-5）
29.Spring Cloud Bus是什么?（-5）
30.Spring Cloud Stream是什么?（-5）
31.Spring Cloud Stream与Bus的区别?（-5）
32.Spring Cloud Task是什么?（-5）
33.Spring Cloud AWS是什么?（-5）
34.Spring Cloud CLI是什么?（-5）



24
人 MyBati
102
MySQL
ai
Redis 57