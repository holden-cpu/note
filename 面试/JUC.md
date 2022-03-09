## 并发编程

### 1.进程和线程的区别?

**进程：**是程序运行和资源分配的基本单位，一个程序至少有一个进程，一个进程至少有一个线程。进程在执行过程中拥有独立的内存单元，而多个线程共享内存资源，减少切换次数，从而效率更高。

**资源** 包括用于存放程序正文、数据的磁盘和内存地址空间，以及在运行时所需要的I/O设备，已打开的文件，信号量等

**线程：**是进程的一个实体，是 cpu 调度和分派的基本单位，是比程序更小的能独立运行的基本单位。同一进程中的多个线程之间可以并发执行。

区别：

进程<font color='red'>是资源分配的基本单位</font>。所有与该进程有关的资源，都被记录在<font color='red'>进程控制块PCB</font>中。以表示该进程拥有这些资源或正在使用它们。另外，进程也是抢占处理机的调度单位，它拥有一个完整的虚拟地址空间。当进程发生调度时，不同的进程拥有不同的虚拟地址空间，而同一进程内的不同线程共享同一地址空间。

与进程相对应，线程与资源分配无关，它属于某一个进程，是<font color='red'>程序执行的基本单位</font>，并与进程内的其他线程一起共享进程的资源。

联系：

- 进程是资源的容器，包含（一个或）多个线程。
- 内核调度的基本单位是线程、而非进程。
- 同一进程下的各个线程共享资源（address space、open files、signal handlers，etc），但寄存器、栈、PC等不共享

1. 并行是指两个或者多个事件在同一时刻发生；而并发是指两个或多个事件在同一时间间隔发生；
2. 并行是在不同实体上的多个事件，并发是在同一实体上的多个事件；
3. 在一台处理器上“同时”处理多个任务，在多台处理器上同时处理多个任务。如 Hadoop 分布式集群。所以并发编程的目标是充分的利用处理器的每一个核，以达到最高的处理性能。

#### [线程共享进程的那些资源？](https://www.cnblogs.com/neo-01/p/7663531.html)

**线程共享的环境包括：**进程代码段、进程的公有数据(利用这些共享的数据，线程很容易的实现相互之间的通讯)、进程打开的文件描述符、信号的处理器、进程的当前目录和进程用户ID与进程组ID。

**进程拥有这许多共性的同时，还拥有自己的个性。有了这些个性，线程才能实现并发性。这些个性包括：**
1.线程ID
每个线程都有自己的线程ID，这个ID在本进程中是唯一的。进程用此来标识线程。
2.寄存器组的值
由于线程间是并发运行的，每个线程有自己不同的运行线索，当从一个线程切换到另一个线程上时，必须将原有的线程的寄存器集合的状态保存，以便将来该线程在被重新切换到时能得以恢复。
3.线程的栈
栈是保证线程独立运行所必须的。线程函数可以调用函数，而被调用函数中又是可以层层嵌套的，所以线程必须拥有自己的函数堆栈，使得函数调用可以正常执行，不受其他线程的影响。
4.错误返回码
由于同一个进程中有很多个线程在同时运行，可能某个线程进行系统调用后设置了errno值，而在该线程还没有处理这个错误，另外一个线程就在此时被调度器投入运行，这样错误值就有可能被修改。所以，不同的线程应该拥有自己的错误返回码变量。
5.线程的信号屏蔽码
由于每个线程所感兴趣的信号不同，所以线程的信号屏蔽码应该由线程自己管理。但所有的线程都 共享同样的信号处理器。
6.线程的优先级
由于线程需要像进程那样能够被调度，那么就必须要有可供调度使用的参数，这个参数就是线程的优先级

### 2.什么是原子性?

原子性是指**一个操作是不可中断的，要么全部执行成功要么全部执行失败**

### 3.什么是可见性?

可见性是指当一个线程修改了共享变量后，其他线程能够立即得知这个修改。

### 4.什么是有序性?

如果在被线程内观察，所有操作都是有序的；如果在一个线程中观察另一个线程，所有操作都是无序的。前半句指“线程内表现为串行的语义”，后半句是指“指令重排”现象和“工作内存与主内存同步延迟”现象。Java 语言通过 volatile 和 synchronize 两个关键字来保证线程之间操作的有序性。volatile 自身就禁止指令重排，而 synchronize 则是由“一个变量在同一时刻指允许一条线程对其进行 lock 操作”这条规则获得，这条规则决定了持有同一个锁的两个同步块只能串行的进入。

### 5.为什么要使用多线程?

现代的计算机伴随着多核CPU的出现，也就意味着不同的线程能被不同的CPU核得到真正意义的并行执行。

使用多线程就是在正确的场景下通过设置正确个数的线程来最大化程序的运行速度。

- 充分的利用 CPU 和 I/O 的利用率
- 合理的场景+合理的线程数 得到运行效率的提升。
- 充分发挥多核CPU的性能

### 6.创建线程有哪几种方式?

new Thread（）和线程池。

1. 继承 Thread 类创建线程；
2. 实现 Runnable 接口创建线程；
3. 通过 Callable 和 Future 创建线程；
4. 通过线程池创建线程。

### 7.什么是守护线程?

守护线程（即 Daemon thread），是个服务线程，准确地来说就是服务其他的线程

比如垃圾回收线程，就是最典型的守护线程。

### 8.线程的状态有哪几种?怎么流转的?

Thread类中的内部枚举State

```java
public enum State {
	NEW,
	RUNNABLE,
	BLOCKED,
	WAITING,
	TIMED_WAITING,
	TERMINATED;
}
```

