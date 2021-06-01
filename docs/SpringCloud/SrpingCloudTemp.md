## Sentinel

[Github](https://github.com/alibaba/Sentinel)

[官方文档](https://sentinelguard.io/zh-cn/docs/introduction.html)

[下载地址](https://github.com/alibaba/Sentinel/releases/tag/1.8.1)

[springcloud文档](https://spring-cloud-alibaba-group.github.io/github-pages/greenwich/spring-cloud-alibaba.html#_spring_cloud_alibaba_sentinel)

### 安装Sentinel控制台

Sentinel 分为两个部分：

- 核心库（Java 客户端）不依赖任何框架/库，能够运行于所有 Java 运行时环境，同时对 Dubbo / Spring Cloud 等框架也有较好的支持。

- 控制台（Dashboard）基于 Spring Boot 开发，打包后可以直接运行，不需要额外的 Tomcat 等应用容器。

运行命令

- 前提
  - Java 8 环境
  - 8080端口不能被占用或者使用--server.port=端口号

- 命令
  - `java -jar sentinel-dashboard-1.7.0.jar`

访问Sentinel管理界面

- localhost:8080
- 登录账号密码均为sentinel

### 初始化演示工程

**启动Nacos8848成功**

**新建moudle：cloudalibaba-sentinel-service8401**