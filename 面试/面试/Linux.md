1.Linux是什么?（-5）
2.Linux和 Unix 的区别?（-5）
3.Linux 系统有哪些优势?（-5）

### 4.Linux 怎么查看内核版本?

https://www.cnblogs.com/linuxprobe/p/11664104.html

![image-20220320150934981](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20220320150934981.png)

5.RedHat、CentOS、Ubuntu有什么区别?

6.Linux和 Windows 正反斜杠的区别?

Windows：

> “/”是表示参数，“\”是表示本地路径。

Linux：

> “/”表示路径，“\”表示[转义](https://so.csdn.net/so/search?q=转义&spm=1001.2101.3001.7020)，“-”和“–”表示参数。

网络：

> 由于网络使用Unix标准，所以网络路径用“/”。

### 7.Linux 环境变量配置有哪几种方式?

##  export PATH 

```javascript
export PATH=/usr/local/src/python3/bin:$PATH

# 或者把PATH放在前面
export PATH=$PATH:/usr/local/src/python3/bin
```

注意点

- 生效时间：立即生效
- 生效期限：当前打开的终端有效，窗口关闭后无效
- 生效范围：当前登录用户
- 需要加上$PATH，否则会覆盖原有路径

vim /etc/profile

```javascript
# 如果/etc/profile文件不可编辑，需要修改为可编辑
chmod -v u+w /etc/profile

vim /etc/profile

# 在最后一行加上
export PATH=$PATH:/usr/local/src/python3/bin
```

注意点

- 生效时间：使用相同的用户打开新的终端时生效，或者手动  生效

source /etc/profile

- 生效期限：永久有效
- 生效范围：所有用户

### Linux 安装软件有哪几种方式?

https://cloud.tencent.com/developer/article/1529878

### 9.Linux 普通用户怎么以管理员身份执行?

sudo 

### 10.Linux的 root和home目录有什么不同?

~ 是用户的主目录,root用户的主目录是/root，普通用户的主目录是“/home/普通用户名”

1、在root用户下，~等同于/root

2、在普通用户下，~ 等同于  /home/当前的普通用户名

如果我们建立一个用户，用户名是"xx",那么在/home目录下就有一个对应的/home/xx路径，用来存放用户的主目录。root是管理员账号，root文件夹是管理员的主目录，它的配置文件还有root的一些别的东西放在这里。而home是给普通用户的，在home下面有用户名对应的文件夹，这些个文件夹就相当于root文件夹，用来存放对应用户的一些资料，配置。 

### 11.Linux系统 root 和普通用户的区别?

### 12.Linux怎么区分 root和普通用户?

13.Linux 怎么切换用户?

su + 用户名

### 14.Linux中的 bash 是什么?

https://blog.csdn.net/michaelehome/article/details/79878151

### 15.Linux中的 Shell是什么?

 当谈到命令行，实际上指的是shell。shell是一个接收由键盘输入的命令，并将其传递给操作系统来执行的程序。

16.Linux怎么显示目录下的文件?
17.Linux中Ⅱl和ls 命令的区别?
18.Linux 怎么创建文件?（-5）
19.Linux 怎么创建目录?（-5）
20.Linux 怎么切换目录?

| cd 目录 | 切换到指定目录         |
| ------- | ---------------------- |
| cd ~    | 切换到当前用户的主目录 |
| cd …    | 切换到上一级目录       |
| cd .    | 切换到当前目录         |
| cd -    | 切换到上一次目录       |

21.Linux 怎么进入含有空格的目录?

22.Linux 怎么切换到上 N级目录?

### 23.Linux怎么切换到之前所在的目录?

cd -

### 24.Linux怎么切换到当前用户主目录?

cd ~

### 25.Linux 怎么查看当前目录所在路径?

pwd

### 26.Linux 下的权限有哪几种?

1）read：可读取文件的内容，例如读取文本文件的内容。

2）writer：可以编辑、新增或者修改文件的内容，但是不可以删除该文件。这里的修改都是基于文件内容的，文件中记录的数据而言的。

3）execute：该文件可以被系统执行。这个需要注意，因为Linux和Windows系统不一样。在Windows系统下，文件是否可以被执行是通过扩展名来区别的，例如.exe, .bat, .com等，这些文件类型都是可被执行的；而在Linux下，文件是否可以被执行时通过权限x来标注的，和文件名没有绝对的关系。

### 27.Linux 文件调用权限分为哪3级?

文件拥有者、群组、其他

### 28.Linux怎么修改文件权限?

语法

```
chmod [-cfvR] [--help] [--version] mode file...
```

参数说明

mode : 权限设定字串，格式如下 :

```
[ugoa...][[+-=][rwxX]...][,...]
其中：
```

- u 表示该文件的拥有者，g 表示与该文件的拥有者属于同一个群体(group)者，o 表示其他以外的人，a 表示这三者皆是。
- \+ 表示增加权限、- 表示取消权限、= 表示唯一设定权限。
- r 表示可读取，w 表示可写入，x 表示可执行，X 表示只有当该文件是个子目录或者该文件已经被设定过为可执行。

29.Linux怎么修改文件所有者和所属组?

http://c.biancheng.net/view/761.html

### 30.Linux怎么查看磁盘的使用情况?

https://www.runoob.com/w3cnote/linux-view-disk-space.html

### 31.Linux怎么查看内存的使用情况?

free

![image-20220320172405696](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20220320172405696.png)

total:总计物理内存的大小

used:已使用多大

free:可用有多少

shared:多个进程共享的内存总额

buff/cached:磁盘缓存的大小

### 32.Linux怎么查看资源消耗最多的进程?

https://linux.cn/article-4743-1.html

ps [选项]
下面对命令选项进行说明：
-e  显示所有进程。
-f  全格式。
-h  不显示标题。
-l  长格式。
-w 宽输出。
a   显示终端上的所有进程，包括其他用户的进程。
r   只显示正在运行的进程。
u 　以用户为主的格式来显示程序状况。
x   显示所有程序，不以终端机来区分。

![image-20220320184957536](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20220320184957536.png)

ps -ef 显示出的结果：

  1.UID    用户ID
  2.PID     进程ID
  3.PPID    父进程ID
  4.C      CPU占用率
  5.STIME   开始时间
  6.TTY     开始此进程的TTY----终端设备
  7.TIME    此进程运行的总时间
  8.CMD    命令名

![image-20220320185318683](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20220320185318683.png)

同ps -ef 不同的有列有
USER   //用户名
%CPU   //进程占用的CPU百分比
%MEM   //占用内存的百分比
VSZ   //该进程使用的虚拟內存量（KB）
RSS   //该进程占用的固定內存量（KB）（驻留中页的数量）
STAT   //进程的状态
START  //该进程被触发启动时间
TIME   //该进程实际使用CPU运行的时间

### 33.Linux怎么看端口被哪个进程占用?

https://www.runoob.com/w3cnote/linux-check-port-usage.html![image-20220320190922128](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20220320190922128.png)

### 34.Linux 怎么查找某个进程?

### 35.Linux 怎么结束某个进程?

https://www.runoob.com/linux/linux-comm-kill.html

Linux 怎么清屏?（-5）

37.Linux控制台怎么设置超时自动注销?（-10

38.Linux vim和 vi命令的区别?（-5）

39.Linux vim 命令怎么使用?（-5）

40.Linux中的链接有哪几种形式?

41.Linux 中的两种链接的区别?（-5）

1. Linux 怎么创建硬链接?（-5）
2. Linux 怎么创建软链接?（-5）
   44.Linux 中的零拷贝是指什么?（-10）
   45.Linux有哪几种IO 模型?（-10）
   46.Linux有哪几种 IO 多路复用机制?（-10）
   47.Linux下select，poll，epoll的区别?（-10）

# 文件查找

四个命令

https://www.jb51.net/article/127577.htm	