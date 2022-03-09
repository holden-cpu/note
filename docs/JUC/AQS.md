提供一个框架来实现依赖于先进先出 (FIFO) 等待队列的阻塞锁和相关的同步器（信号量、事件等）。此类旨在为大多数依赖单个原子int值来表示状态的同步器提供有用的基础。子类必须定义更改此状态的受保护方法，并定义该状态在获取或释放此对象方面的含义。鉴于这些，此类中的其他方法执行所有排队和阻塞机制。子类可以维护其他状态字段，但只有使用getState 、 setState和compareAndSetState方法操作的原子更新的int值会在同步方面被跟踪。
子类应定义为非公共内部帮助类，用于实现其封闭类的同步属性。 AbstractQueuedSynchronizer类不实现任何同步接口。相反，它定义了诸如acquireInterruptibly之类的方法，具体锁和相关同步器可以适当地调用这些方法来实现它们的公共方法。
此类支持默认独占模式和共享模式中的一种或两种。以独占模式获取时，其他线程尝试获取时不会成功。多个线程的共享模式获取可能（但不一定）成功。此类不“理解”这些差异，除非在机械意义上，当共享模式获取成功时，下一个等待线程（如果存在）也必须确定它是否也可以获取。不同模式下等待的线程共享同一个FIFO队列。通常，实现子类只支持其中一种模式，但两者都可以发挥作用，例如在ReadWriteLock中。只支持独占或只支持共享模式的子类不需要定义支持未使用模式的方法。
该类定义了一个嵌套的AbstractQueuedSynchronizer.ConditionObject类，该类可以被支持独占模式的子类用作Condition实现，该方法isHeldExclusively报告同步是否相对于当前线程独占，使用当前getState值调用的方法release完全释放这个对象和acquire ，给定这个保存的状态值，最终将此对象恢复到其先前获取的状态。没有AbstractQueuedSynchronizer方法否则会创建这样的条件，因此如果无法满足此约束，请不要使用它。AbstractQueuedSynchronizer.ConditionObject的行为当然取决于其同步器实现的语义。
此类为内部队列提供检查、检测和监视方法，以及用于条件对象的类似方法。这些可以根据需要导出到类中，使用AbstractQueuedSynchronizer用于它们的同步机制。
此类的序列化仅存储底层原子整数维护状态，因此反序列化对象具有空线程队列。需要可序列化的典型子类将定义一个readObject方法，该方法在反序列化时将其恢复到已知的初始状态。
用法
要将此类用作同步器的基础，请在适用时重新定义以下方法，方法是使用getState 、 setState和/或compareAndSetState检查和/或修改同步状态：
tryAcquire
tryRelease
tryAcquireShared
tryReleaseShared
isHeldExclusively
默认情况下，这些方法中的每一个都会抛出UnsupportedOperationException 。这些方法的实现必须是内部线程安全的，并且通常应该是短的而不是阻塞的。定义这些方法是使用此类的唯一受支持的方法。所有其他方法都被声明为最终方法，因为它们不能独立变化。
您可能还会发现从AbstractOwnableSynchronizer继承的方法对于跟踪拥有独占同步器的线程很有用。鼓励您使用它们——这使监视和诊断工具能够帮助用户确定哪些线程持有锁。
即使此类基于内部 FIFO 队列，它也不会自动强制执行 FIFO 获取策略。独占同步的核心形式为：
   Acquire:
       while (!tryAcquire(arg)) {
          enqueue thread if it is not already queued;
          possibly block current thread;
       }

   Release:
       if (tryRelease(arg))
          unblock the first queued thread;

