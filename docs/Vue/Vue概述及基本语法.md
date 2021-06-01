## 一、邂逅Vuejs

### 认识Vuejs

- Vue的读音

  - Vue (读音 /vjuː/，类似于 view)，不要读错。 

- Vue的渐进式

  - 渐进式意味着你可以将Vue作为你应用的一部分嵌入其中，带来更丰富的交互体验。
  - 或者如果你希望将更多的业务逻辑使用Vue实现，那么Vue的核心库以及其生态系统。 
  - 比如Core+Vue-router+Vuex，也可以满足你各种各样的需求。

- Vue的特点

  - 解耦视图和数据

  - 可复用的组件 
  - 前端路由技术 
  - 状态管理 
  - 虚拟DOM 



### 安装Vue

- CDN引入

> 开发环境版本，包含了有帮助的命令行警告 
>
>   生产环境版本，优化了尺寸和速度 
>
>  \<script src="https://cdn.jsdelivr.net/npm/vue">\</script> 

- 下载引入

> 开发环境 https://vuejs.org/js/vue.js  
>
> 生产环境 https://vuejs.org/js/vue.min.js

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615535043559-3d345767-1b7f-4efe-9c87-ccab004087c5.png)

- npm安装

> 后续通过webpack和CLI的使用，我们使用该方式。



### Vue的初体验

- HelloVuejs

  - mustache -> 体验vue响应式
  - 创建Vue对象的时候，传入了一些options：{}
    - {}中包含了el属性：该属性决定了这个Vue对象挂载到哪一个元素上，很明显，我们这里是挂载到了id为app的元素上 

  - {}中包含了data属性：该属性中通常会存储一些数据 
    - 这些数据可以是我们直接定义出来的，比如像上面这样。 
    - 也可能是来自网络，从服务器加载的。

```vue
<body>
<div id="app">
    <h2>{{message}}</h2>
    <h1>{{name}}</h1>
</div>
<div>{{message}}</div>
<script src="../js/vue.js"></script>
<script>
    // let(变量)/const(常量)
    // 编程范式: 声明式编程
    const app = new Vue({
        el: '#app', // 用于挂载要管理的元素
        data: { // 定义数据
            message: '你好啊,李银河!',
            name: 'coderwhy'
        }
    })

    // 元素js的做法(编程范式: 命令式编程)
    // 1.创建div元素,设置id属性
    // 2.定义一个变量叫message
    // 3.将message变量放在前面的div元素中显示
    // 4.修改message的数据: 今天天气不错!
    // 5.将修改后的数据再次替换到div元素
</script>
</body>
```

- Vue列表展示
  - v-for
  - 后面给数组追加元素的时候, 新的元素也可以在界面中渲染出来
  - 当我们数组中的数据发生改变时，界面会自动改变。 
  - 打开开发者模式的console，来试一下 

```vue
<body>
<div id="app">
    <ul>
        <li v-for="item in movies">{{item}}</li>
    </ul>
</div>
<script src="../js/vue.js"></script>
<script>
    const app = new Vue({
        el: '#app',
        data: {
            message: '你好啊',
            movies: ['星际穿越', '大话西游', '少年派', '盗梦空间']
        }
    })
</script>
</body>

```

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615538328639-e7fda7d0-66eb-4582-93f0-a2d398dd9c07.png)

- Vue计数器小案例

  - 事件监听: click -> methods

  - 新的属性：methods，该属性用于在Vue对象中定义方法。
  -  新的指令：@click, 该指令用于监听某个元素的点击事件，并且需要指定当发生点击时，执行的方法(方法通常是methods中定义的方法) 


```vue
<body>
<div id="app">
    <h2>当前计数: {{counter}}</h2>
    <!--<button v-on:click="counter++">+</button>-->
    <!--<button v-on:click="counter--;">-</button>-->
    <button v-on:click="add">+</button>
    <button v-on:click="sub">-</button>
    <!--下面是语法糖写法-->
    <!--<button @click="sub">-</button>-->
</div>
<script src="../js/vue.js"></script>
<script>
    // 语法糖: 简写
    // proxy
    const obj = {
        counter: 0,
        message: 'abc'
    }
    new Vue()
    const app = new Vue({
        el: '#app',
        data: obj,
        methods: {
            add: function () {
                console.log('add被执行');
                this.counter++
            },
            sub: function () {
                console.log('sub被执行');
                this.counter--
            }
        },
        beforeCreate: function () {
        },
        created: function () {
            console.log('created');
        },
        mounted: function () {
            console.log('mounted');
        }
    })
    // 1.拿button元素
    // 2.添加监听事件
</script>
</body>
```

### Vue中的MVVM

>  https://zh.wikipedia.org/wiki/MVVM 

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615539695099-d22c1827-3bff-4ac6-9344-462a9dea7c30.png)

