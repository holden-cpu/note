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
vue init webpack 项目名称
```

Vue CLI3初始化项目

```
vue create 项目名称
```

Vue CLI2详解

![image-20210417200320188](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210417200320188.png)

目录结构详解

![image-20210417200359360](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210417200359360.png)

### Runtime-Compiler和Runtime-only

![image-20210417200530906](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210417200530906.png)

如果你需要在客户端编译模板 (比如传入一个字符串给 `template` 选项，或挂载到一个元素上并以其 DOM 内部的 HTML 作为模板)，就将需要加上编译器，即完整版：

```js
// 需要编译器
new Vue({
  template: '<div>{{ hi }}</div>'
})

// 不需要编译器
new Vue({
  render (h) {
    return h('div', this.hi)
  }
})
```

当使用 `vue-loader` 或 `vueify` 的时候，`*.vue` 文件内部的模板会在构建时预编译成 JavaScript。你在最终打好的包里实际上是不需要编译器的，所以只用运行时版本即可。

因为运行时版本相比完整版体积要小大约 30%，所以应该尽可能使用这个版本。如果你仍然希望使用完整版，则需要在打包工具里配置一个别名：

```js
module.exports = {
  // ...
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js' // 用 webpack 1 时需用 'vue/dist/vue.common.js'
    }
  }
}
```

简单总结

- 如果在之后的开发中，你依然使用template，就需要选择Runtime-Compiler，例如在js文件中

- 如果你之后的开发中，使用的是.vue文件夹开发，那么可以选择Runtime-only，例如在vue文件中

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419114444775.png" alt="image-20210419114444775" style="zoom:50%;" /><img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419114500134.png" alt="image-20210419114500134" style="zoom:50%;" />

**Vue程序运行过程**

![image-20210419114711573](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419114711573.png)

```js
runtime-compiler(v1)
template -> ast -> render -> vdom -> UI

// 那么.vue文件中的template是由谁处理的了?
// 是由vue-template-compiler
// render -> vdom -> UI

runtime-only(v2)(1.性能更高 2.下面的代码量更少)
render -> vdom -> UI
```

### render函数的使用

![image-20210419120517401](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419120517401.png)

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419120522948.png" alt="image-20210419120522948" style="zoom:50%;" /><img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419120530947.png" alt="image-20210419120530947" style="zoom:50%;" />

```js
new Vue({
  el: '#app',
  render: function (createElement) {
    // 1.普通用法: createElement('标签', {标签的属性}, [''])
    // return createElement('h2',
    //   {class: 'box'},
    //   ['Hello World', createElement('button', ['按钮'])])

    // 2.传入组件对象:
    return createElement(App)
  }
})
```

**npm run build**

![image-20210419122532466](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419122532466.png)

**npm run dev**

![image-20210419122555551](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419122555551.png)

### 修改配置：webpack.base.conf.js起别名

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419122613498.png" alt="image-20210419122613498" style="zoom:80%;" />

## Vue CLI3

vue-cli 3 与 2 版本的区别

- vue-cli 3 是基于 webpack 4 打造，vue-cli 2 还是 webapck 3
- vue-cli 3 的设计原则是“0配置”，移除的配置文件根目录下的，build和config等目录
- vue-cli 3 提供了 vue ui 命令，提供了可视化配置，更加人性化
- 移除了static文件夹，新增了public文件夹，并且index.html移动到public中

```
vue create testvuecli3
```

```
运行服务：npm run serve
```

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419151440162.png" alt="image-20210419151440162" style="zoom: 50%;" />

**配置**

UI方面的配置

- 启动配置服务器：vue ui

![image-20210419153612469](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419153612469.png)

<img src="https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419154835500.png" alt="image-20210419154835500" style="zoom:50%;" />

**起别名**

![image-20210419155254330](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210419155254330.png) 