1. 初始(NEW)：新创建了一个线程对象，但还没有调用start()方法。
2. 运行(RUNNABLE)：Java线程中将就绪（ready）和运行中（running）两种状态笼统的称为“运行”。
   线程对象创建后，其他线程(比如main线程）调用了该对象的start()方法。该状态的线程位于可运行线程池中，等待被线程调度选中，获取CPU的使用权，此时处于就绪状态（ready）。就绪状态的线程在获得CPU时间片后变为运行中状态（running）。
3. 阻塞(BLOCKED)：没获取到锁时的阻塞状态
4. 等待(WAITING)：进入该状态的线程需要等待其他线程做出一些特定动作（通知或中断）。调用wait()、join()等方法后的状态
5. 超时等待(TIMED_WAITING)：该状态不同于WAITING，它可以在指定的时间后自行返回。调用 sleep(time)、wait(time)、join(time)等方法后的状态
6. 终止(TERMINATED)：表示该线程已经执行完毕或抛出异常后的状态。

![image-20210707153708037](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210707153708037.png)

### 9.线程的优先级有什么用?

提高指定线程可以抢占资源的概率

### 10.我们常说的 JUC是指什么?

java.util.concurren包

### 11.i++是线程安全的吗?

不是

### 12.怎么让3个线程按顺序执行?

https://blog.csdn.net/Evankaka/article/details/80800081

1. 使用join
2. 使用CountDownLatch
3. 使用ReentrantLock::newCondition()
4. 使用单一化线程池

### 13.join方法有什么用?什么原理?

该线程立马执行，当前线程等待此线程结束后（自动调用 notifyAll()）方可执行。

原理：join() 内部调用的是 wait()

### 14.如何让一个线程休眠?

Thread : : sleep()

### 15.启动一个线程是用start还是run方法?

启动线程使用 start() 方法，线程进入就绪状态。当线程获取 cpu 执行权才会执行 run方法

### 16.一个线程多次调用 start 会发生什么?

同一个线程只能调用start()方法一次，多次调用会抛出java.lang.IllegalThreadStateException。

### 17.start和 run方法有什么区别?

- 启动一个线程需要调用 Thread 对象的 start() 方法
- 调用线程的 start() 方法后，线程处于可运行状态，此时它可以由 JVM 调度并执行，这并不意味着线程就会立即运行
- run() 方法是线程运行时由 JVM 回调的方法，无需手动写代码调用
- 直接调用线程的 run() 方法，相当于在调用线程里继续调用方法，并未启动一个新的线程

### 18.sleep和 wait方法有什么区别?

- sleep() 是 Thread 类的静态本地方法；wait() 是Object类的成员本地方法
- sleep() 方法可以在任何地方使用；wait() 方法则只能在同步方法或同步代码块中使用，否则抛出异常Exception in thread "Thread-0" java.lang.IllegalMonitorStateException
- sleep() 会休眠当前线程指定时间，释放 CPU 资源，不释放对象锁，休眠时间到自动苏醒继续执行；wait() 方法放弃持有的对象锁，进入等待队列，当该对象被调用 notify() / notifyAll() 方法后才有机会竞争获取对象锁，进入运行状态
- JDK1.8 sleep() wait() 均需要捕获 InterruptedException 异常

### 19.Thread.yield方法有什么用?

静态方法 Thread.yield() 的调用声明了当前线程已经完成了生命周期中最重要的部分，可以切换给其它线程来执行。该方法只是对线程调度器的一个建议，而且也只是建议具有相同优先级的其它线程可以运行。

### 20.yield和 sleep有什么区别?

- sleep() 方法给其他线程运行机会时不考虑线程的优先级；yield() 方法只会给相同优先级或更高优先级的线程运行的机会
- 线程执行 sleep() 方法后进入超时等待状态；线程执行 yield() 方法转入就绪状态，可能马上又得得到执行
- sleep() 方法声明抛出 InterruptedException；yield() 方法没有声明抛出异常
- sleep() 方法需要指定时间参数；yield() 方法出让 CPU 的执行权时间由 JVM 控制

### 21.怎么理解 Java 中的线程中断?

使用interrupt()中断线程。调用 interrupt() 方法仅仅是在目标线程中<font color='red'>打一个停止的标记</font>，并不是真的停止线程，仅代表当前线程希望目标线程终止，而目标线程依旧正在运行。

如果该线程处于阻塞、限期等待或者无限期等待状态，那么就会抛出 InterruptedException，从而进入runnable状态。但是不能中断 I/O 阻塞和 synchronized 锁阻塞。

调用 Executor 的 shutdown() 方法会等待线程都执行完毕之后再关闭，但是如果调用的是 shutdownNow() 方法，则相当于调用每个线程的 interrupt() 方法。

以下使用 Lambda 创建线程，相当于创建了一个匿名内部线程。

```java
public static void main(String[] args) {
    ExecutorService executorService = Executors.newCachedThreadPool();
    executorService.execute(() -> {
        try {
            Thread.sleep(2000);
            System.out.println("Thread run");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
    executorService.shutdownNow();
    System.out.println("Main run");
}
```

如果只想中断 Executor 中的一个线程，可以通过使用 submit() 方法来提交一个线程，它会返回一个 Future<?> 对象，通过调用该对象的 cancel(true) 方法就可以中断线程。

```java
Future<?> future = executorService.submit(() -> {
    // ..
});
future.cancel(true);
```

### 22.线程中断与 stop 的区别?

stop 会直接结束线程，并且不会释放锁。

调用 interrupt() 方法仅仅是在目标线程中<font color='red'>打一个停止的标记</font>，让目标线程在合适的时机停止。

### 23.你怎么理解多线程分组?

Java 可以对相同性质的线程进行分组。

线程组使用 java.lang.ThreadGroup 类定义，它有两个构造方法，第二个构造方法允许线程组有父类线程组，也就是说一个线程组可以多个子线程组。

```java
java.lang.ThreadGroup#ThreadGroup(java.lang.String)
java.lang.ThreadGroup#ThreadGroup(java.lang.ThreadGroup, java.lang.String)
```

线程组中比较有用的几个方法。

```java
// 获取当前线程组内的运行线程数
java.lang.ThreadGroup#activeCount

// 中断线程组内的所有线程
java.lang.ThreadGroup#interrupt

// 使用 System.out 打印出所有线程信息
java.lang.ThreadGroup#list()
```

### 24.你怎么理解wait、notify、notifyAl?

| 方法      | 作用                                                         |
| --------- | ------------------------------------------------------------ |
| wait      | 线程自动释放占有的对象锁，并等待notify。                     |
| notify    | 随机唤醒一个正在wait当前对象的线程，并让被唤醒的线程拿到对象锁 |
| notifyAll | 唤醒所有正在wait当前对象的线程，但是被唤醒的线程会再次去竞争对象锁。因为一次只有一个线程能拿到锁，所有其他没有拿到锁的线程会被阻塞。推荐使用。 |

### 25.wait、notify为什么是 Object类的方法?

Java中规定，在调用者三个方法时，当前线程必须获得对象锁。因此就得配合synchronized关键字来使用。

因为每个对象都可以作为synchronized锁的对象，因此wait、notify等必须和对象关联才能配合synchronized使用。

### 26.同步和异步的区别?

- 同步：发送一个请求，等待返回，然后再发送下一个请求 
- 异步：发送一个请求，不等待返回，随时可以再发送下一个请求

**使用场景**

- 如果数据存在线程间的共享，或竞态条件，需要同步。如多个线程同时对同一个变量进行读和写的操作
- 当应用程序在对象上调用了一个需要花费很长时间来执行的方法，并且不希望让程序等待方法的返回时，就可以使用异步，提高效率、加快程序的响应

### 27.什么是死锁?

线程死锁是指由于两个或者多个线程互相持有所需要的资源，导致这些线程一直处于等待其他线程释放资源的状态，无法继续执行，如果线程都不主动释放所占有的资源，将产生死锁。

当线程处于这种僵持状态时，若无外力作用，它们都将无法再向前推进。

**产生原因：**

- 持有系统不可剥夺资源，去竞争其他已被占用的系统不可剥夺资源，形成程序僵死的竞争关系。
- 持有资源的锁，去竞争锁已被占用的其他资源，形成程序僵死的争关系。
- 信号量使用不当。

### 28.怎么避免死锁?

**并发程序一旦死锁，往往我们只能重启应用。解决死锁问题最好的办法就是避免死锁。**

**死锁发生的条件**

- 互斥，共享资源只能被一个线程占用
- 占有且等待，线程 t1 已经取得共享资源 s1，尝试获取共享资源 s2 的时候，不释放共享资源 s1
- 不可抢占，其他线程不能强行抢占线程 t1 占有的资源 s1
- 循环等待，线程 t1 等待线程 t2 占有的资源，线程 t2 等待线程 t1 占有的资源

**避免死锁的方法**

对于以上 4 个条件，只要破坏其中一个条件，就可以避免死锁的发生。

对于第一个条件 "互斥" 是不能破坏的，因为加锁就是为了保证互斥。

其他三个条件，我们可以尝试

- 一次性申请所有的资源，破坏 "占有且等待" 条件
-  占有部分资源的线程进一步申请其他资源时，如果申请不到，主动释放它占有的资源，破坏 "不可抢占" 条件
-  按序申请资源，破坏 "循环等待" 条件 

**编程中的最佳实践：**

- 使用 Lock 的 tryLock(long timeout, TimeUnit unit)的方法，设置超时时间，超时可以退出防止死锁
- 尽量使用并发工具类代替加锁
- 尽量降低锁的使用粒度
- 尽量减少同步的代码块

**示例**

**使用管理类一次性申请所有的资源，破坏 "占有且等待" 条件示例**

```javascript

/**
 * 测试 一次性申请所有的资源，破坏 "占有且等待" 条件示例
 * 
 */
public class TestBreakLockAndWait {

    //单例的资源管理类
    private final static Manger manager = new Manger();
    
    //资源1
    private static Object res1 = new Object();
    
    //资源2
    private static Object res2 = new Object();
    
    public static void main(String[] args) {
        new Thread(() -> {
            boolean applySuccess = false;
            while (!applySuccess) {
                //向管理类，申请res1和res2,申请失败，重试
                applySuccess = manager.applyResources(res1, res2);
                if (applySuccess) {
                    try {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 申请 res1、res2 资源成功");
                        synchronized (res1) {
                            System.out.println("线程：" + Thread.currentThread().getName() + " 获取到 res1 资源的锁");
                            //休眠 1秒
                            try {
                                Thread.sleep(1000);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            synchronized (res2) {
                                System.out.println("线程：" + Thread.currentThread().getName() + " 获取到 res2 资源的锁");
                            }
                        }
                    } finally {
                        manager.returnResources(res1, res2);//归还资源
                    }
                } else {
                    System.out.println("线程：" + Thread.currentThread().getName() + " 申请 res1、res2 资源失败");
                    //申请失败休眠 200 毫秒后重试
                    try {
                        Thread.sleep(200);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();
        
        new Thread(() -> {
            boolean applySuccess = false;
            while (!applySuccess) {
                //向管理类，申请res1和res2,申请失败，重试
                applySuccess = manager.applyResources(res1, res2);
                if (applySuccess) {
                    try {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 申请 res1、res2 资源成功");
                        synchronized (res2) {
                            System.out.println("线程：" + Thread.currentThread().getName() + " 获取到 res1 资源的锁");
                            //休眠 1秒
                            try {
                                Thread.sleep(1000);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            synchronized (res1) {
                                System.out.println("线程：" + Thread.currentThread().getName() + " 获取到 res2 资源的锁");
                            }
                        }
                    } finally {
                        manager.returnResources(res1, res2);//归还资源
                    }
                } else {
                    System.out.println("线程：" + Thread.currentThread().getName() + " 申请 res1、res2 资源失败");
                    //申请失败休眠 200 毫秒后重试
                    try {
                        Thread.sleep(200);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();
        
    }
    
}

/**
 * 资源申请、归还管理类
 * 
 */
class Manger {
    
    //资源存放集合
    private Set<Object> resources = new HashSet<Object>();
    
    /**
     * 申请资源
     * @param res1
     * @param res2
     * @return
     */
    synchronized boolean applyResources(Object res1, Object res2) {
        if (resources.contains(res1) || resources.contains(res1)) {
            return false;
        } else {
            resources.add(res1);
            resources.add(res2);
            return true;
        }
    }
    
    /**
     * 归还资源
     * @param res1
     * @param res2
     */
    synchronized void returnResources(Object res1, Object res2) {
        resources.remove(res1);
        resources.remove(res2);
    }
    
}
```

打印结果如下，线程-1 在线程-0 释放完资源后才能成功申请 res1 和 res2 的锁

```javascript
线程：Thread-0 申请 res1、res2 资源成功
线程：Thread-0 获取到 res1 资源的锁
线程：Thread-1 申请 res1、res2 资源失败
线程：Thread-1 申请 res1、res2 资源失败
线程：Thread-1 申请 res1、res2 资源失败
线程：Thread-1 申请 res1、res2 资源失败
线程：Thread-1 申请 res1、res2 资源失败
线程：Thread-0 获取到 res2 资源的锁
线程：Thread-1 申请 res1、res2 资源失败
线程：Thread-1 申请 res1、res2 资源成功
线程：Thread-1 获取到 res1 资源的锁
线程：Thread-1 获取到 res2 资源的锁
```

**使用 Lock 的 tryLock() 方法，获取锁失败释放所有资源，破坏 "不可抢占" 条件示例**

```javascript
package constxiong.concurrency.a023;

import java.util.Random;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 测试 占有部分资源的线程进一步申请其他资源时，如果申请不到，主动释放它占有的资源，破坏 "不可抢占" 条件
 */
public class TestBreakLockOccupation {
    
    private static Random r = new Random(); 

    private static Lock lock1 = new ReentrantLock();
    
    private static Lock lock2 = new ReentrantLock();
    
    public static void main(String[] args) {
        new Thread(() -> {
            //标识任务是否完成
            boolean taskComplete = false;
            while (!taskComplete) {
                lock1.lock();
                System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock1 成功");
                try {
                    //随机休眠，帮助造成死锁环境
                    try {
                        Thread.sleep(r.nextInt(30));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    
                    //线程 0 尝试获取 lock2
                    if (lock2.tryLock()) {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock2 成功");
                        try {
                            taskComplete = true;
                        } finally {
                            lock2.unlock();
                        }
                    } else {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock2 失败");
                    }
                } finally {
                    lock1.unlock();
                }
                
                //随机休眠，避免出现活锁
                try {
                    Thread.sleep(r.nextInt(10));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
        
        new Thread(() -> {
            //标识任务是否完成
            boolean taskComplete = false;
            while (!taskComplete) {
                lock2.lock();
                System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock2 成功");
                try {
                    //随机休眠，帮助造成死锁环境
                    try {
                        Thread.sleep(r.nextInt(30));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    
                    //线程2 尝试获取锁 lock1
                    if (lock1.tryLock()) {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock1 成功");
                        try {
                            taskComplete = true;
                        } finally {
                            lock1.unlock();
                        }
                    } else {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock1 失败");
                    }
                } finally {
                    lock2.unlock();
                }
                
                //随机休眠，避免出现活锁
                try {
                    Thread.sleep(r.nextInt(10));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }
    
}
```

打印结果如下

```javascript
线程：Thread-0 获取锁 lock1 成功
线程：Thread-1 获取锁 lock2 成功
线程：Thread-1 获取锁 lock1 失败
线程：Thread-1 获取锁 lock2 成功
线程：Thread-0 获取锁 lock2 失败
线程：Thread-1 获取锁 lock1 成功
线程：Thread-0 获取锁 lock1 成功
线程：Thread-0 获取锁 lock2 成功
```

**按照一定的顺序加锁，破坏 "循环等待" 条件示例**

```javascript
package constxiong.concurrency.a023;

/**
 * 测试 按序申请资源，破坏 "循环等待" 条件
 * 
 */
public class TestBreakLockCircleWait {

    private static Object res1 = new Object();
    
    private static Object res2 = new Object();
    
    
    public static void main(String[] args) {
        new Thread(() -> {
            Object first = res1;
            Object second = res2;
            //比较 res1 和 res2 的 hashCode,如果 res1 的 hashcode > res2，交换 first 和 second。保证 hashCode 小的对象先加锁
            if (res1.hashCode() > res2.hashCode()) {
                first = res2;
                second = res1;
            }
            synchronized (first) {
                System.out.println("线程：" + Thread.currentThread().getName() + "获取资源 " + first + " 锁成功");
                try {
                    Thread.sleep(100);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized(second) {
                    System.out.println("线程：" + Thread.currentThread().getName() + "获取资源 " + second + " 锁成功");
                }
            }
        }).start();
        
        new Thread(() -> {
            Object first = res1;
            Object second = res2;
            //比较 res1 和 res2 的 hashCode,如果 res1 的 hashcode > res2，交换 first 和 second。保证 hashCode 小的对象先加锁
            if (res1.hashCode() > res2.hashCode()) {
                first = res2;
                second = res1;
            }
            synchronized (first) {
                System.out.println("线程：" + Thread.currentThread().getName() + "获取资源 " + first + " 锁成功");
                try {
                    Thread.sleep(100);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                synchronized(second) {
                    System.out.println("线程：" + Thread.currentThread().getName() + "获取资源 " + second + " 锁成功");
                }
            }
        }).start();
    }
    
}
```

打印结果如下

```java
线程：Thread-0获取资源 java.lang.Object@7447157c 锁成功
线程：Thread-0获取资源 java.lang.Object@7a80f45c 锁成功
线程：Thread-1获取资源 java.lang.Object@7447157c 锁成功
线程：Thread-1获取资源 java.lang.Object@7a80f45c 锁成功
```

### 29.什么是活锁?

任务没有被阻塞，由于某些条件没有满足，导致一直重复尝试—失败—尝试—失败的过程。 处于活锁的实体是在不断的改变状态，活锁有可能自行解开。

死锁是大家都拿不到资源都占用着对方的资源，而活锁是拿到资源却又相互释放不执行。

```java
public class TestBreakLockOccupation {
    
    private static Random r = new Random(); 

    private static Lock lock1 = new ReentrantLock();
    
    private static Lock lock2 = new ReentrantLock();
    
    public static void main(String[] args) {
        new Thread(() -> {
            //标识任务是否完成
            boolean taskComplete = false;
            while (!taskComplete) {
                lock1.lock();
                System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock1 成功");
                try {
                    //随机休眠，帮助造成死锁环境
                    try {
                        Thread.sleep(r.nextInt(30));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    
                    //线程 0 尝试获取 lock2
                    if (lock2.tryLock()) {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock2 成功");
                        try {
                            taskComplete = true;
                        } finally {
                            lock2.unlock();
                        }
                    } else {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock2 失败");
                    }
                } finally {
                    lock1.unlock();
                }
                
                //随机休眠，避免出现活锁
                try {
                    Thread.sleep(r.nextInt(10));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
        
        new Thread(() -> {
            //标识任务是否完成
            boolean taskComplete = false;
            while (!taskComplete) {
                lock2.lock();
                System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock2 成功");
                try {
                    //随机休眠，帮助造成死锁环境
                    try {
                        Thread.sleep(r.nextInt(30));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    
                    //线程2 尝试获取锁 lock1
                    if (lock1.tryLock()) {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock1 成功");
                        try {
                            taskComplete = true;
                        } finally {
                            lock1.unlock();
                        }
                    } else {
                        System.out.println("线程：" + Thread.currentThread().getName() + " 获取锁 lock1 失败");
                    }
                } finally {
                    lock2.unlock();
                }
                
                //随机休眠，避免出现活锁
                try {
                    Thread.sleep(r.nextInt(10));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }
    
}
```

### 30.什么是无锁?

不需要加锁的方式来解决并发问题

如，原子工具类、ThreadLocal、复制写技术、CAS等

> https://www.cnblogs.com/ConstXiong/p/11987063.html

### 31.什么是线程饥饿?

一个线程因为 CPU 时间全部被其他线程抢占而得不到 CPU 运行时间，导致线程无法执行。

产生饥饿的原因：

- 优先级线程吞噬所有的低优先级线程的 CPU 时间
- 其他线程总是能在它之前持续地对该同步块进行访问，线程被永久堵塞在一个等待进入同步块
- 其他线程总是抢先被持续地获得唤醒，线程一直在等待被唤醒

```java
/**
 * 测试线程饥饿
 * 
 */
public class TestThreadHungry {

    private static ExecutorService es = Executors.newSingleThreadExecutor();
    
    public static void main(String[] args) throws InterruptedException, ExecutionException {
        Future<String> future1 = es.submit(new Callable<String>() {
            @Override
            public String call() throws Exception {
                System.out.println("提交任务1");
                Future<String> future2 = es.submit(new Callable<String>() {
                    @Override
                    public String call() throws Exception {
                        System.out.println("提交任务2");
                        return "任务 2 结果";
                    }
                });
                return future2.get();
            }
        });
        System.out.println("获取到" + future1.get());
    }
    
}
```

打印结果如下，线程池卡死。线程池只能容纳 1 个任务，任务 1 提交任务 2，任务 2 永远得不到执行。

```javascript
提交任务1
```

### 32.Atomiclnteger的底层实现是怎样的?

提供原子性的访问和更新操作，其原子性操作的实现是基于CAS。

### 33.什么是 CAS?

CAS（Compare and swap）比较和替换是设计并发算法时用到的一种技术。

它的功能是判断内存某个位置的值是否为预期值，如果是则更改为新的值，这个过程是原子的

### 34.CAS 有什么缺点?

- 循环时间长，开销大
- 只能保证一个共享变量的原子操作
- 存在 ABA 问题

### 35.CAS 底层使用了哪个操作类?

sun.misc.Unsafe

### 36.CAS 在 JDK 中有哪些应用?

java.util.concurrent.atomic中的AtomicXXX

### 37.用伪代码写一个 CAS 算法的核心

```
do{
	备份旧数据；
	基于旧数据构造新数据
}while(!CAS(内存地址，备份的旧数据，新数据))
```

### 38.阻塞和非阻塞的区别?

https://www.zhihu.com/question/19732473

阻塞和非阻塞关注的是**程序在等待调用结果（消息，返回值）时的状态.**

阻塞调用是指调用结果返回之前，当前线程会被挂起。调用线程只有在得到结果之后才会返回。
非阻塞调用指在不能立刻得到结果之前，该调用不会阻塞当前线程。

同步和异步关注的是**消息通信机制** (synchronous communication/ asynchronous communication)
所谓同步，就是在发出一个调用时，在没有得到结果之前，该调用就不返回。但是一旦调用返回，就得到返回值了。
换句话说，就是由调用者主动等待这个*调用*的结果。

而异步则是相反，**调用在发出之后，这个调用就直接返回了，所以没有返回结果**。换句话说，当一个异步过程调用发出后，调用者不会立刻得到结果。而是在调用发出后，被调用者通过状态、通知来通知调用者，或通过回调函数处理这个调用。

### 39.并发和并行的区别?

- 并行指多个事件在同一个时刻发生；并发指在某时刻只有一个事件在发生，某个时间段内由于 CPU 交替执行，可以发生多个事件。
- 并行没有对 CPU 资源的抢占；并发执行的线程需要对 CPU 资源进行抢占。
- 并行执行的线程之间不存在切换；并发操作系统会根据任务调度系统给线程分配线程的 CPU 执行时间，线程的执行会进行切换。

### 40.为什么不推荐使用 stop 停止线程?

1. 调用 stop() 方法会立刻停止 run() 方法中剩余的全部工作，包括在 catch 或 finally 语句中的，并抛出ThreadDeath异常(通常情况下此异常不需要显示的捕获)，因此可能会导致一些清理性的工作的得不到完成，如文件，数据库等的关闭。
2. 调用 stop() 方法会立即释放该线程所持有的所有的锁，导致数据得不到同步，出现数据不一致的问题。

### 41.如何优雅地终止一个线程?

使用 interrupt() 让线程在合适的时机自然结束。

### 42.Synchronized 同步锁有哪几种用法?

- 修饰普通方法
- 修饰静态方法
- 指定对象，修饰代码块

### 43.什么是重入锁（ReentrantLock）?

指在同一个线程在外层方法获取锁的时候，进入内层方法会自动获取锁。

https://www.cnblogs.com/leesf456/p/5383609.html

### 44.重入锁有哪些重要的方法?

**lock()**

获取锁，有以下三种情况：

锁空闲：直接获取锁并返回，同时设置锁持有者数量为：1；

当前线程持有锁：直接获取锁并返回，同时锁持有者数量递增1；

其他线程持有锁：当前线程会休眠等待，直至获取锁为止；

**lockInterruptibly()**

获取锁，逻辑和 lock() 方法一样，但这个方法在获取锁过程中能响应中断。

**tryLock()**

从关键字字面理解，这是在尝试获取锁，获取成功返回：true，获取失败返回：false, 这个方法不会等待，有以下

三种情况：

锁空闲：直接获取锁并返回：true，同时设置锁持有者数量为：1；

当前线程持有锁：直接获取锁并返回：true，同时锁持有者数量递增1；

其他线程持有锁：获取锁失败，返回：false；

**tryLock(long timeout, TimeUnit unit)**

逻辑和 tryLock() 差不多，只是这个方法是带时间的。

**unlock()**

释放锁，每次锁持有者数量递减 1，直到 0 为止。所以，现在知道为什么 lock 多少次，就要对应 unlock 多少次了

吧。

**newCondition**

返回一个这个锁的 Condition 实例，可以实现 synchronized 关键字类似 wait/ notify 实现多线程通信的功能，不

过这个比 wait/ notify 要更灵活，更强大！

### 45.重入锁怎么用?

```java
    private static final Lock lock = new ReentrantLock();
```

### 46.重入锁你怎么理解"重入"?

可重复使用的锁，在外层使用锁之后，在内层仍然可以使用，并且不发生死锁

### 47.synchronized 是重入锁吗?

是的。

```java
public class TestSynchronizedReentrant {
    
    public static void main(String[] args) {
        new Thread(new SynchronizedReentrant()).start();
    }
    
}

class SynchronizedReentrant implements Runnable {

    private final Object obj = new Object();
    
    /**
     * 方法1，调用方法2
     */
    public void method1() {
        synchronized (obj) {
            System.out.println(Thread.currentThread().getName() + " method1()");
            method2();
        }
    }
    
    /**
     * 方法2，打印前获取 obj 锁
     * 如果同一线程，锁不可重入的话，method2 需要等待 method1 释放 obj 锁
     */
    public void method2() {
        synchronized (obj) {
            System.out.println(Thread.currentThread().getName() + " method2()");
        }
    }

    @Override
    public void run() {
        //线程启动 执行方法1
        method1();
    }
    
}
```

### 48.Synchronized与 ReentrantLock的区别?

1. Lock是一个接口，而synchronized是Java中的关键字，synchronized是内置的语言实现api；

2. synchronized在发生异常时，会自动释放线程占有的锁，因此不会导致死锁现象发生；而Lock在发生异常时，如果没有主动通过unLock()去释放锁，则很可能造成死锁现象，因此使用Lock时需要在finally块中释放锁；

3. Lock可以让等待锁的线程响应中断，而synchronized却不行，使用synchronized时，等待的线程会一直等待下去，不能够响应中断；

4. 通过Lock可以知道有没有成功获取锁，而synchronized却无法办到。

5. Lock可以提高多个线程进行读操作的效率。

6. synchronized非公平锁，ReentrantLock两者都可以

7. lock可以绑定多个条件Condition。可以唤醒指定线程

   synchronized 只能唤醒一个线程或者全部

  在性能上来说，如果竞争资源不激烈，两者的性能是差不多的，而当竞争资源非常激烈时（即有大量线程同时竞争），此时Lock的性能要远远优于synchronized。

### 49.synchronized 锁的是什么?

万物皆对象，锁本身就是个对象

### 50.什么是读写锁?

读写锁在同一时刻可以允许多个多线程访问，但是在写线程访问的时候，所有的读线程和其他写线程都会被阻塞。读写锁实际维护了一对锁，一个读锁，一个写锁，通过分离读锁和写锁，使得其并发性比独占式锁(排他锁)有了很大的提升。

### 51.公平锁和非公平锁的区别?

公平锁：多个线程按照申请锁的顺序去获得锁，线程会直接进入队列去排队，永远都是队列的第一位才能得到锁。

- 优点：所有的线程都能得到资源，不会饿死在队列中。
- 缺点：吞吐量会下降很多，队列里面除了第一个线程，其他的线程都会阻塞，cpu唤醒阻塞线程的开销会很大。

非公平锁：多个线程去获取锁的时候，会直接去尝试获取，获取不到，再去进入等待队列，如果能获取到，就直接获取到锁。

- 优点：可以减少CPU唤醒线程的开销，整体的吞吐效率会高点，CPU也不必取唤醒所有线程，会减少唤起线程的数量。
- 缺点：可能导致队列中间的线程一直获取不到锁或者长时间获取不到锁，导致饿死。

### 52.有哪些锁优化的方式?

- 减少锁持有时间
- 减小锁粒度
- 锁分离
- 锁粗化
- 锁消除



https://blog.csdn.net/hbtj_1216/article/details/77161198

### 53.什么是偏向锁?

如果程序没有竞争，则取消之前已经获取锁的线程同步操作（CAS）。也就是说，若某一锁被线程获取后，便进入偏向模式，当线程再次请求这个锁，无需在进行相关的同步操作，如果在此之间有其他线程进行了锁请求，则锁退出偏向模式。

偏向锁在锁竞争激烈的场合没有优化效果，因为大量的竞争会导致持有锁的进程不停地切换，锁也很难一直保持在偏向模式，使用 -XX:-UseBiasedLocking=false 禁用偏向锁。

### 54.什么是轻量级锁?

自旋锁的目标是降低线程切换的成本。如果锁竞争激烈，我们不得不依赖于重量级锁，让竞争失败的线程阻塞；如果完全没有实际的锁竞争，那么申请重量级锁都是浪费的。**轻量级锁的目标是，减少无实际竞争情况下，使用重量级锁产生的性能消耗**，包括系统调用引起的内核态与用户态切换、线程阻塞造成的线程切换等。

顾名思义，轻量级锁是相对于重量级锁而言的。使用轻量级锁时，不需要申请互斥量，仅仅将Mark Word中的部分字节CAS更新指向线程栈中的Lock Record，如果更新成功，则轻量级锁获取成功*，记录锁状态为轻量级锁；*否则，说明已经有线程获得了轻量级锁，目前发生了锁竞争（不适合继续使用轻量级锁），接下来膨胀为重量级锁。

> Mark Word是对象头的一部分；每个线程都拥有自己的线程栈（虚拟机栈），记录线程和函数调用的基本信息。二者属于JVM的基础内容，此处不做介绍。

当然，由于轻量级锁天然瞄准不存在锁竞争的场景，如果存在锁竞争但不激烈，仍然可以用自旋锁优化，自旋失败后再膨胀为重量级锁。

https://www.jianshu.com/p/36eedeb3f912

### 55.什么是自旋锁?

自旋锁（spinlock）：是指当一个线程在获取锁的时候，如果锁已经被其它线程获取，那么该线程将循环等待，然后不断的判断锁是否能够被成功获取，直到获取到锁才会退出循环。 

https://blog.csdn.net/fuyuwei2015/article/details/83387536

### 56.什么是锁消除?

锁消除时指虚拟机即时编译器再运行时，对一些代码上要求同步，但是被检测到不可能存在共享数据竞争的锁进行消除。锁消除的主要判定依据来源于逃逸分析的数据支持。意思就是：JVM会判断再一段程序中的同步明显不会逃逸出去从而被其他线程访问到，那JVM就把它们当作栈上数据对待，认为这些数据时线程独有的，不需要加同步。此时就会进行锁消除。

当然在实际开发中，我们很清楚的知道那些地方时线程独有的，不需要加同步锁，但是在Java API中有很多方法都是加了同步的，那么此时JVM会判断这段代码是否需要加锁。如果数据并不会逃逸，则会进行锁消除。

### 57.什么是锁粗化?

原则上，我们都知道在加同步锁时，尽可能的将同步块的作用范围限制到尽量小的范围(只在共享数据的实际作用域中才进行同步，这样是为了使得需要同步的操作数量尽可能变小。在存在锁同步竞争中，也可以使得等待锁的线程尽早的拿到锁)。

大部分上述情况是完美正确的，但是如果存在连串的一系列操作都对同一个对象反复加锁和解锁，甚至加锁操作时出现在循环体中的，那即使没有线程竞争，频繁地进行互斥同步操作也会导致不必要地性能操作。

### 58.什么是重量级锁?

重量级锁依赖于底层操作系统的Mutex Lock，所有线程都会被阻塞住，线程之间的切换需要从用户态到内核态，切换成本非常高。

### 59.什么是线程池?

线程池（英语：thread pool）：一种线程使用模式。线程过多会带来调度开销，进而影响缓存局部性和整体性能。而线程池维护着多个线程，等待着监督管理者分配可并发执行的任务。这避免了在处理短时间任务时创建与销毁线程的代价。线程池不仅能够保证内核的充分利用，还能防止过分调度。

### 60.使用线程池有什么好处?

第一：降低资源消耗。通过重复利用已创建的线程降低线程创建和销毁造成的消耗。

第二：提高响应速度。当任务到达时，任务可以不需要的等到线程创建就能立即执行。

第三：提高线程的可管理性。线程是稀缺资源，如果无限制的创建，不仅会消耗系统资源，还会降低系统的稳定性，使用线程池可以进行统一的分配，调优和监控。

### 61.创建一个线程池有哪些核心参数?

```java
    public ThreadPoolExecutor(int corePoolSize,
                              int maximumPoolSize,
                              long keepAliveTime,
                              TimeUnit unit,
                              BlockingQueue<Runnable> workQueue,
                              ThreadFactory threadFactory,
                              RejectedExecutionHandler handler)
```

- corePoolSize：线程池的核心线程数
- maximumPoolSize：能容纳的最大线程数
- keepAliveTime：空闲线程存活时间
- unit：存活的时间单位
- workQueue：存放提交但未执行任务的队列
- threadFactory：创建线程的工厂类
- handler：等待队列满后的拒绝策略

### 62.线程池的工作流程是怎样的?

1 当一个任务通过submit或者execute方法提交到线程池的时候，如果当前池中线程数（包括闲置线程）小于corePoolSize，则创建一个线程执行该任务。

2 如果当前线程池中线程数已经达到coolPoolSize，则将任务放入等待队列。

3 如果任务不能入队，说明等待队列已满，若当前池中线程数小于maximumPoolSize，则创建一个临时线程（非核心线程）执行该任务。

4 如果当前池中线程数已经等于maximumPoolSize，此时无法执行该任务，根据拒绝执行策略处理。

注意：当池中线程数大于corePoolSize，超过keepAliveTime时间的闲置线程会被回收掉。回收的是非核心线程，核心线程一般是不会回收的。如果设置allowCoreThreadTimeOut(true)，则核心线程在闲置keepAliveTime时间后也会被回收。

任务队列是一个阻塞队列，线程执行完任务后会去队列取任务来执行，如果队列为空，线程就会阻塞，直到取到任务。

### 63.Java 里面有哪些内置的线程池?

newSingleThreadExecutor  

- 创建一个单线程化的Executor，即只创建唯一的工作者线程来执行任务，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO,优先级)执行。如果这个线程异常结束，会有另一个取代它，保证顺序执行。单工作线程最大的特点是可保证顺序地执行各个任务，并且在任意给定的时间不会有多个线程是活动的。 