- View层： 

  - 视图层 在我们前端开发中，通常就是DOM层。
  - 主要的作用是给用户展示各种信息。

- Model层： 

  - 数据层 数据可能是我们固定的死数据，更多的是来自我们服务器，从网络上请求下来的数据。
  - 在我们计数器的案例中，就是后面抽取出来的obj，当然，里面的数据可能没有这么简单。

- VueModel层： 

  - 视图模型层 
  - 视图模型层是View和Model沟通的桥梁。
  - 一方面它实 现了Data Binding，也就是数据绑定，将Model的改变实时的反应到View中 
  - 另一方面它实现了DOM Listener，也就是DOM监听，当DOM发生一些事件(点击、滚动、touch等)时，可以监听到，并在需要的情况下改变对应的Data。 



### 创建Vue时, options可以放那些东西

- el:

  - 类型：string | HTMLElement 

  - 作用：决定之后Vue实例会管理哪一个DOM。

- data:

  - 类型：Object | Function （组件当中data必须是一个函数） 
  - 作用：Vue实例对应的数据对象。 

- methods:

  - 类型：{ [key: string]: Function } 
  - 作用：定义属于Vue的一些方法，可以在其他地方调用，也可以在指令中使用。

### 生命周期函数

- ![](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615540947431-06134faa-ba9b-40b9-8915-0a0923bbdb5f.png)



![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615542000768-d0918fec-feca-43e8-a7d6-2cf149a3a7fb.png)

## 二、插值语法

### mustache语法

​	Mustache语法(也就是双大括号)。

​	Mustache: 胡子/胡须. 

```vue
<div id="app">
  <h2>{{message}}</h2>
  <h2>{{message}}, 李银河!</h2>

  <!--mustache语法中,不仅仅可以直接写变量,也可以写简单的表达式-->
  <h2>{{firstName + lastName}}</h2>
  <h2>{{firstName + ' ' + lastName}}</h2>
  <h2>{{firstName}} {{lastName}}</h2>
  <h2>{{counter * 2}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      firstName: 'kobe',
      lastName: 'bryant',
      counter: 100
    },
  })
</script>
```

### v-once

- 该指令后面不需要跟任何表达式(比如之前的v-for后面是由跟表达式的) 

- 该指令表示元素和组件(组件后面才会学习)只渲染一次，不会随着数据的改变而改变。

```vue
<div id="app">
  <h2>{{message}}</h2>
  <h2 v-once>{{message}}</h2>
</div>
```

###  v-html

- 该指令后面往往会跟上一个string类型 

- 会将string的html解析出来并且进行渲染 

```vue
<div id="app">
  <h2>{{url}}</h2>
  <h2 v-html="url"></h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      url: '<a href="http://www.baidu.com">百度一下</a>'
    }
  })
</script>
```

### v-text

- v-text作用和Mustache比较相似：都是用于将数据显示在界面中 

- v-text通常情况下，接受一个string类型 

```vue
<div id="app">
  <h2>{{message}}, 李银河!</h2>
  <h2 v-text="message">, 李银河!</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊'
    }
  })
</script>
```

### v-pre: {{}}

- v-pre用于跳过这个元素zz和它子元素的编译过程，用于显示原本的Mustache语法。跳过大量没有指令的节点会加快编译。

```vue
<div id="app">
  <h2>{{message}}</h2>
  <h2 v-pre>{{message}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊'
    }
  })
</script>
```

### v-cloak: 斗篷

- 在某些情况下，我们浏览器可能会直接显示出未编译的Mustache标签。 
- 这个指令保持在元素上直到关联实例结束编译。和 CSS 规则如 `[v-cloak] { display: none }` 一起用时，这个指令可以隐藏未编译的 Mustache 标签直到实例准备完毕。

```vue
  <style>
    [v-cloak] {
      display: none;
    }
  </style>
<div id="app" v-cloak>
  <h2>{{message}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  // 在vue解析之前, div中有一个属性v-cloak
  // 在vue解析之后, div中没有一个属性v-cloak
  setTimeout(function () {
    const app = new Vue({
      el: '#app',
      data: {
        message: '你好啊'
      }
    })
  }, 1000)
</script>
```

## 三、v-bind

- 作用：动态绑定属性 
- 缩写：**:** 
- 预期：any (with argument) | Object (without argument)
-  参数：attrOrProp (optional) 

### v-bind绑定基本属性

- v-bind:src
- :href
- 动态参数的缩写 (2.6.0+) ——\<a :[key]="url"> ... \</a>

