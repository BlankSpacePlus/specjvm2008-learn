# SPECjvm2008学习记录

## 配置环境

配置Java环境变量：
```shell
export JAVA_HOME=/data/<username>/java/jdk1.8.0_371
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$SRILM/bin/i686-m64:$SRILM/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JAVA_HOME
export PATH="$PATH:/tmp/bin"
```

查看操作系统信息：
```shell
uname -a
```

查看系统CPU信息：
```shell
cat /proc/cpuinfo |grep "physical id"|sort |uniq|wc -l  # 查看物理CPU个数
cat /proc/cpuinfo |grep "processor"|wc -l  # 查看逻辑cpu的个数
cat /proc/cpuinfo | grep "cpu cores" | uniq  # 查看CPU核数
cat /proc/cpuinfo  # 查看CPU型号
```

查看系统内存信息：
```shell
free -h
```

查看NVIDIA显卡配置：
```shell
nvidia-smi
```

## 工作负载

SPECjvm2008提供了以下工作负载：
- `startup.helloworld`：测试HelloWorld程序从运行开始到结束所需的时间。
- `startup.compiler.compiler`：测试普通Java编译所需要的时间。
- `startup.compiler.sunflow`：测试编译Sunflow图像渲染引擎所需要的时间。
- `startup.compress`：测试压缩程序，单次压缩所需的时间。
- `startup.crypto.aes`：测试AES/DES加密算法单次加密解密所需的时间。输入数据长度为100B、713KB。
- `startup.crypto.rsa`：测试RSA加密算法单次加密解密需要的时间。输入数据长度为100B、16KB。
- `startup.crypto.signverify`：测试单次使用MD5withRSA、SHA1withRSA、SHA1withDSA、SHA256withRSA来签名，识别所需要的时间。输入数据长度为1KB、65KB、1MB。
- `startup.mpegaudio`：测试单次mpeg音频解码所需的时间。
- `startup.scimark.fft`：测试单次快速傅立叶变换所需的时间。
- `startup.scimark.lu`：测试单次矩阵LU分解所需的时间。
- `startup.scimark.monte_carlo`：测试单次运行蒙特卡罗算法所需的时间。
- `startup.scimark.sor`：测试单次运行矩阵Jacobi逐次超松弛迭代法所需的时间。
- `startup.scimark.sparse`：测试单次稀疏矩阵乘积所需的时间。
- `startup.serial`：测试单次通过Socket传输Java序列化对象到对端反序列化完成所需的时间（基于JBoss Serialization Benchmark）。
- `startup.sunflow`：测试单次图片渲染处理所需的时间。
- `startup.xml.transform`：测试单次XML转换所需的时间，转换包括Dom、Sax、Stream方式。
- `startup.xml.validation`：测试单次XMLSchema校验所需的时间。
- `compiler.compiler`：在规定时间内，多线程迭代测试普通Java编译，得出ops/m。
- `compiler.sunflow`：在规定时间内，多线程迭代测试sunflow图像渲染，得出ops/m。
- `compress`：在规定时间内，多线程迭代测试压缩，得出ops/m。
- `crypto.aes`：在规定时间内，多线程迭代测试AES/DES加解密算法，得出ops/m。
- `crypto.rsa`：在规定时间内，多线程迭代测试RSA加解密算法，得出ops/m。
- `crypto.signverify`：在规定时间内，多线程迭代测试使用MD5withRSA、SHA1withRSA、SHA1withDSA、SHA256withRSA来签名，识别，得出ops/m。
- `derby`：在规定时间内，迭代测试数据库相关逻辑，包括数据库锁、BigDecimal计算等，最后得出ops/m。
- `mpegaudio`：在规定时间内，多线程迭代mpeg音频解码，得出ops/m。
- `scimark.fft.large`：在规定时间内，多线程迭代测试快速傅立叶变换，使用32M大数据集，最后得出ops/m。
- `scimark.lu.large`：在规定时间内，多线程迭代测试矩阵LU分解，使用32M大数据集，最后得出ops/m。
- `scimark.sor.large`：在规定时间内，多线程迭代测试矩阵Jacobi逐次超松弛迭代法，使用32M大数据集，最后得出ops/m。
- `scimark.sparse.large`：在规定时间内，多线程迭代测试稀疏矩阵乘积，使用32M大数据集，最后得出ops/m。
- `scimark.fft.small`：在规定时间内，多线程迭代测试快速傅立叶变换，使用512K小数据集，最后得出ops/m。
- `scimark.lu.small`：在规定时间内，多线程迭代测试矩阵LU分解，使用512KB小数据集，最后得出ops/m。
- `scimark.sor.small`：在规定时间内，多线程迭代测试矩阵Jacobi逐次超松弛迭代法，使用512KB小数据集，最后得出ops/m。
- `scimark.sparse.small`：在规定时间内，多线程迭代测试稀疏矩阵乘积，使用512KB小数据集，最后得出ops/m。
- `scimark.monte_carlo`：在规定时间内，多线程迭代测试蒙特卡罗算法，得出ops/m。
- `serial`：在规定时间内，多线程迭代测试通过Socket传输Java序列化对象到对端反序列化（基于JBoss Serialization Benchmark），得出ops/m。
- `sunflow`：在规定时间内，利用Sunflow多线程迭代测试图片渲染，得出ops/m。
- `xml.transform`：在规定时间内，多线程迭代测试XML转换，得出ops/m。
- `xml.validation`：在规定时间内，多线程迭代测试XMLSchema验证，得出ops/m。

ops/m是性能测试中的一个常见指标，表示每分钟完成的操作数（Operations Per Minute）。它用于衡量系统或应用程序在单位时间内能够处理的操作数量。较高的ops/m值表示系统具有更高的吞吐量和处理能力，能够在单位时间内处理更多的请求或操作。
在性能测试中，通常会模拟真实场景下的负载并执行一系列操作，如请求处理、数据读写、计算等。通过测量在一分钟内完成的操作数，可以评估系统的处理能力和性能。

## 启动测试

Operating System Version: Ubuntu 20.04.2
CPU Model: Intel(R) Xeon(R) Gold 6226 CPU @ 2.70GHzCPU
CPU Cores: 12
Main Memory Size : 125GB
Graphics Card Version: NVIDIA Corporation TU102 [GeForce RTX 2080 Ti]
JDK Version : jdk-8u371-linux-x64
JRE Version : 1.8.0_371-b11

```shell
java -Djava.awt.headless=true -jar SPECjvm2008.jar -i console -ikv startup.helloworld  startup.compress startup.crypto.aes startup.crypto.rsa startup.crypto.signverify startup.mpegaudio startup.scimark.fft startup.scimark.lu startup.scimark.monte_carlo startup.scimark.sor startup.scimark.sparse startup.serial startup.sunflow startup.xml.validation  compress crypto.aes crypto.rsa crypto.signverify derby mpegaudio scimark.fft.large scimark.lu.large scimark.sor.large scimark.sparse.large scimark.fft.small scimark.lu.small scimark.sor.small scimark.sparse.small scimark.monte_carlo serial sunflow xml.validation
```

Noncompliant composite result : 969.38 ops/m