newFixedThreadPool    

- 创建一个可重用固定线程数的线程池，以共享的无界队列方式来运行这些线程。在任意点，在大多数线程会处于处理任务的活动状态。如果在所有线程处于活动状态时提交附加任务，则在有可用线程之前，附加任务将在队列中等待。如果在关闭前的执行期间由于失败而导致任何线程终止，那么一个新线程将代替它执行后续的任务（如果需要）。在某个线程被显式地关闭之前，池中的线程将一直存在。

newCachedThreadPool  

- 创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程.  

newScheduledThreadPool

- 创建一个定长的线程池，而且支持定时的以及周期性的任务执行，支持定时及周期性任务执行。

newSingleThreadScheduledExecutor 

- 创建只有一条线程的线程池，他可以在指定延迟后执行线程任务

newWorkStealingPool

- 创建一个拥有多个任务队列（以便减少连接数）的线程池。这是jdk1.8中新增加的一种线程池实现，

### 64.为什么阿里不让用 Executors创建线程池?

1. FixedThreadPool 和 SingleThreadExecutor：允许的请求队列长度为 Integer.MAX_VALUE，可能会堆积大量的请求，从而 OOM
2. CachedThreadPool 和 ScheduledThreadPool：允许的创建线程数量为 Integer.MAX_VALUE，可能会创建大量的线程，从而导致 OOM

