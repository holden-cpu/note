## 入门简介

>  https://github.com/alibaba/spring-cloud-alibaba/blob/master/README-zh.md
>
> 官网	https://spring.io/projects/spring-cloud-alibaba#overview
>
> 英文	https://github.com/alibaba/spring-cloud-alibaba
> https://spring-cloud-alibaba-group.github.io/github-pages/greenwich/spring-cloud-alibaba.html
>
> 中文	https://github.com/alibaba/spring-cloud-alibaba/blob/master/README-zh.md

**为什么会出现SpringCloud alibaba**

Spring Cloud Netflix项目进入维护模式

https://spring.io/blog/2018/12/12/spring-cloud-greenwich-rc1-available-now

**什么是维护模式？**

将模块置于维护模式，意味着Spring Cloud团队将不会再向模块添加新功能。

他们将修复block级别的 bug 以及安全问题，他们也会考虑并审查社区的小型pull request。

**SpringCloud alibaba带来了什么**

**是什么**

> https://github.com/alibaba/spring-cloud-alibaba/blob/master/README-zh.md

Spring Cloud Alibaba 致力于提供微服务开发的一站式解决方案。此项目包含开发分布式应用微服务的必需组件，方便开发者通过 Spring Cloud 编程模型轻松使用这些组件来开发分布式应用服务。

依托 Spring Cloud Alibaba，您只需要添加一些注解和少量配置，就可以将 Spring Cloud 应用接入阿里微服务解决方案，通过阿里中间件来迅速搭建分布式应用系统。

诞生：2018.10.31，Spring Cloud Alibaba 正式入驻了Spring Cloud官方孵化器，并在Maven 中央库发布了第一个版本。

**能干嘛**

- **服务限流降级**：默认支持 WebServlet、WebFlux, OpenFeign、RestTemplate、Spring Cloud Gateway, Zuul, Dubbo 和 RocketMQ 限流降级功能的接入，可以在运行时通过控制台实时修改限流降级规则，还支持查看限流降级 Metrics 监控。
- **服务注册与发现**：适配 Spring Cloud 服务注册与发现标准，默认集成了 Ribbon 的支持。
- **分布式配置管理**：支持分布式系统中的外部化配置，配置更改时自动刷新。
- **消息驱动能力**：基于 Spring Cloud Stream 为微服务应用构建消息驱动能力。
- **分布式事务**：使用 @GlobalTransactional 注解， 高效并且对业务零侵入地解决分布式事务问题。
- **阿里云对象存储**：阿里云提供的海量、安全、低成本、高可靠的云存储服务。支持在任何应用、任何时间、任何地点存储和访问任意类型的数据。
- **分布式任务调度**：提供秒级、精准、高可靠、高可用的定时（基于 Cron 表达式）任务调度服务。同时提供分布式的任务执行模型，如网格任务。网格任务支持海量子任务均匀分配到所有 Worker（schedulerx-client）上执行。
- **阿里云短信服务**：覆盖全球的短信服务，友好、高效、智能的互联化通讯能力，帮助企业迅速搭建客户触达通道。

**去哪下**

如果需要使用已发布的版本，在 `dependencyManagement` 中添加如下配置。

```xml
	<dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>com.alibaba.cloud</groupId>
                <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                <version>2.2.5.RELEASE</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
```

然后在 `dependencies` 中添加自己所需使用的依赖即可使用。

**怎么玩**

