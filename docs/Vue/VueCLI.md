## VUE CLI概述

> 官网：https://cli.vuejs.org/zh/guide/installation.html

### 介绍

如果你只是简单写几个Vue的Demo程序, 那么你不需要Vue CLI.

如果你在开发大型项目, 那么你需要, 并且必然需要使用Vue CLI

- 使用Vue.js开发大型应用时，我们需要考虑代码目录结构、项目结构和部署、热加载、代码单元测试等事情。
- 如果每个项目都要手动完成这些工作，那无以效率比较低效，所以通常我们会使用一些脚手架工具来帮助完成这些事情。

CLI是什么意思?

- CLI是Command-Line Interface, 翻译为命令行界面, 但是俗称脚手架.
- Vue CLI是一个官方发布 vue.js 项目脚手架
- 使用 vue-cli 可以快速搭建Vue开发环境以及对应的webpack配置.

### 使用前提

安装NodeJS

- 可以直接在官方网站中下载安装.

- 网址: http://nodejs.cn/download/

检测安装的版本

- 默认情况下自动安装Node和NPM

- Node环境要求8.9以上或者更高版本

- ```
  node -v
  ```

什么是NPM呢?

- NPM的全称是Node Package Manager
- 是一个NodeJS包管理和分发工具，已经成为了非官方的发布Node模块（包）的标准。
- 后续我们会经常使用NPM来安装一些开发过程中依赖包.

Vue.js官方脚手架工具就使用了webpack模板

- 对所有的资源会压缩等优化操作
- 它在开发过程中提供了一套完整的功能，能够使得我们开发过程中变得高效。

## Vue CLI2

### Vue CLI的使用

安装Vue脚手架

```
npm install -g @vue/cli
```

注意：上面安装的是Vue CLI最新的版本（4.5.12），如果需要想按照Vue CLI2的方式初始化项目时不可以的。

![image-20210417194252159](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210417194252159.png)

Vue CLI2初始化项目

```
vue init webpack my-project
```

Vue CLI3初始化项目

```
vue create my-project
```

Vue CLI2详解

![image-20210417200320188](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210417200320188.png)

目录结构详解

![image-20210417200359360](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210417200359360.png)

### Runtime-Compiler和Runtime-only

![image-20210417200530906](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210417200530906.png)