### 65.线程池的拒绝策略有哪几种?

**CallerRunsPolicy**: 当触发拒绝策略，只要线程池没有关闭的话，则使用调用线程（提交任务的线程）直接运行任务。一般并发比较小，性能要求不高，不允许失败。但是，由于调用者自己运行任务，如果任务提交速度过快，可能导致程序阻塞，性能效率上必然的损失较大

**AbortPolicy**: 丢弃任务，并抛出拒绝执行 RejectedExecutionException 异常信息。线程池<font color='red'>默认的拒绝策略</font>。必须处理好抛出的异常，否则会打断当前的执行流程，影响后续的任务执行。

**DiscardPolicy**: 直接丢弃，其他啥都没有

**DiscardOldestPolicy**: 当触发拒绝策略，只要线程池没有关闭的话，丢弃阻塞队列 workQueue 中最老的一个任务，并将新任务加入

### 66.如何提交一个线程到线程池?

execute() 和 submit() 两个方法都可以。

### 67.线程池submit和execute有什么区别?

- execute() 参数 Runnable ；submit() 参数 (Runnable) 或 (Runnable 和 结果 T) 或 (Callable)
- execute() 没有返回值；而 submit() 有返回值
- submit() 的返回值 Future 调用get方法时，可以捕获处理异常