```vue
<div id="app">
  <!-- 错误的做法: 这里不可以使用mustache语法-->
  <!--<img src="{{imgURL}}" alt="">-->
  <!-- 正确的做法: 使用v-bind指令 -->
  <img v-bind:src="imgURL" alt="">
  <a v-bind:href="aHref">百度一下</a>
  <!--<h2>{{}}</h2>-->

  <!--语法糖的写法-->
  <img :src="imgURL" alt="">
  <a :href="aHref">百度一下</a>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      imgURL: 'https://img11.360buyimg.com/mobilecms/s350x250_jfs/t1/20559/1/1424/73138/5c125595E3cbaa3c8/74fc2f84e53a9c23.jpg!q90!cc_350x250.webp',
      aHref: 'http://www.baidu.com'
    }
  })
</script>
```

### v-bind动态绑定class

- 对象语法:  class后面跟的是一个对象。 作业 :class='{类名: boolean}'
- 数组语法:  class后面跟的是一个数组。 

```vue
<head>
  <meta charset="UTF-8">
  <title>Title</title>

  <style>
    .active {
      color: red;
    }
  </style>
</head>
<body>

<div id="app">
  <!--<h2 class="active">{{message}}</h2>-->
  <!--<h2 :class="active">{{message}}</h2>-->

  <!--<h2 v-bind:class="{key1: value1, key2: value2}">{{message}}</h2>-->
  <!--<h2 v-bind:class="{类名1: true, 类名2: boolean}">{{message}}</h2>-->
  <h2 class="title" v-bind:class="{active: isActive, line: isLine}">{{message}}</h2>
  <h2 class="title" v-bind:class="getClasses()">{{message}}</h2>
  <button v-on:click="btnClick">按钮</button>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      isActive: true,
      isLine: true
    },
    methods: {
      btnClick: function () {
        this.isActive = !this.isActive
      },
      getClasses: function () {
        return {active: this.isActive, line: this.isLine}
      }
    }
  })
</script>

</body>
```

####  

```vue
<div id="app">
  <h2 class="title" :class="[active, line]">{{message}}</h2>
  <h2 class="title" :class="getClasses()">{{message}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      active: 'aaaaaa',
      line: 'bbbbbbb'
    },
    methods: {
      getClasses: function () {
        return [this.active, this.line]
      }
    }
  })
</script>
```

### v-bind动态绑定style

- 对象语法:
- 数组语法:

```vue
<div id="app">
  <!--<h2 :style="{key(属性名): value(属性值)}">{{message}}</h2>-->

  <!--'50px'必须加上单引号, 否则是当做一个变量去解析-->
  <!--<h2 :style="{fontSize: '50px'}">{{message}}</h2>-->

  <!--finalSize当成一个变量使用-->
  <!--<h2 :style="{fontSize: finalSize}">{{message}}</h2>-->
  <h2 :style="{fontSize: finalSize + 'px', backgroundColor: finalColor}">{{message}}</h2>
  <h2 :style="getStyles()">{{message}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      finalSize: 100,
      finalColor: 'red',
    },
    methods: {
      getStyles: function () {
        return {fontSize: this.finalSize + 'px', backgroundColor: this.finalColor}
      }
    }
  })
  
  
  
</script>
<div id="app">
  <h2 :style="[baseStyle, baseStyle1]">{{message}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      baseStyle: {backgroundColor: 'red'},
      baseStyle1: {fontSize: '100px'},
    }
  })
</script>
```

## 四. 计算属性

### 概述

在某些情况，我们可能需要对数据进行一些转化后再显示，或者需要将多个数据结合起来进行显示

案例一: firstName+lastName

- 将上面的代码换成计算属性

```vue
<div id="app">
  <h2>{{firstName + ' ' + lastName}}</h2>
  <h2>{{firstName}} {{lastName}}</h2>

  <h2>{{getFullName()}}</h2>

  <h2>{{fullName}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      firstName: 'Lebron',
      lastName: 'James'
    },
    // computed: 计算属性()
    computed: {
      fullName: function () {
        return this.firstName + ' ' + this.lastName
      }
    },
    methods: {
      getFullName() {
        return this.firstName + ' ' + this.lastName
      }
    }
  })
</script>
```

案例二: books -> price

- 复杂的操作

```vue
<div id="app">
  <h2>总价格: {{totalPrice}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      books: [
        {id: 110, name: 'Unix编程艺术', price: 119},
        {id: 111, name: '代码大全', price: 105},
        {id: 112, name: '深入理解计算机原理', price: 98},
        {id: 113, name: '现代操作系统', price: 87},
      ]
    },
    computed: {
      totalPrice: function () {
        let result = 0
        for (let i=0; i < this.books.length; i++) {
          result += this.books[i].price
        }
        return result

        // for (let i in this.books) {
        //   this.books[i]
        // }
        //
        // for (let book of this.books) {
        //
        // }
      }
    }
  })
</script>
```

### setter和getter

- setter方法一般不需要实现
- 所以有更简便的写法`属性名: function () { }`，此处的方法相当于getter方法，因此调用时可以直接`{{属性名}}`，而不需要`{{属性名（）}}`