- **[Sentinel](https://github.com/alibaba/Sentinel)**：把流量作为切入点，从流量控制、熔断降级、系统负载保护等多个维度保护服务的稳定性。
- **[Nacos](https://github.com/alibaba/Nacos)**：一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。
- **[RocketMQ](https://rocketmq.apache.org/)**：一款开源的分布式消息系统，基于高可用分布式集群技术，提供低延时的、高可靠的消息发布与订阅服务。
- **[Dubbo](https://github.com/apache/dubbo)**：Apache Dubbo™ 是一款高性能 Java RPC 框架。
- **[Seata](https://github.com/seata/seata)**：阿里巴巴开源产品，一个易于使用的高性能微服务分布式事务解决方案。
- **[Alibaba Cloud OSS](https://www.aliyun.com/product/oss)**: 阿里云对象存储服务（Object Storage Service，简称 OSS），是阿里云提供的海量、安全、低成本、高可靠的云存储服务。您可以在任何应用、任何时间、任何地点存储和访问任意类型的数据。
- **[Alibaba Cloud SchedulerX](https://help.aliyun.com/document_detail/43136.html)**: 阿里中间件团队开发的一款分布式任务调度产品，提供秒级、精准、高可靠、高可用的定时（基于 Cron 表达式）任务调度服务。
- **[Alibaba Cloud SMS](https://www.aliyun.com/product/sms)**: 覆盖全球的短信服务，友好、高效、智能的互联化通讯能力，帮助企业迅速搭建客户触达通道。

## Nacos服务注册和配置中心

### 概述

**名称由来**：前四个字母分别为Naming和Configuration的前两个字母，最后的s为Service。

**是什么**

- 一个更易于构建云原生应用的动态服务发现、配置管理和服务管理平台。
- Nacos: Dynamic Naming and Configuration Service
- Nacos就是注册中心＋配置中心的组合 => Nacos = Eureka+Config+Bus

能干嘛

- 替代Eureka做服务注册中心

- 替代Config做服务配置中心

去哪下

- https://github.com/alibaba/nacos/releases
- [官方文档](https://spring-cloud-alibaba-group.github.io/github-pages/greenwich/spring-cloud-alibaba.html#_spring%20cloud%20alibaba%20nacos_discovery)

**各中注册中心比较**

| 服务注册与发现框架 | CAP模型 | 控制台管理 | 社区活跃度      |
| ------------------ | ------- | ---------- | --------------- |
| Eureka             | AP      | 支持       | 低(2.x版本闭源) |
| Zookeeper          | CP      | 不支持     | 中              |
| consul             | CP      | 支持       | 高              |
| Nacos              | AP      | 支持       | 高              |

据说Nacos在阿里巴巴内部有超过10万的实例运行，已经过了类似双十一等各种大型流量的考验。

### 安装并运行

- 本地Java8+Maven环境已经OK先
- 从[官网](https://github.com/alibaba/nacos/releases)下载Nacos
- 解压安装包，直接运行bin目录下的startup.cmd
  - 注意：1.4版本启动默认cluster（集群）方式，直接启动会报错
  - 单击启动输入命令：`startup.cmd -m standalone`
- 命令运行成功后直接访问http://localhost:8848/nacos，默认账号密码都是nacos

![image-20210510165253151](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510165253151.png)

### 服务注册中心演示

[官方文档](https://spring-cloud-alibaba-group.github.io/github-pages/hoxton/en-us/index.html#_spring_cloud_alibaba_nacos_discovery)

新建Module：cloudalibaba-provider-payment9001

父pom.xml

```xml
<dependencyManagement>
    <dependencies>
        <!--spring cloud alibaba 2.1.0.RELEASE-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-alibaba-dependencies</artifactId>
            <version>2.1.0.RELEASE</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

子pom.xml

```xml
    <dependencies>
        <!--SpringCloud ailibaba nacos -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!-- SpringBoot整合Web组件 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--日常通用jar包配置-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies> 
```

application.yaml

```yaml
server:
  port: 9001

spring:
  application:
    name: nacos-payment-provider
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848 #配置Nacos地址

management:
  endpoints:
    web:
      exposure:
        include: '*'
```

主启动

```java
@EnableDiscoveryClient
@SpringBootApplication
public class PaymentMain9001 {
    public static void main(String[] args) {
            SpringApplication.run(PaymentMain9001.class, args);
    }
}

```

业务类

```java
@RestController
public class PaymentController {
    @Value("${server.port}")
    private String serverPort;

    @GetMapping(value = "/payment/nacos/{id}")
    public String getPayment(@PathVariable("id") Integer id) {
        return "nacos registry, serverPort: "+ serverPort+"\t id"+id;
    }
}
```

测试

- http://localhost:9001/payment/nacos/1
- nacos控制台
- nacos服务注册中心+服务提供者9001都OK了

![image-20210510173317851](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510173317851.png)

参照9001新建9002

- 新建cloudalibaba-provider-payment9002
- 9002其它步骤你懂的
- 或者==取巧==不想新建重复体力劳动，可以利用IDEA功能，直接拷贝虚拟端口映射

### 服务消费者

新建Module：cloudalibaba-consumer-nacos-order83

pom.xml

```xml
    <dependencies>
        <!--SpringCloud ailibaba nacos -->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!-- 引入自己定义的api通用包，可以使用Payment支付Entity -->
        <dependency>
            <groupId>com.lun.springcloud</groupId>
            <artifactId>cloud-api-commons</artifactId>
            <version>1.0.0-SNAPSHOT</version>
        </dependency>
        <!-- SpringBoot整合Web组件 -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--日常通用jar包配置-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
```

为什么nacos支持负载均衡？因为spring-cloud-starter-alibaba-nacos-discovery内含netflix-ribbon包。

application.yaml

```yaml
server:
  port: 83

spring:
  application:
    name: nacos-order-consumer
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848

#消费者将要去访问的微服务名称(注册成功进nacos的微服务提供者)
service-url:
  nacos-user-service: http://nacos-payment-provider

```

主启动

```
@EnableDiscoveryClient
@SpringBootApplication
public class OrderNacosMain83
{
    public static void main(String[] args)
    {
        SpringApplication.run(OrderNacosMain83.class,args);
    }
}

```

业务类

ApplicationContextConfig.java

```java
@Configuration
public class ApplicationContextConfig
{
    @Bean
    @LoadBalanced
    public RestTemplate getRestTemplate()
    {
        return new RestTemplate();
    }
}
```

OrderNacosController.java

```java
@RestController
@Slf4j
public class OrderNacosController {
    
    @Resource
    private RestTemplate restTemplate;

    @Value("${service-url.nacos-user-service}")
    private String serverURL;

    @GetMapping(value = "/consumer/payment/nacos/{id}")
    public String paymentInfo(@PathVariable("id") Long id)
    {
        return restTemplate.getForObject(serverURL+"/payment/nacos/"+id,String.class);
    }

}

```

测试

- 启动nacos控制台
- http://localhost:83/consumer/payment/nacos/13
  - 83访问9001/9002，轮询负载OK

### 服务注册中心对比

**Nacos全景图**

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/a9c35ea022a95aa76bfec990d6b73d8a.png)

**Nacos和CAP**

![image-20210510180906771](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510180906771.png)

![image-20210510180925765](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510180925765.png)

**Nacos支持AP和CP模式的切换**

C是所有节点在同一时间看到的数据是一致的;而A的定义是所有的请求都会收到响应。

何时选择使用何种模式?

—般来说，如果不需要存储服务级别的信息且服务实例是通过nacos-client注册，并能够保持心跳上报，那么就可以选择AP模式。当前主流的服务如Spring cloud和Dubbo服务，都适用于AP模式，AP模式为了服务的可能性而减弱了一致性，因此AP模式下只支持注册临时实例。

如果需要在服务级别编辑或者存储配置信息，那么CP是必须，K8S服务和DNS服务则适用于CP模式。CP模式下则支持注册持久化实例，此时则是以Raft协议为集群运行模式，该模式下注册实例之前必须先注册服务，如果服务不存在，则会返回错误。

切换命令：

`curl -X PUT '$NACOS_SERVER:8848/nacos/v1/ns/operator/switches?entry=serverMode&value=CP1`

### 服务配置中心

#### 基础配置

新建模块：cloudalibaba-config-nacos-client3377

pom.xml

```xml
    <dependencies>
        <!--nacos-config-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
        </dependency>
        <!--nacos-discovery-->
        <dependency>
            <groupId>com.alibaba.cloud</groupId>
            <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
        </dependency>
        <!--web + actuator-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <!--一般基础配置-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
```

**YML**

Nacos同springcloud-config一样，在项目初始化时，要保证先从配置中心进行配置拉取，拉取配置之后，才能保证项目的正常启动。

springboot中配置文件的加载是存在优先级顺序的，bootstrap优先级高于application

bootstrap.xml

```yaml
# nacos配置
server:
  port: 3377

spring:
  application:
    name: nacos-config-client
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848 #Nacos服务注册中心地址
      config:
        server-addr: localhost:8848 #Nacos作为配置中心地址
        file-extension: yaml #指定yaml格式的配置
        #group: DEV_GROUP
        #namespace: 7d8f0f5a-6a53-4785-9686-dd460158e5d4


# ${spring.application.name}-${spring.profile.active}.${spring.cloud.nacos.config.file-extension}
# nacos-config-client-dev.yaml

# nacos-config-client-test.yaml   ----> config.info

```

application.xml

```yaml
spring:
  profiles:
    active: dev # 表示开发环境
    #active: test # 表示测试环境
    #active: info
```

主启动

```java
@EnableDiscoveryClient
@SpringBootApplication
public class NacosConfigClientMain3377
{
    public static void main(String[] args) {
        SpringApplication.run(NacosConfigClientMain3377.class, args);
    }
}

```

业务类

```java
@RestController
@RefreshScope //支持Nacos的动态刷新功能。
public class ConfigClientController
{
    @Value("${config.info}")
    private String configInfo;

    @GetMapping("/config/info")
    public String getConfigInfo() {
        return configInfo;
    }
}

```

**在Nacos中添加配置信息**

Nacos中的dataid的组成格式及与SpringBoot配置文件中的匹配规则

[官方文档](https://nacos.io/zh-cn/docs/quick-start-spring-cloud.html)

说明：之所以需要配置 `spring.application.name` ，是因为它是构成 Nacos 配置管理 `dataId`字段的一部分。

在 Nacos Spring Cloud 中，`dataId` 的完整格式如下：

```plain
${prefix}-${spring.profiles.active}.${file-extension}
```

- `prefix` 默认为 `spring.application.name` 的值，也可以通过配置项 `spring.cloud.nacos.config.prefix`来配置。
- `spring.profiles.active` 即为当前环境对应的 profile，详情可以参考 [Spring Boot文档](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-profiles.html#boot-features-profiles)。 ==注意：当 `spring.profiles.active` 为空时，对应的连接符 `-` 也将不存在，dataId 的拼接格式变成 `${prefix}.${file-extension}`==
- `file-exetension` 为配置内容的数据格式，可以通过配置项 `spring.cloud.nacos.config.file-extension` 来配置。目前只支持 `properties` 和 `yaml` 类型。

- 通过 Spring Cloud 原生注解 `@RefreshScope` 实现配置自动更新：

```
${spring.application.name}-${spring.profile.active}.${spring.cloud.nacos.config.file-extension}
```

配置新增

Nacos界面配置对应 - 设置DataId

![image-20210510221427325](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510221427325.png)

**小结**

![image-20210510221607451](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510221607451.png)

**测试**

- 启动前需要在nacos客户端-配置管理-配置管理栏目下有对应的yaml配置文件
- 运行cloud-config-nacos-client3377的主启动类
- 调用接口查看配置信息 http://localhost:3377/config/info

**自带动态刷新**

修改下Nacos中的yaml配置文件，再次调用查看配置的接口，就会发现配置已经刷新。

#### 分类配置

**问题 - 多环境多项目管理**

问题1:

实际开发中，通常一个系统会准备

1. dev开发环境
2. test测试环境
3. prod生产环境。

如何保证指定环境启动时服务能正确读取到Nacos上相应环境的配置文件呢?

问题2:

一个大型分布式微服务系统会有很多微服务子项目，每个微服务项目又都会有相应的开发环境、测试环境、预发环境、正式环境…那怎么对这些微服务配置进行管理呢?

Nacos的图形化管理界面：

![image-20210510223252911](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510223252911.png)

![image-20210510223328174](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510223328174.png)

**Namespace+Group+Data lD三者关系？为什么这么设计？**

是什么

类似Java里面的package名和类名最外层的namespace是可以用于区分部署环境的，Group和DatalD逻辑上区分两个目标对象。

三者情况

![image-20210510223438971](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510223438971.png)

默认情况：Namespace=public，Group=DEFAULT_GROUP，默认Cluster是DEFAULT

Nacos默认的Namespace是public，Namespace主要用来实现隔离。比方说我们现在有三个环境：开发、测试、生产环境，我们就可以创建三个Namespace，不同的Namespace之间是隔离的。

Group默认是DEFAULT_GROUP，Group可以把不同的微服务划分到同一个分组里面去

Service就是微服务:一个Service可以包含多个Cluster (集群)，Nacos默认Cluster是DEFAULT，Cluster是对指定微服务的一个虚拟划分。
比方说为了容灾，将Service微服务分别部署在了杭州机房和广州机房，这时就可以给杭州机房的Service微服务起一个集群名称(HZ) ，给广州机房的Service微服务起一个集群名称(GZ)，还可以尽量让同一个机房的微服务互相调用，以提升性能。

最后是Instance，就是微服务的实例。 

##### DataID方案

指定spring.profile.active和配置文件的DatalD来使不同环境下读取不同的配置

默认空间+默认分组+新建dev和test两个DatalD

- 新建dev配置DatalD
- 新建test配置DatalD

![image-20210510223941480](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510223941480.png)

通过spring.profile.active属性就能进行多环境下配置文件的读取

![image-20210510224049411](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510224049411.png)

**测试**

- http://localhost:3377/config/info
- 配置是什么就加载什么 test/dev

##### Group分组方案

通过Group实现环境区分 - 新建DEV_Group、TEST_Group

![image-20210510225550060](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510225550060.png)

在nacos图形界面控制台上面新建配置文件DatalD

bootstrap+application

在config下增加一条group的配置即可。可配置为DEV_GROUP或TEST GROUP

![image-20210510225755850](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510225755850.png)

##### Namespace空间方案

新建dev/test的Namespace

![image-20210510230107025](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210510230107025.png)

回到服务管理-服务列表查看

按照域名配置填写

YAML

```yaml
# nacos配置
server:
  port: 3377

spring:
  application:
    name: nacos-config-client
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848 #Nacos服务注册中心地址
      config:
        server-addr: localhost:8848 #Nacos作为配置中心地址
        file-extension: yaml #指定yaml格式的配置
        group: DEV_GROUP
        namespace: 7d8f0f5a-6a53-4785-9686-dd460158e5d4 #<------------指定namespace


# ${spring.application.name}-${spring.profile.active}.${spring.cloud.nacos.config.file-extension}
# nacos-config-client-dev.yaml

# nacos-config-client-test.yaml   ----> config.info

```

### 集群和持久化配置

#### 官方说明

[官方文档](https://nacos.io/zh-cn/docs/cluster-mode-quick-start.html)

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/681c3dc16a69f197896cbff482f2298e.png" alt="img" style="zoom:200%;" />

默认Nacos使用嵌入式数据库实现数据的存储。所以，如果启动多个默认配置下的Nacos节点，数据存储是存在一致性问题的。为了解决这个问题，Nacos采用了集中式存储的方式来支持集群化部署，目前只支持MySQL的存储。

Nacos支持三种部署模式

- 单机模式-用于测试和单机试用。
- 集群模式-用于生产环境，确保高可用。
- 多集群模式-用于多数据中心场景。

**单机模式支持mysql**

在0.7版本之前，在单机模式时nacos使用嵌入式数据库实现数据的存储，不方便观察数据存储的基本情况。0.7版本增加了支持mysql数据源能力，具体的操作步骤：

- 1.安装数据库，版本要求：5.6.5+
- 2.初始化mysql数据库，数据库初始化文件：nacos-mysql.sql
- 3.修改conf/application.properties文件，增加支持mysql数据源配置（目前只支持mysql），添加mysql数据源的url、用户名和密码。

```properties
spring.datasource.platform=mysql

db.num=1
db.url.0=jdbc:mysql://11.162.196.16:3306/nacos_devtest?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true
db.user=nacos_devtest
db.password=youdontknow
```

再以单机模式启动nacos，nacos所有写嵌入式数据库的数据都写到了mysql

#### Nacos持久化配置解释

Nacos默认自带的是嵌入式数据库derby，nacos的pom.xml中可以看出。

derby到mysql切换配置步骤：

- nacos-server-1.1.4\nacos\conf录下找到nacos-mysql.sql文件，执行脚本。

  ![image-20210511152254415](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210511152254415.png)

- nacos-server-1.1.4\nacos\conf目录下找到application.properties，添加以下配置（按需修改对应值）。

```properties
spring.datasource.platform=mysql

db.num=1
db.url.0=jdbc:mysql://localhost:3306/nacos_config?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&serverTimezone=UTC
db.user=root
db.password=123456
```

启动Nacos，可以看到是个全新的空记录界面，以前是记录进derby。

新建配置，mysql中查看

![image-20210511154128067](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210511154128067.png)

#### Linux版Nacos+Mysql生产环境配置

预计需要，1个Nginx+3个nacos注册中心+1个mysql

> 请确保是在环境中安装使用:
>
> 1. 64 bit OS Linux/Unix/Mac，推荐使用Linux系统。
> 2. 64 bit JDK 1.8+；[下载](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).[配置](https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/)。
> 3. Maven 3.2.x+；[下载](https://maven.apache.org/download.cgi).[配置](https://maven.apache.org/settings.html)。
> 4. 3个或3个以上Nacos节点才能构成集群。

Nacos下载Linux版

- https://github.com/alibaba/nacos/releases/tag/1.1.4
- nacos-server-1.1.4.tar.gz 解压后安装

**Linux服务器上mysql数据库配置**

SQL脚本在哪里 - 目录nacos/conf/nacos-mysql.sql

自己Linux机器上的Mysql数据库上运行

**application.properties配置**

添加以下内容，设置数据源

```properties
spring.datasource.platform=mysql

db.num=1
db.url.0=jdbc:mysql://localhost:3306/nacos_config?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&serverTimezone=UTC
db.user=root
db.password=123456
```

**Linux服务器上nacos的集群配置cluster.conf**

梳理出3台nacos集器的不同服务端口号，设置3个端口：

- 3333
- 4444
- 5555

复制出cluster.conf

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/d742baa2bf4354db8dd9d588724e1f5c.png)

内容

```
192.168.111.144:3333
192.168.111.144:4444
192.168.111.144:5555
```

==注意==，这个IP不能写127.0.0.1，必须是Linux命令`hostname -i`能够识别的IP

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/431d5c0a090b88dffce35768e89e5a90.png)

**编辑Nacos的启动脚本startup.sh，使它能够接受不同的启动端口**

/mynacos/nacos/bin目录下有startup.sh

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/2cd7289348079d580cefed591a7568b9.png)

平时单机版的启动，都是./startup.sh即可

但是，集群启动，我们希望可以类似其它软件的shell命令，==传递不同的端口号启动不同的nacos实例。==

==命令==： ./startup.sh -p 3333表示启动端口号为3333的nacos服务器实例，和上一步的cluster.conf配置的一致。

修改内容：
![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/5b1fc1f634176ad17a19e4021d2b3b5e.png)

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/9a3b1d043e5d55236216a46f296e8606.png)

执行方式 - `startup.sh - p 端口号`

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/c68aec0dbcc1ed3d61b7e482718f9270.png)

**Nginx的配置，由它作为负载均衡器**

修改nginx的配置文件 - nginx.conf

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/700b800ca2e5a3dc01d0312cbeacda38.png" alt="img" style="zoom:150%;" />

修改内容

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/769472eda4b6a5e1b284db80c705d17f.png" alt="img" style="zoom:150%;" />

按照指定启动

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/f97a514ee914fb6050fd7428beb20639.png" alt="img" style="zoom:150%;" />

**截止到此处，1个Nginx+3个nacos注册中心+1个mysql**

**测试**

- 启动3个nacos注册中心
  - `startup.sh - p 3333`
  - `startup.sh - p 4444`
  - `startup.sh - p 5555`
  - 查看nacos进程启动数`ps -ef | grep nacos | grep -v grep | wc -l`
- 启动nginx
  - `./nginx -c /usr/local/nginx/conf/nginx.conf`
  - 查看nginx进程`ps - ef| grep nginx`

- 测试通过nginx，访问nacos - http://192.168.111.144:1111/nacos/#/login
- 新建一个配置测试

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/a550718db79bd46ee21031e36cb3be00.png)

- 新建后，可在linux服务器的mysql新插入一条记录

```
select * from config;
```

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/acc1d20f83d539d0e7943a11859328f5.png)

- 让微服务cloudalibaba-provider-payment9002启动注册进nacos集群 - 修改配置文件

```yaml
server:
  port: 9002

spring:
  application:
    name: nacos-payment-provider
  c1oud:
    nacos:
      discovery:
        #配置Nacos地址
        #server-addr: Localhost:8848
        #换成nginx的1111端口，做集群
        server-addr: 192.168.111.144:1111

management:
  endpoints:
    web:
      exposure:
        inc1ude: '*'

```

- 启动微服务cloudalibaba-provider-payment9002
- 访问nacos，查看注册结果

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/b463fc3b4e9796fa7d98fb72a3c421b6.png)

**高可用小总结**

![img](https://note-java.oss-cn-beijing.aliyuncs.com/img/42ff7ef670012437b046f099192d7484.png)