### 68.如何查看线程池的运行状态?

**线程池的5种状态：RUNNING、SHUTDOWN、STOP、TIDYING、TERMINATED。**

https://www.jb51.net/article/206454.htm

| 方法                    | 含义                                                         |
| ----------------------- | ------------------------------------------------------------ |
| getActiveCount()        | 线程池中正在执行任务的线程数量                               |
| getCompletedTaskCount() | 线程池已完成的任务数量，该值小于等于taskCount                |
| getCorePoolSize()       | 线程池的核心线程数量                                         |
| getLargestPoolSize()    | 线程池曾经创建过的最大线程数量。通过这个数据可以知道线程池是否满过，也就是达到了maximumPoolSize |
| getMaximumPoolSize()    | 线程池的最大线程数量                                         |
| getPoolSize()           | 线程池当前的线程数量                                         |
| getTaskCount()          | 线程池已经执行的和未执行的任务总数                           |

### 69.如何设置线程池的大小?

这个是根据具体业务来配置的，分为CPU密集型和IO密集型

CPU密集型

- CPU密集的意思是该任务需要大量的运算，而没有阻塞，CPU一直全速运行
- CPU密集任务只有在真正的多核CPU上才可能得到加速（通过多线程）
- 而在单核CPU上，无论你开几个模拟的多线程该任务都不可能得到加速，因为CPU总的运算能力就那些
- CPU密集型任务配置尽可能少的线程数量：
- 一般公式：<font color='red'>CPU核数 + 1个线程数</font>