```vue
<div id="app">
  <h2>{{fullName}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      firstName: 'Kobe',
      lastName: 'Bryant'
    },
    computed: {
      // fullName: function () {
      //   return this.firstName + ' ' + this.lastName
      // }
      // name: 'coderwhy'
      // 计算属性一般是没有set方法, 只读属性.
      fullName: {
        set: function(newValue) {
          // console.log('-----', newValue);
          const names = newValue.split(' ');
          this.firstName = names[0];
          this.lastName = names[1];
        },
        get: function () {
          return this.firstName + ' ' + this.lastName
        }
      },

      // fullName: function () {
      //   return this.firstName + ' ' + this.lastName
      // }
    }
  })
</script>
```

### 计算属性的缓存

**计算属性与Methods的对比**

```vue
<div id="app">
  <!--1.直接拼接: 语法过于繁琐-->
  <h2>{{firstName}} {{lastName}}</h2>

  <!--2.通过定义methods-->
  <!--<h2>{{getFullName()}}</h2>-->
  <!--<h2>{{getFullName()}}</h2>-->
  <!--<h2>{{getFullName()}}</h2>-->
  <!--<h2>{{getFullName()}}</h2>-->

  <!--3.通过computed-->
  <h2>{{fullName}}</h2>
  <h2>{{fullName}}</h2>
  <h2>{{fullName}}</h2>
  <h2>{{fullName}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  // angular -> google
  // TypeScript(microsoft) -> ts(类型检测)
  // flow(facebook) ->
  const app = new Vue({
    el: '#app',
    data: {
      firstName: 'Kobe',
      lastName: 'Bryant'
    },
    methods: {
      getFullName: function () {
        console.log('getFullName');
        return this.firstName + ' ' + this.lastName
      }
    },
    computed: {
      fullName: function () {
        console.log('fullName');
        return this.firstName + ' ' + this.lastName
      }
    }
  })
```

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615782035472-e4750e97-7cbd-4599-8997-06586825eb1e.png)

计算属性会进行缓存，如果多次使用时，计算属性只会调用一次。



## 五.ES6补充

### let/var 

- 事实上var的设计可以看成JavaScript语言设计上的错误. 但是这种错误多半不能修复和移除, 以为需要向后兼容.

  - 大概十年前, Brendan Eich就决定修复这个问题, 于是他添加了一个新的关键字: let. 
  - 我们可以将let看成更完美的var 

- 块级作用域 

  - JS中使用var来声明一个变量时, 变量的作用域主要是和函数的定义有关，var没有块级作用域 
  - 针对于其他块定义来说是没有作用域的，比如if/for等，这在我们开发中往往会引起一些问题。 
  - ES5只有function有作用域

```vue
<button>按钮1</button>
<button>按钮2</button>
<button>按钮3</button>
<button>按钮4</button>
<button>按钮5</button>

<script>
  // ES5中的var是没有块级作用域的(if/for)
  // ES6中的let是由块级作用的(if/for)

  // ES5之前因为if和for都没有块级作用域的概念, 所以在很多时候, 我们都必须借助于function的作用域来解决应用外面变量的问题.
  // ES6中,加入了let, let它是有if和for的块级作用域.
  // 1.变量作用域: 变量在什么范围内是可用.
  // {
  //   var name = 'why';
  //   console.log(name);
  // }
  // console.log(name);

  // 2.没有块级作用域引起的问题: if的块级
  // var func;
  // if (true) {
  //   var name = 'why';
  //   func = function () {
  //     console.log(name);
  //   }
  //   // func()
  // }
  // name = 'kobe'
  // func()
  // // console.log(name);

  var name = 'why'
  function abc(bbb) { // bbb = 'why'
    console.log(bbb);
  }
  abc(name)
  name = 'kobe'

  // 3.没有块级作用域引起的问题: for的块级
  // 为什么闭包可以解决问题: 函数是一个作用域.
  // var btns = document.getElementsByTagName('button');
  // for (var i=0; i<btns.length; i++) {
  //   (function (num) { // 0
  //     btns[i].addEventListener('click', function () {
  //       console.log('第' + num + '个按钮被点击');
  //     })
  //   })(i)
  // }

  const btns = document.getElementsByTagName('button')
  for (let i = 0; i < btns.length; i++) {
    btns[i].addEventListener('click', function () {
      console.log('第' + i + '个按钮被点击');
    })
  }
  // ES5
  // var i = 5
  // {
  //   btns[i].addEventListener('click', function () {
  //   console.log('第' + i + '个按钮被点击');
  // })
  // }
  //
  // {
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  //
  //
  // {
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  //
  //
  // {
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  //
  // {
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  //
  // // ES6
  // { i = 0
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  //
  // { i = 1
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  // { i = 2
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  // { i = 3
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }
  // { i = 4
  //   btns[i].addEventListener('click', function () {
  //     console.log('第' + i + '个按钮被点击');
  //   })
  // }

</script>
```

