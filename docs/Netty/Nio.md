作者：清晨的太阳
链接：https://zhuanlan.zhihu.com/p/630890093
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



1. 主从Reactor线程模型：采用主从Reactor线程模型，其中包括一个主线程组负责接收客户端连接，多个从线程组负责处理客户端请求。这种设计利用多线程的优势实现了并发处理，提高了系统的吞吐量和响应性能。
2. NIO[多路复用](https://zhida.zhihu.com/search?content_id=228329166&content_type=Article&match_order=1&q=多路复用&zhida_source=entity)非阻塞：Netty使用Java的NIO（Non-blocking I/O）机制，基于Selector实现了多路复用的非阻塞I/O操作。这种方式使得单个线程可以同时处理多个连接的I/O事件，避免了阻塞等待，提高了系统的并发能力和性能。
3. 无锁串行化设计思想：Netty的设计中尽可能避免了锁的使用，采用了无锁的数据结构和并发设计思想，减少了锁竞争和[线程阻塞](https://zhida.zhihu.com/search?content_id=228329166&content_type=Article&match_order=1&q=线程阻塞&zhida_source=entity)，提高了并发性能和可伸缩性。当我们需要多个线程并发地访问共享数据时，传统的做法是使用锁来确保每个线程的访问是安全的。但是，锁的使用会引入竞争和阻塞，导致性能下降。而无锁串行化的思想就是为了解决这个问题。在Netty中，即消息的处理尽可能在同一个线程内完成，期间不进行线程切换，这样就避免了多线程竞争和同步锁。
4. 支持高性能序列化协议：Netty提供了对多种高性能序列化协议的支持，如Google Protocol Buffers、MessagePack等。这些协议具有高效的编解码性能和数据压缩能力，提升了网络传输的效率和速度。
5. 零拷贝：Netty通过使用直接内存（Direct Memory）实现了零拷贝的特性。它通过将数据直接从操作系统的内存缓冲区传输到网络中，避免了不必要的数据复制，提高了数据传输的效率。
6. ByteBuf内存池设计：Netty使用了可配置的ByteBuf内存池，避免了频繁的内存分配和释放操作，减少了内存管理的开销，提高了内存的使用效率和性能。
7. 灵活的TCP参数配置能力：Netty提供了灵活的TCP参数配置能力，开发人员可以根据实际需求调整TCP的各种参数，如TCP缓冲区大小、TCP_NODELAY选项等，以优化网络连接的性能和可靠性。
8. 并发优化：Netty在设计上考虑了并发操作的优化。它采用了基于事件驱动的异步编程模型，通过回调和Future等机制实现非阻塞的并发处理。同时，它还提供了多种并发安全的组件和工具类，简化了[并发编程](https://zhida.zhihu.com/search?content_id=228329166&content_type=Article&match_order=1&q=并发编程&zhida_source=entity)的复杂性。