IO密集型

- <font color='red'>由于IO密集型任务线程并不是一直在执行任务，则可能多的线程，如 CPU核数 * 2</font>
- IO密集型，即该任务需要大量的IO操作，即大量的阻塞
- 在单线程上运行IO密集型的任务会导致浪费大量的CPU运算能力花费在等待上
- 所以IO密集型任务中使用多线程可以大大的加速程序的运行，即使在单核CPU上，这种加速主要就是利用了被浪费掉的阻塞时间。
- IO密集时，大部分线程都被阻塞，故需要多配置线程数：

参考公式：CPU核数 / (1 - 阻塞系数) ；阻塞系数在0.8 ~ 0.9左右

例如：8核CPU：8/ (1 - 0.9) = 80个线程数

### 70.如何关闭线程池?

shutdown()：将线程池状态设置成 SHUTDOWN 状态，然后中断所有 没有正在执行任务的线程

shutdown()：将线程池状态设置成 STOP 状态，然后尝试停止所有正在执行或者暂停任务的线程

原理都是遍历线程池中的工作线程，然后逐个调用线程的 interrupt 方法来中断线程，所以无法响应中断的任务可能永远无法终止。

### 71.AQS 是什么?

AQS，即AbstractQueuedSynchronizer, 队列同步器，它是Java并发用来构建锁和其他同步组件的基础框架。