### const的使用 

当我们修饰的标识符不会被再次赋值时, 就可以使用const来保证数据的安全性。

建议: 在ES6开发中,优先使用const, 只有需要改变某一个标识符的时候才使用let。

const的注意 

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615812552352-78ae5c19-ad10-48c2-bed5-af7b4005e284.png)

```vue
<script>
  // 1.注意一: 一旦给const修饰的标识符被赋值之后, 不能修改
  // const name = 'why';
  // name = 'abc';

  // 2.注意二: 在使用const定义标识符,必须进行赋值
  // const name;

  // 3.注意三: 常量的含义是指向的对象不能修改, 但是可以改变对象内部的属性.
  const obj = {
    name: 'why',
    age: 18,
    height: 1.88
  }
  // obj = {}
  console.log(obj);

  obj.name = 'kobe';
  obj.age = 40;
  obj.height = 1.87;

  console.log(obj);
</script>
```

### 对象增强写法 

ES6中，对对象字面量进行了很多增强。 

属性初始化简写和方法的简写： 

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615813017351-2c7092e5-ebaf-461c-bbf3-b6b930496011.png)

```vue
<script>
  // const obj = new Object()

  // const obj = {
  //   name: 'why',
  //   age: 18,
  //   run: function () {
  //     console.log('在奔跑');
  //   },
  //   eat: function () {
  //     console.log('在次东西');
  //   }
  // }

  // 1.属性的增强写法
  const name = 'why';
  const age = 18;
  const height = 1.88

  // ES5的写法
  // const obj = {
  //   name: name,
  //   age: age,
  //   height: height
  // }

  // const obj = {
  //   name,
  //   age,
  //   height,
  // }
  //
  // console.log(obj);


  // 2.函数的增强写法
  // ES5的写法
  // const obj = {
  //   run: function () {
  //
  //   },
  //   eat: function () {
  //
  //   }
  // }
  const obj = {
    run() {

    },
    eat() {

    }
  }
</script>
```

## 六、事件监听

在前端开发中，我们需要经常和用于交互。 这个时候，我们就必须监听用户发生的时间，比如点击、拖拽、键盘事件等等 在Vue中如何监听事件呢？使用v-on指令 

- v-on介绍 

  - 作用：绑定事件监听器 
  - 缩写：@ 
  - 预期：Function | Inline Statement | Object 
  - 参数：event 

### v-on基础

- v-on的使用 

  - 下面的代码中，我们使用了v-on:click="counter++” 
  - ![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615814316318-c0bc9741-67bb-4df6-9557-63e838cdaabe.png)
  - 另外，我们可以将事件指向一个在methods中定义的函数

```vue
<div id="app">
  <h2>{{counter}}</h2>
  <!--<h2 v-bind:title></h2>-->
  <!--<h2 :title></h2>-->
  <!--<button v-on:click="counter++">+</button>-->
  <!--<button v-on:click="counter&#45;&#45;">-</button>-->
  <!--<button v-on:click="increment">+</button>-->
  <!--<button v-on:click="decrement">-</button>-->
  <button @click="increment">+</button>
  <button @click="decrement">-</button>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      counter: 0
    },
    methods: {
      increment() {
        this.counter++
      },
      decrement() {
        this.counter--
      }
    }
  })
</script>
```

- v-on也有对应的语法糖： 

  - v-on:click可以写成@click 
  - ![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615814464262-20fd58c9-9c3c-4045-a3ba-f7dd946e1f73.png)

### v-on参数 

- 当通过methods中定义方法，以供@click调用时，需要注意参数问题： 

- 情况一：如果该方法不需要额外参数，那么方法后的()可以不添加。 

  - 但是注意：如果方法本身中有一个参数，那么会默认将原生事件event参数传递进去 

- 情况二：如果需要同时传入某个参数，同时需要event时，可以通过$event传入事件。

```vue
<div id="app">
  <!--1.事件调用的方法没有参数-->
  <button @click="btn1Click()">按钮1</button>
  <button @click="btn1Click">按钮1</button>

  <!--2.在事件定义时, 写方法时省略了小括号, 但是方法本身是需要一个参数的,
    这个时候, Vue会默认将浏览器生产的event事件对象作为参数传入到方法-->
  <!--<button @click="btn2Click(123)">按钮2</button>-->
  <!--<button @click="btn2Click()">按钮2</button>-->
  <button @click="btn2Click">按钮2</button>

  <!--3.方法定义时, 我们需要event对象, 同时又需要其他参数-->
  <!-- 在调用方式, 如何手动的获取到浏览器参数的event对象: $event-->
  <button @click="btn3Click(abc, $event)">按钮3</button>
</div>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      abc: 123
    },
    methods: {
      btn1Click() {
        console.log("btn1Click");
      },
      btn2Click(event) {
        console.log('--------', event);
      },
      btn3Click(abc, event) {
        console.log('++++++++', abc, event);
      }
    }
  })

  // 如果函数需要参数,但是没有传入, 那么函数的形参为undefined
  // function abc(name) {
  //   console.log(name);
  // }
  //
  // abc()
</script>
```

