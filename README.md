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
- startup.helloworld
- startup.compiler.compiler
- startup.compiler.sunflow
- startup.compress
- startup.crypto.aes
- startup.crypto.rsa
- startup.crypto.signverify
- startup.mpegaudio
- startup.scimark.fft
- startup.scimark.lu
- startup.scimark.monte_carlo
- startup.scimark.sor
- startup.scimark.sparse
- startup.serial
- startup.sunflow
- startup.xml.transform
- startup.xml.validation
- compiler.compiler
- compiler.sunflow
- compress
- crypto.aes
- crypto.rsa
- crypto.signverify
- derby
- mpegaudio
- scimark.fft.large
- scimark.lu.large
- scimark.sor.large
- scimark.sparse.large
- scimark.fft.small
- scimark.lu.small
- scimark.sor.small
- scimark.sparse.small
- scimark.monte_carlo
- serial
- sunflow
- xml.transform
- xml.validation

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