**它维护了一个volatile int state（代表共享资源）和一个FIFO（双向队列）线程等待队列（多线程争用资源被阻塞时会进入此队列）**

### 72.AQS 的底层原理是什么?

https://blog.csdn.net/qq_36520235/article/details/81263037

### 73.Java中的 Fork Join框架有什么用?

Fork/Join框架是 Java 7 提供的一个用于并行执行任务的框架，把大任务分割成若干个小人物，最后汇总每个小任务结果后得到大任务结果，“分而治之”的思想。

在Java的Fork/Join框架中，使用两个类完成上述操作

- ForkJoinTask:我们要使用Fork/Join框架，首先需要创建一个ForkJoin任务。该类提供了在任务中执行fork和join的机制。通常情况下我们不需要直接继承ForkJoinTask类，只需要继承它的子类，Fork/Join框架提供了两个子类：
  - RecursiveAction：用于没有返回结果的任务
  - RecursiveTask:用于有返回结果的任务 
- ForkJoinPool:ForkJoinTask需要通过ForkJoinPool来执行

```java
class MyTask extends RecursiveTask<Integer> {

    //拆分差值不能超过10，计算10以内运算
    private static final Integer VALUE = 10;
    private int begin ;//拆分开始值
    private int end;//拆分结束值
    private int result ; //返回结果

    //创建有参数构造
    public MyTask(int begin,int end) {
        this.begin = begin;
        this.end = end;
    }

    //拆分和合并过程
    @Override
    protected Integer compute() {
        //判断相加两个数值是否大于10
        if((end-begin)<=VALUE) {
            //相加操作
            for (int i = begin; i <=end; i++) {
                result = result+i;
            }
        } else {//进一步拆分
            //获取中间值
            int middle = (begin+end)/2;
            //拆分左边
            MyTask task01 = new MyTask(begin,middle);
            //拆分右边
            MyTask task02 = new MyTask(middle+1,end);
            //调用方法拆分
            task01.fork();
            task02.fork();
            //合并结果
            result = task01.join()+task02.join();
        }
        return result;
    }
}

public class ForkJoinDemo {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        //创建MyTask对象
        MyTask myTask = new MyTask(0,100);
        //创建分支合并池对象
        ForkJoinPool forkJoinPool = new ForkJoinPool();
        ForkJoinTask<Integer> forkJoinTask = forkJoinPool.submit(myTask);
        //获取最终合并之后结果
        Integer result = forkJoinTask.get();
        System.out.println(result);
        //关闭池对象
        forkJoinPool.shutdown();
    }
}
```

### 74.ThreadLocal有什么用?

ThreadLocal 是线程本地存储，在每个线程中都创建了一个 ThreadLocalMap 对象，每个线程可以访问自己内部 ThreadLocalMap 对象内的 value。通过这种方式，避免资源在多线程间共享。

### 75.ThreadLocal有什么副作用?

存在内存泄漏问题。

ThreadLocalMap中的Entry的key使用的是ThreadLocal对象的弱引用，在没有其他地方对ThreadLoca依赖，ThreadLocalMap中的ThreadLocal对象就会被回收掉，但是对应的 value 不会被回收，这个时候Map中就可能存在key为null但是value不为null的项，这需要实际的时候使用完毕及时调用remove方法避免内存泄漏。

https://www.cnblogs.com/fsmly/p/11020641.html

https://www.jianshu.com/p/dde92ec37bd1

### 76.volatile 关键字有什么用?

Java 中 volatile 关键字是一个类型修饰符。JDK 1.5 之后，对其语义进行了增强。

- 保证了不同线程对共享变量进行操作时的可见性，即一个线程修改了共享变量的值，共享变量修改后的值对其他线程立即可见
- 通过禁止编译器、CPU 指令重排序和部分 happens-before 规则，解决有序性问题

### 77.volatile 有哪些应用场景?

volatile用于多线程环境下的一写多读，或者无关联的多写。

如果有多个线程并发写操作，仍然需要使用锁或者线程安全的容器或者原子变量来代替。

https://www.jianshu.com/p/5584600d2569

### 78.CyclicBarrier有什么用?

CyclicBarrier：可循环使用的屏障。让一组线程到达一个屏障（也可以叫做同步点）时被阻塞，知道最后一个线程到达屏障时，屏障才会开门，所有被屏障拦截的线程才会继续运行。

```java
//集齐7颗龙珠就可以召唤神龙
public class CyclicBarrierDemo {

    //创建固定值
    private static final int NUMBER = 7;

    public static void main(String[] args) {
        //创建CyclicBarrier
        CyclicBarrier cyclicBarrier =
                new CyclicBarrier(NUMBER,()->{
                    System.out.println("*****集齐7颗龙珠就可以召唤神龙");
                });

        //集齐七颗龙珠过程
        for (int i = 1; i <=7; i++) {
            new Thread(()->{
                try {
                    System.out.println(Thread.currentThread().getName()+" 星龙被收集到了");
                    //等待
                    cyclicBarrier.await();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            },String.valueOf(i)).start();
        }
    }
}

```

### 79.CountDownLatch有什么用?

允许一个或多个线程等待其它线程完成操作。当计数器的值变为0时，因await方法阻塞的线程会被唤醒，继续执行

```java
//演示 CountDownLatch
public class CountDownLatchDemo {
    //6个同学陆续离开教室之后，班长锁门
    public static void main(String[] args) throws InterruptedException {

        //创建CountDownLatch对象，设置初始值
        CountDownLatch countDownLatch = new CountDownLatch(6);

        //6个同学陆续离开教室之后
        for (int i = 1; i <=6; i++) {
            new Thread(()->{
                System.out.println(Thread.currentThread().getName()+" 号同学离开了教室");

                //计数  -1
                countDownLatch.countDown();

            },String.valueOf(i)).start();
        }

        //等待
        countDownLatch.await();

        System.out.println(Thread.currentThread().getName()+" 班长锁门走人了");
    }
}

```

### 80.CountDownLatch与CyclicBarrier的区别?

CountDownLatch：阻塞线程必须等待其它线程都完成操作后才能执行。

CyclicBarrier：所有线程在未完成操作前互相等待，只要还有一个未 await，其它完成操作的线程都处于阻塞状态。

### 81.Semaphore 有什么用?

信号量是用来控制同时访问特定资源的线程数量，它通过协调各个线程，以保证合理使用公共资源。

```java
//6辆汽车，停3个车位
public class SemaphoreDemo {
    public static void main(String[] args) {
        //创建Semaphore，设置许可数量
        Semaphore semaphore = new Semaphore(3);

        //模拟6辆汽车
        for (int i = 1; i <=6; i++) {
            new Thread(()->{
                try {
                    //抢占
                    semaphore.acquire();

                    System.out.println(Thread.currentThread().getName()+" 抢到了车位");

                    //设置随机停车时间
                    TimeUnit.SECONDS.sleep(new Random().nextInt(5));

                    System.out.println(Thread.currentThread().getName()+" ------离开了车位");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    //释放
                    semaphore.release();
                }
            },String.valueOf(i)).start();
        }
    }
}
```

### 82.Exchanger有什么用?



### 83.LockSupport有什么用?

LockSupport 是一个非常方便实用的线程阻塞工具类，它可以在线程内任意位置让线程阻塞或唤醒。

与 Thread.suspend() 方法相比，它弥补了由于 resume() 方法发生导致线程无法继续执行的情况。

和 Object.wait() 方法相比，它不需要先获得某个对象的锁，也不会抛出 InterruptedException 异常



### 84.Java中原子操作的类有哪些?

https://www.cnblogs.com/senlinyang/p/7856339.html

**原子更新基本类型**

- AtomicInteger
- AtomicLong
- AtomicBoolean

**原子更新数组**

- AtomicIntegerArray：原子更新整形数组里的元素