### v-on修饰符

- 在某些情况下，我们拿到event的目的可能是进行一些事件处理。

-  Vue提供了修饰符来帮助我们方便的处理一些事件：

   -  .stop - 调用 event.stopPropagation()。 
   -  .prevent - 调用 event.preventDefault()。 
   -  .{keyCode | keyAlias} - 只当事件是从特定键触发时才触发回调。
   -  .native - 监听组件根元素的原生事件。 
   -  .once - 只触发一次回调。 
   -  .passive

   ````vue
   <!-- 阻止单击事件继续传播 -->
   <a v-on:click.stop="doThis"></a>
   
   <!-- 提交事件不再重载页面 -->
   <form v-on:submit.prevent="onSubmit"></form>
   
   <!-- 修饰符可以串联 -->
   <a v-on:click.stop.prevent="doThat"></a>
   
   <!-- 只有修饰符 -->
   <form v-on:submit.prevent></form>
   
   <!-- 添加事件监听器时使用事件捕获模式 -->
   <!-- 即内部元素触发的事件先在此处理，然后才交由内部元素进行处理 -->
   <div v-on:click.capture="doThis">...</div>
   
   <!-- 只当在 event.target 是当前元素自身时触发处理函数 -->
   <!-- 即事件不是从内部元素触发的 -->
   <div v-on:click.self="doThat">...</div>
   
   <!-- 滚动事件的默认行为 (即滚动行为) 将会立即触发 -->
   <!-- 而不会等待 `onScroll` 完成  -->
   <!-- 这其中包含 `event.preventDefault()` 的情况 -->
   <div v-on:scroll.passive="onScroll">...</div>
   
   ````

   -  使用修饰符时，顺序很重要；相应的代码会以同样的顺序产生。因此，用 `v-on:click.prevent.self` 会阻止**所有的点击**，而 `v-on:click.self.prevent` 只会阻止对元素自身的点击。
   -  不要把 `.passive` 和 `.prevent` 一起使用，因为 `.prevent` 将会被忽略，同时浏览器可能会向你展示一个警告。请记住，`.passive` 会告诉浏览器你*不*想阻止事件的默认行为。
   -  为了在必要的情况下支持旧浏览器，Vue 提供了绝大多数常用的按键码的别名：
      - `.enter`
      - `.tab`
      - `.delete` (捕获“删除”和“退格”键)
      - `.esc`
      - `.space`
      - `.up`
      - `.down`
      - `.left`
      - `.right`
   -  ![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1615816022194-7862234d-99d9-4d08-bbf2-44d881b62396.png)

```vue
<div id="app">
  <!--1. .stop修饰符的使用-->
  <div @click="divClick">
    aaaaaaa
    <button @click.stop="btnClick">按钮</button>
  </div>

  <!--2. .prevent修饰符的使用-->
  <br>
  <form action="baidu">
    <input type="submit" value="提交" @click.prevent="submitClick">
  </form>

  <!--3. .监听某个键盘的键帽-->
  <input type="text" @keyup.enter="keyUp">

  <!--4. .once修饰符的使用-->
  <button @click.once="btn2Click">按钮2</button>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊'
    },
    methods: {
      btnClick() {
        console.log("btnClick");
      },
      divClick() {
        console.log("divClick");
      },
      submitClick() {
        console.log('submitClick');
      },
      keyUp() {
        console.log('keyUp');
      },
      btn2Click() {
        console.log('btn2Click');
      }
    }
  })
</script>
```

## 七、条件和循环

### v-if、v-else-if、v-else 

- v-if、v-else-if、v-else 

  - 这三个指令与JavaScript的条件语句if、else、else if类似。 
  - Vue的条件指令可以根据表达式的值在DOM中渲染或销毁元素或组件 
- v-if的原理： 

  - v-if后面的条件为false时，对应的元素以及其子元素不会渲染。 
  - 也就是根本没有不会有对应的标签出现在DOM中。 
- 简单的案例演示： 
- ![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1616050075323-a996f072-e8ee-4e9e-bacb-7c18540ef4a5.png)
- ![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1616050085983-590c3302-9bd1-4f72-8cd2-7df969fe87be.png)
- Vue在进行DOM渲染时，出于性能考虑，会尽可能的复用已经存在的元素，而不是重新创建新的元素。
- 如果我们不希望Vue出现类似重复利用的问题，可以给对应的input添加key 并且我们需要保证key的不同 