（共享模式类似，但可能涉及级联信号。）
因为在入队之前调用了获取中的检查，所以新获取的线程可能会抢在其他被阻塞和排队的线程之前。但是，如果需要，您可以定义tryAcquire和/或tryAcquireShared以通过内部调用一个或多个检查方法来禁用插入，从而提供公平的 FIFO 获取顺序。特别是，大多数公平同步器可以定义tryAcquire以在hasQueuedPredecessors （一种专门为公平同步器使用的方法）返回true时返回 false。其他变化是可能的。
对于默认的 barging（也称为greedy 、 renouncement和convoy-avoidance ）策略，吞吐量和可扩展性通常最高。虽然这不能保证公平或无饥饿，但允许较早排队的线程在稍后排队的线程之前重新竞争，并且每次重新竞争都有成功对抗传入线程的无偏机会。此外，虽然获取不是通常意义上的“旋转”，但它们可能会在阻塞之前执行多次调用tryAcquire并穿插其他计算。当独占同步只是短暂地保持时，这提供了自旋的大部分好处，而没有大部分责任。如果需要，您可以通过预先调用获取具有“快速路径”检查的方法来增加这一点，可能会预先检查hasContended和/或hasQueuedThreads以仅在可能不会竞争同步器时才这样做。
此类通过将其使用范围专门用于可以依赖int状态、获取和释放参数以及内部 FIFO 等待队列的同步器，部分地为同步提供了高效且可扩展的基础。如果这还不够，您可以使用atomic类、您自己的自定义Queue类和LockSupport阻塞支持从较低级别构建同步器。
使用示例
这是一个不可重入互斥锁类，它使用值 0 表示解锁状态，使用值 1 表示锁定状态。虽然不可重入锁并不严格要求记录当前所有者线程，但无论如何，此类都会这样做以使使用情况更易于监控。它还支持条件并公开一种检测方法：
   class Mutex implements Lock, java.io.Serializable {

     // Our internal helper class
     private static class Sync extends AbstractQueuedSynchronizer {
       // Report whether in locked state
       protected boolean isHeldExclusively() {
         return getState() == 1;
       }
      
       // Acquire the lock if state is zero
       public boolean tryAcquire(int acquires) {
         assert acquires == 1; // Otherwise unused
         if (compareAndSetState(0, 1)) {
           setExclusiveOwnerThread(Thread.currentThread());
           return true;
         }
         return false;
       }
      
       // Release the lock by setting state to zero
       protected boolean tryRelease(int releases) {
         assert releases == 1; // Otherwise unused
         if (getState() == 0) throw new IllegalMonitorStateException();
         setExclusiveOwnerThread(null);
         setState(0);
         return true;
       }
      
       // Provide a Condition
       Condition newCondition() { return new ConditionObject(); }
      
       // Deserialize properly
       private void readObject(ObjectInputStream s)
           throws IOException, ClassNotFoundException {
         s.defaultReadObject();
         setState(0); // reset to unlocked state
       }
     }
      
     // The sync object does all the hard work. We just forward to it.
     private final Sync sync = new Sync();
      
     public void lock()                { sync.acquire(1); }
     public boolean tryLock()          { return sync.tryAcquire(1); }
     public void unlock()              { sync.release(1); }
     public Condition newCondition()   { return sync.newCondition(); }
     public boolean isLocked()         { return sync.isHeldExclusively(); }
     public boolean hasQueuedThreads() { return sync.hasQueuedThreads(); }
     public void lockInterruptibly() throws InterruptedException {
       sync.acquireInterruptibly(1);
     }
     public boolean tryLock(long timeout, TimeUnit unit)
         throws InterruptedException {
       return sync.tryAcquireNanos(1, unit.toNanos(timeout));
     }
   }

这是一个类似于CountDownLatch的锁存器类，只是它只需要一个信号即可触发。因为锁存器是非独占的，所以它使用共享的获取和释放方法。
   class BooleanLatch {

     private static class Sync extends AbstractQueuedSynchronizer {
       boolean isSignalled() { return getState() != 0; }
      
       protected int tryAcquireShared(int ignore) {
         return isSignalled() ? 1 : -1;
       }
      
       protected boolean tryReleaseShared(int ignore) {
         setState(1);
         return true;
       }
     }
      
     private final Sync sync = new Sync();
     public boolean isSignalled() { return sync.isSignalled(); }
     public void signal()         { sync.releaseShared(1); }
     public void await() throws InterruptedException {
       sync.acquireSharedInterruptibly(1);
     }
   }