# ElementUI

1. 在ElementUI中，设置button布尔属性`plain="false"`不生效，这是因为在HTML中只要设置了布尔属性（标签中显示写出来），无论是否赋值，或者赋何值，都按照true来处理，可以通过js来折设置属性如`plain=false`生效

# 零散知识点

## 编码是编码 加密是加密 摘要是摘要

Base64就是个编码方式，RSA/AES才是加密，MD5就只是取摘要的！网上看到各种Base64加密、MD5加密…..

MD5不是加密，加密的目的是为了信息安全，别人不能看，但是自己能看。MD5只是取摘要，不可逆的，的内容是不能解密的。所以MD5不算加密

## Restful批量删除操作

https://www.jianshu.com/p/448e222a8c37

## httpclient、resttemplate、feign

https://www.cnblogs.com/lushichao/p/12796408.html

https://blog.csdn.net/xi_rurensheng/article/details/107235034