- AtomicLongArray：原子更新长整形数组里的元素

- AtomicReferenceArray：原子更新引用数组里的元素

**原子更新引用**

- AtomicReference：原子更新引用类型
- AtomicReferenceFieldUpdater：原子更新引用类型里的字段
- AtomicMarkableReference：原子更新带有标记位的引用类型。可以原子更新一个布尔类型的标记位和引用类型。构造方法是AtomicMarkableReference（V initialRef，booleaninitialMark）

**原子更新字段类**

- AtomicIntegerFieldUpdater：原子更新整形属性的更新器
- AtomicLongFieldUpdater：原子更新长整形的更新器
- AtomicStampedReference：原子更新带有版本号的引用类型。该类将整数值与引用关联起来，可用于原子的更新数据和数据的版本号，可以解决使用CAS进行原子更新时可能出现的ABA问题。

### 85.什么是 ABA 问题?

在进行获取主内存值的时候，该内存值在我们写入主内存的时候，已经被修改了N次，但是最终又改成原来的值了

### 86.怎么解决 ABA 问题?

新增版本号。

AtomicStampedReference，时间戳原子引用，来这里应用于版本号的更新，也就是每次更新的时候，需要比较期望值和当前值，以及期望版本号和当前版本号

### 87.Java 并发容器，你知道几个?

1. ConcurrentHashMap：并发版 HashMap
2. CopyOnWriteArrayList：并发版 ArrayList
3. CopyOnWriteArraySet：并发 Set
4. ConcurrentLinkedQueue：并发队列 (基于链表)
5. ConcurrentLinkedDeque：并发队列 (基于双向链表)
6. ConcurrentSkipListMap：基于跳表的并发 Map
7. ConcurrentSkipListSet：基于跳表的并发 Set
8. ArrayBlockingQueue：阻塞队列 (基于数组)
9. LinkedBlockingQueue：阻塞队列 (基于链表)
10. LinkedBlockingDeque：阻塞队列 (基于双向链表)
11. PriorityBlockingQueue：线程安全的优先队列
12. SynchronousQueue：读写成对的队列
13. LinkedTransferQueue：基于链表的数据交换队列
14. DelayQueue：延时队列

https://www.cnblogs.com/java-friend/p/11675772.html

### 88.什么是阻塞队列?

阻塞队列，顾名思义，首先它是一个队列, 通过一个共享的队列，可以使得数据由队列的一端输入，从另外一端输出； 

![image-20210721111829058](https://note-java.oss-cn-beijing.aliyuncs.com/img/image-20210721111829058.png)

当队列是空的，从队列中获取元素的操作将会被阻塞

当队列是满的，从队列中添加元素的操作将会被阻塞

### 89.阻塞队列有哪些常用的应用场景?

生产者消费者模式。

越是供小于求的情况，越需要阻塞队列。非阻塞队列通常使用轮询代替阻塞，想想大量消费者一起轮询的资源消耗将是一种怎样的情况！
请求积压与是否阻塞没有关系，只与供求关系有关。想想银行排队的情况，如果几十个人在排队但只有一个窗口，无论是阻塞（银行叫号）还是轮询（用户是不是跑过去问），都会产生大量的请求积压。

```java
/**
 * 生产者消费者  阻塞队列版
 * 使用：volatile、CAS、atomicInteger、BlockQueue、线程交互、原子引用
 *
 */

class MyResource {
    // 默认开启，进行生产消费
    // 这里用到了volatile是为了保持数据的可见性，也就是当TLAG修改时，要马上通知其它线程进行修改
    private volatile boolean FLAG = true;

    // 使用原子包装类，而不用number++
    private AtomicInteger atomicInteger = new AtomicInteger();

    // 这里不能为了满足条件，而实例化一个具体的SynchronousBlockingQueue
    BlockingQueue<String> blockingQueue = null;

    // 而应该采用依赖注入里面的，构造注入方法传入
    public MyResource(BlockingQueue<String> blockingQueue) {
        this.blockingQueue = blockingQueue;
        // 查询出传入的class是什么
        System.out.println(blockingQueue.getClass().getName());
    }

    /**
     * 生产
     * @throws Exception
     */
    public void myProd() throws Exception{
        String data = null;
        boolean retValue;
        // 多线程环境的判断，一定要使用while进行，防止出现虚假唤醒
        // 当FLAG为true的时候，开始生产
        while(FLAG) {
            data = atomicInteger.incrementAndGet() + "";

            // 2秒存入1个data
            retValue = blockingQueue.offer(data, 2L, TimeUnit.SECONDS);
            if(retValue) {
                System.out.println(Thread.currentThread().getName() + "\t 插入队列:" + data  + "成功" );
            } else {
                System.out.println(Thread.currentThread().getName() + "\t 插入队列:" + data  + "失败" );
            }

            try {
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        System.out.println(Thread.currentThread().getName() + "\t 停止生产，表示FLAG=false，生产介绍");
    }

    /**
     * 消费
     * @throws Exception
     */
    public void myConsumer() throws Exception{
        String retValue;
        // 多线程环境的判断，一定要使用while进行，防止出现虚假唤醒
        // 当FLAG为true的时候，开始生产
        while(FLAG) {
            // 2秒内取出1个data
            retValue = blockingQueue.poll(2L, TimeUnit.SECONDS);
            if(retValue != null && retValue != "") {
                System.out.println(Thread.currentThread().getName() + "\t 消费队列:" + retValue  + "成功" );
            } else {
                FLAG = false;
                System.out.println(Thread.currentThread().getName() + "\t 消费失败，队列中已为空，退出" );

                // 退出消费队列
                return;
            }
        }
    }

    /**
     * 停止生产的判断
     */
    public void stop() {
        this.FLAG = false;
    }

}
public class ProdConsumerBlockingQueueDemo {

    public static void main(String[] args) {
        // 传入具体的实现类， ArrayBlockingQueue
        MyResource myResource = new MyResource(new ArrayBlockingQueue<String>(10));

        new Thread(() -> {
            System.out.println(Thread.currentThread().getName() + "\t 生产线程启动");
            System.out.println("");
            System.out.println("");
            try {
                myResource.myProd();
                System.out.println("");
                System.out.println("");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }, "prod").start();


        new Thread(() -> {
            System.out.println(Thread.currentThread().getName() + "\t 消费线程启动");

            try {
                myResource.myConsumer();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }, "consumer").start();

        // 5秒后，停止生产和消费
        try {
            TimeUnit.SECONDS.sleep(5);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("");
        System.out.println("");
        System.out.println("5秒中后，生产和消费线程停止，线程结束");
        myResource.stop();
    }
}
```

### 90.Java 中的阻塞的队列有哪些?

1. ArrayBlockingQueue：阻塞队列 (基于数组)
2. LinkedBlockingQueue：阻塞队列 (基于链表)
3. LinkedBlockingDeque：阻塞队列 (基于双向链表)
4. PriorityBlockingQueue：线程安全的优先队列

### 91.什么是协程?

一种协同式调度的用户线程。在线程的基础之上通过分时复用的方式运行多个协程，而且协程的切换在用户态完成，切换的代价比线程从用户态到内核态的代价小很多。

https://zhuanlan.zhihu.com/p/172471249

### 92.Java 支持协程吗?

目前不支持，但有 Quasar 和 ea-async 等第三方库

https://www.zhihu.com/question/383042486

https://www.zhihu.com/question/332042250/answer/734115120

### 93.Java支持协程的框架有哪些?

Quasar 、ea-async

### 94.SimpleDateFormat 是线程安全的吗?

不是。

https://blog.csdn.net/qq_32575047/article/details/78968354

### 95.什么是幂等性?

**幂等性：就是用户对于同一操作发起的一次请求或者多次请求的结果是一致的，不会因为多次点击而产生了副作用。**

https://blog.csdn.net/weixin_42412601/article/details/108412439