### v-show 

- v-if和v-show对比 

  - v-if和v-show都可以决定一个元素是否渲染
    - v-if当条件为false时，压根不会有对应的元素在DOM中。 
    - v-show当条件为false时，仅仅是将元素的display属性设置为none而已。 

  - 当需要在显示与隐藏之间切片很频繁时，使用v-show 当只有一次切换时，通过使用v-if 

### v-for

**v-for遍历数组**

```vue
<!--1.在遍历的过程中,没有使用索引值(下标值)-->
  <ul>
    <li v-for="item in names">{{item}}</li>
  </ul>

  <!--2.在遍历的过程中, 获取索引值-->
  <ul>
    <li v-for="(item, index) in names">
      {{index+1}}.{{item}}
    </li>
  </ul>
```

**v-for可以用户遍历对象**

```vue
<div id="app">
  <!--1.在遍历对象的过程中, 如果只是获取一个值, 那么获取到的是value-->
  <ul>
    <li v-for="item in info">{{item}}</li>
  </ul>

  <!--2.获取key和value 格式: (value, key) -->
  <ul>
    <li v-for="(value, key) in info">{{value}}-{{key}}</li>
  </ul>

  <!--3.获取key和value和index 格式: (value, key, index) -->
  <ul>
    <li v-for="(value, key, index) in info">{{value}}-{{key}}-{{index}}</li>
  </ul>
</div>
```

- 官方推荐我们在使用v-for时，给对应的元素或组件添加上一个**:key属性**

- 当某一层有很多相同的节点时，也就是列表节点时，我们希望插入一个新的节点 

  - 我们希望可以在B和C之间加一个F，Diff算法默认执行起来是这样的。 
  - 即把C更新成F，D更新成C，E更新成D，最后再插入E，效率低

- 所以我们需要使用key来给每个节点做一个唯一标识 

  - Diff算法就可以正确的识别此节点 
  - 找到正确的位置区插入新的节点。 

- 所以一句话，key的作用主要是为了高效的更新虚拟DOM。 



### 检测数组更新

因为Vue是响应式的，所以当数据发生变化时，Vue会自动检测数据变化，视图会发生对应的更新。 

Vue中包含了一组观察数组编译的方法，使用它们改变数组也会触发视图的更新。 

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1616054963368-a2010992-d3e3-4f02-b62c-24d8138631d6.png)

```vue
<div id="app">
  <ul>
    <li v-for="item in letters">{{item}}</li>
  </ul>
  <button @click="btnClick">按钮</button>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      letters: ['a', 'b', 'c', 'd']
    },
    methods: {
      btnClick() {
        // 1.push方法
        // this.letters.push('aaa')
        // this.letters.push('aaaa', 'bbbb', 'cccc')

        // 2.pop(): 删除数组中的最后一个元素
        // this.letters.pop();

        // 3.shift(): 删除数组中的第一个元素
        // this.letters.shift();

        // 4.unshift(): 在数组最前面添加元素
        // this.letters.unshift()
        // this.letters.unshift('aaa', 'bbb', 'ccc')

        // 5.splice作用: 删除元素/插入元素/替换元素
        // 删除元素: 第二个参数传入你要删除几个元素(如果没有传,就删除后面所有的元素)
        // 替换元素: 第二个参数, 表示我们要替换几个元素, 后面是用于替换前面的元素
        // 插入元素: 第二个参数, 传入0, 并且后面跟上要插入的元素
        // splice(start)
        // splice(start):
        this.letters.splice(1, 3, 'm', 'n', 'l', 'x')
        // this.letters.splice(1, 0, 'x', 'y', 'z')

        // 5.sort()
        // this.letters.sort()

        // 6.reverse()
        // this.letters.reverse()

        // 注意: 通过索引值修改数组中的元素
        // this.letters[0] = 'bbbbbb';
        // this.letters.splice(0, 1, 'bbbbbb')
        // set(要修改的对象, 索引值, 修改后的值)
        // Vue.set(this.letters, 0, 'bbbbbb')
      }
    }
  })


  // function sum(num1, num2) {
  //   return num1 + num2
  // }
  //
  // function sum(num1, num2, num3) {
  //   return num1 + num2 + num3
  // }
  // function sum(...num) {
  //   console.log(num);
  // }
  //
  // sum(20, 30, 40, 50, 601, 111, 122, 33)

</script>
```

## 八、表单绑定

表单控件在实际开发中是非常常见的。特别是对于用户信息的提交，需要大量的表单。 

Vue中使用v-model指令来实现表单元素和数据的双向绑定

### v-model基本使用

```vue
<div id="app">
  <input type="text" v-model="message">
  {{message}}
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊'
    }
  })
</script>
```

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1616136029948-679dac9a-dfab-4bff-9610-95239a0aaaae.png)

v-model其实是一个语法糖，它的背后本质上是包含两个操作： 

- 1.v-bind绑定一个value属性
- 2.v-on指令给当前元素绑定input事件 
- 也就是说下面的代码：等同于下面的代码： 
- `<input type="text" v-model="message"> 等同于 `
- `<input type="text" v-bind:value="message" v-on:input="message =$event.target.value"> `

### v-model：radio

当存在多个单选框时 

![image.png](https://note-java.oss-cn-beijing.aliyuncs.com/img/1616136210058-f68e64f0-c504-4e67-a3bf-0bd3fcd33d6c.png)

### v-model：checkbox

复选框分为两种情况：

- 单个勾选框和多个勾选框 
- 单个勾选框：

  - v-model即为布尔值。
  - 此时input的value并不影响v-model的值。

- 多个复选框： 

  - 当是多个复选框时，因为可以选中多个，所以对应的data中属性是一个数组。 
  - 当选中某一个时，就会将input的value添加到数组中。

```vue
<div id="app">
  <!--1.checkbox单选框-->
  <label for="agree">
    <input type="checkbox" id="agree" v-model="isAgree">同意协议
  </label>
  <h2>您选择的是: {{isAgree}}</h2>
  <button :disabled="!isAgree">下一步</button>

  <!--2.checkbox多选框-->
  <input type="checkbox" value="篮球" v-model="hobbies">篮球
  <input type="checkbox" value="足球" v-model="hobbies">足球
  <input type="checkbox" value="乒乓球" v-model="hobbies">乒乓球
  <input type="checkbox" value="羽毛球" v-model="hobbies">羽毛球
  <h2>您的爱好是: {{hobbies}}</h2>

  <label v-for="item in originHobbies" :for="item">
    <input type="checkbox" :value="item" :id="item" v-model="hobbies">{{item}}
  </label>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      isAgree: false, // 单选框
      hobbies: [], // 多选框,
      originHobbies: ['篮球', '足球', '乒乓球', '羽毛球', '台球', '高尔夫球']
    }
  })
</script>
```

### v-model：select 

和checkbox一样，select也分单选和多选两种情况。 

- 单选：只能选中一个值。 

  - v-model绑定的是一个值。 
  - 当我们选中option中的一个时，会将它对应的value赋值到mySelect中 

- 多选：可以选中多个值。 

  - v-model绑定的是一个数组。 
  - 当选中多个值时，就会将选中的option对应的value添加到数组mySelects中 

```vue
<div id="app">
  <!--1.选择一个-->
  <select name="abc" v-model="fruit">
    <option value="苹果">苹果</option>
    <option value="香蕉">香蕉</option>
    <option value="榴莲">榴莲</option>
    <option value="葡萄">葡萄</option>
  </select>
  <h2>您选择的水果是: {{fruit}}</h2>

  <!--2.选择多个-->
  <select name="abc" v-model="fruits" multiple>
    <option value="苹果">苹果</option>
    <option value="香蕉">香蕉</option>
    <option value="榴莲">榴莲</option>
    <option value="葡萄">葡萄</option>
  </select>
  <h2>您选择的水果是: {{fruits}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      fruit: '香蕉',
      fruits: []
    }
  })
</script>
```

### 修饰符

lazy修饰符： 

- 默认情况下，v-model默认是在input事件中同步输入框的数据的。 
- 也就是说，一旦有数据发生改变对应的data中的数据就会自动发生改变。
- lazy修饰符可以让数据在失去焦点或者回车时才会更新： 

number修饰符： 

- 默认情况下，在输入框中无论我们输入的是字母还是数字，都会被当做字符串类型进行处理。
- 但是如果我们希望处理的是数字类型，那么最好直接将内容当做数字处理。 
- number修饰符可以让在输入框中输入的内容自动转成数字类型

trim修饰符： 

- 如果输入的内容首尾有很多空格，通常我们希望将其去除 
- trim修饰符可以过滤内容左右两边的空格 

```vue
<div id="app">
  <!--1.修饰符: lazy-->
  <input type="text" v-model.lazy="message">
  <h2>{{message}}</h2>


  <!--2.修饰符: number-->
  <input type="number" v-model.number="age">
  <h2>{{age}}-{{typeof age}}</h2>

  <!--3.修饰符: trim-->
  <input type="text" v-model.trim="name">
  <h2>您输入的名字:{{name}}</h2>
</div>

<script src="../js/vue.js"></script>
<script>
  const app = new Vue({
    el: '#app',
    data: {
      message: '你好啊',
      age: 0,
      name: ''
    }
  })

  var age = 0
  age = '1111'
  age = '222'
</script>
```

