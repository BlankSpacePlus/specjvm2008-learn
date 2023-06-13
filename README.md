# SPECjvm2008学习记录

## 基本信息

SPECjvm2008是一个基准测试套件，包含几个现实场景的应用程序和一些专注于核心Java功能的基准测试。

下面是一些SPECjvm2008的关键基本信息：
- SPECjvm2008是由Java小组的核心设计团队开发的。AMD、BEA、HP、IBM、Intel、Sun都参与了该产品的设计、实施和测试阶段。
- SPECjvm2008计划在2006年发布，测试和其他延迟导致发布于2008年，因此命名为SPECjvm2008。
- SPECjvm2008测试JRE在典型Java应用程序上的性能，包括JAXP、Crypto库，不包括JavaEE内容（EJB、Servlet、JSP等）。
- SPECjvm2008还在执行JRE的上下文中测量操作系统和硬件的性能。
- SPECjvm2008除了测试吞吐量以外，还关注Java用户体验。
- SPECjvm2008的jar包中包含其全部源码。
- SPECjvm2008的源码也被公开在[GitHub](https://github.com/connorimes/SPECjvm2008)上。
- SPECjvm2008只能在单个JVM实例中工作，侧重于执行单个应用程序的JRE的性能。
- SPECjvm2008采用定时运行的运行模式，其中基准测试应尽可能在测量期内完成。
- SPECjvm2008可以反映硬件处理器和内存子系统的性能，但对文件I/O的依赖性低，并且不包括跨机器的网络I/O。
- SPECjvm2008的结果发布于[SPEC官方网站](https://www.spec.org/jvm2008/results/)。
- SPECjvm2008无法与任何其他基准进行比较。

## 配置环境

### 安装配置Java8

配置Java8环境变量：
```shell
export JAVA_HOME=/data/<username>/java/jdk1.8.0_371
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$SRILM/bin/i686-m64:$SRILM/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JAVA_HOME
export PATH="$PATH:/tmp/bin"
```

### 安装配置Java7

解压JDK1.7压缩包：
```shell
tar -zxvf jdk-7u80-linux-x64.tar.gz
```

配置Java7环境变量：
```shell
vim /etc/profile
```

向`/etc/profile`文件中添加下面的内容：

```shell
export JAVA_HOME=/home/<username>/jdk1.7.0_80
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
```

修改后立即生效：

```shell
source /etc/profile
```

### 安装配置SPECjvm2008

下载SPECjvm2008：<br>
获取[SPECjvm2008_1_01_setup.jar](https://www.spec.org/jvm2008/)

WSL2环境安装SPECjvm2008会卡住，因为缺少依赖，可通过补全依赖解决：
```shell
apt install x11-apps
apt install x11-session-utils
apt install dconf-editor
apt install gedit
```

安装SPECjvm2008(GUI)：
```shell
java -jar ./SPECjvm2008_1_01_setup.jar
```

安装SPECjvm2008(Command Line)：
```shell
java -jar ./SPECjvm2008_1_01_setup.jar -i console
```

SPECjvm2008配置文件的路径：
- `SPECjvm2008/props/specjvm.properties`：负责整个套件的运行配置，例如指定需要运行的测试用例、测试迭代次数、每个用例跑完是否要GC等。
- `SPECjvm2008/props/specjvm.reporter.properties`：用于丰富报表的输出内容，显示一些无法通过自动检测得到的环境信息，例如内存型号、逻辑CPU个数商等。

SPECjvm2008配置文件`specjvm.properties`常见修改：
```properties
specjvm.additional.properties.file=props/specjvm.reporter.properties // 指定报表配置文件路径
specjvm.benchmark.analyzer.names=HeapMemoryFreeAnalyzer HeapMemoryTotalAnalyzer // JVM堆分析器
specjvm.home.dir=/home/<user_name>/SPECjvm2008 // SPEC_HOME路径
specjvm.iteration.time=240s // 迭代时长
specjvm.startup.jvm_options=-Xms1024m -Xmx1024m -XX:+UseConcMarkSweepGC // JVM调优参数
```

### 安装配置perf

安装perf(Ubuntu环境)：
```shell
apt update && apt upgrade
apt-get install linux-tools-common linux-tools-generic linux-cloud-tools-generic linux-tools-`uname -r`
```

安装perf(WSL环境)：
```shell
sudo apt install build-essential flex bison libssl-dev libelf-dev
git clone --depth=1 https://github.com/microsoft/WSL2-Linux-Kernel.git
cd WSL2-Linux-Kernel/tools/perf
make
```

## 系统环境

官方支持的组合：
- Java Virtual Machines:
    - Apache Harmony (5.0)
    - BEA JRockit (5.0 and 6.0)
    - HP JVM for HP-UX
    - IBM J9 (5.0 and 6.0)
    - Java for Sun OS X
    - Sun HotSpot (5.0 and 6.0)
- Operating Systems:
    - AIX
    - IBM i Operating System
    - HP-UX
    - Linux (multiple vendors and versions)
    - Solaris (9 and 10)
    - Z/OS
    - Windows (Server 2003, XP, Vista)
- Hardware Architectures:
    - Itanium
    - PA RISC
    - IBM Power Systems
    - SPARC (Niagra and Ultra SPARC, 32-bits and 64-bits)
    - X86 (AMD (Opteron), Intel (Netburst and Core2), 32-bits and 64-bits)
- Scalability:
    - Tested on as much as 8 sockets, 32 cores and 64 hardware threads.

SPECjvm2008基准测试运行的最低硬件条件：
- 内存：512MB
- 磁盘：256MB
- 为了使用尽可能少的资源，可以只运行一个基准测试线程，使用选项`-bt 1`。但是，这会影响测试结果。

查看操作系统信息：
```shell
uname -a  # 查看操作系统完整信息
uname -s  # 查看操作系统内核名称
uname -n  # 查看网络节点上的主机名
uname -r  # 查看操作系统内核发行号
uname -v  # 查看操作系统内核版本
uname -m  # 查看主机的硬件架构名称
uname -p  # 查看处理器类型或"unknown"
uname -i  # 查看硬件平台或"unknown"
uname -o  # 查看操作系统名称
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

查看磁盘信息：
```shell
df -h
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

ops/m是性能测试中的一个常见指标，表示每分钟完成的操作数（Operations Per Minute）。它用于衡量系统或应用程序在单位时间内能够处理的操作数量。较高的ops/m值表示系统具有更高的吞吐量和处理能力，能够在单位时间内处理更多的请求或操作。<br>
在性能测试中，通常会模拟真实场景下的负载并执行一系列操作，如请求处理、数据读写、计算等。通过测量在一分钟内完成的操作数，可以评估系统的处理能力和性能。

## 版本约束

Java5可能遇到如下问题：
- BEA JRockit、HP JVM、Sun Hotspot等JVM产品依赖的Apache Xerces库存在竞争，可能导致`xml.transform`测试失败。可以使用`java -jar SPECjvm2008.jar -Dspecjvm.benchmark.threads.xml.tranform=1`命令采用一个基准测试线程来避免竞争。<br>
- Unix或Linux操作系统上，Sun Hotspot依赖的JAXP库解析目录字符串的方式存在问题，可能导致`xml.validation`测试出现`java.lang.NullPointerException`。可以用`java -jar SPECjvm2008.jar -xd `\`pwd\``/resources/xml.validation`命令指定绝对路径来解决问题。

Java6可能是比较合适的版本。

Java8及更高版本无法通过以下工作负载的测试：
- `startup.compiler.compiler`
- `startup.compiler.sunflow`
- `compiler.compiler`
- `compiler.sunflow`

Java9及更高版本无法通过以下工作负载的测试：
- `startup.xml.transform`
- `startup.xml.validation`
- `xml.transform`
- `xml.validation`

Java10及更高版本可能无法运行SPECjvm2008。

## 测试周期

SPECjvm2008提供了21项测试基准：
- `compiler.compiler`
- `compiler.sunflow`
- `compress`
- `crypto`
- `crypto.aes`
- `crypto.rsa`
- `crypto.signverify`
- `derby`
- `helloworld`
- `mpegaudio`
- `scimark.fft`
- `scimark.lu`
- `scimark.monte_carlo`
- `scimark.sor`
- `scimark.sparse`
- `serial`
- `startup`
- `startup.helloworld`
- `sunflow`
- `xml.transform`
- `xml.validation`

SPECjvm2008的一项基准测试需要2分钟的预热时间和4分钟的测量运行时间。在此期间，多项不被中断的操作将被执行，直到所有线程都完成了在测量间隔内开始的操作才会终止。实际的测量周期会长于预估的4分钟，某些情况下时间甚至会明显增加。<br>
因此，总的执行时间至少为$21×6=126$分钟，即大约2小时。

为了保证公平和准确性、确保在测量期内开始的每个操作都会对测量结果产生影响，SPECjvm2008的操作会继续执行直到所有在测量期内开始的操作都完成（即使测量期已经结束），但只有在测量期内执行的部分会被计算在内。<br>如果有一部分操作在测量期内开始但没有在期内完成，那么它对测量结果的贡献程度将取决于它在测量期内执行的时间比例，这个数值位于0到1之间。为了确保在测量期外执行操作不会有任何优势，测试框架会继续执行线程，直到所有在测量期内开始的操作都完成为止。这样可以确保测量结果的准确性，并使不同操作在相同条件下进行比较。

SPECjvm2008关注秒为单位的操作时长。通过连续运行多个操作（很可能是短时间的操作）并持续一段时间，会出现一些典型的JVM问题，例如内存系统的负载（分配、垃圾回收等），这是Java性能的关键。当连续运行基准测试操作4分钟时，JVM需要处理这些"副作用"。

## 启动参数

运行示例：
```shell
java -jar SPECjvm2008.jar --help
```

| 短参数 | 长参数 | 值类型 | 属性名称 | 详细描述 |
|:----:|:----:|:----:|:----:|:----:|
| -h | --help |   |   | 显示帮助信息 |
|   | --version |   |   | 输出SPECjvm2008版本并退出 |
| -sv | --showversion |   |   | 输出SPECjvm2008版本并继续 |
|   | --base |   |   | 运行SPECjvm2008的基本吞吐量测量（默认参数） |
|   | --peak |   |   | 运行SPECjvm2008的峰值吞吐量测量 |
|   | --lagom |   |   | 运行Lagom基准套件（采用固定的工作负载） |
| -pf | --propfile | string | specjvm.propfile | 引入属性配置文件 |
| -i | --iterations | int | specjvm.miniter, specjvm.maxniter | 指定运行的迭代次数（`inf`代表无限） |
| -mi | --miniter | int | specjvm.miniter | 设置最小迭代次数 |
| -ma | --maxiter | int | specjvm.maxniter | 设置最大迭代次数 |
| -it | --iterationtime | time | specjvm.iteration.time | 设置一次迭代持续的时间，例如`4m`，可选单位有`ms`、`s`、`m`、`h`<br>如果迭代时间太短，会根据预热结果调整为期望至少完成5次操作 |
| -fit | --forceIterationIime | time | specjvm.iteration.time, specjvm.iteration.time.forced | 强制设置迭代时间，但不会根据warmup结果调整时间 |
| -ja | --jvmArgs | string | specjvm.startup.jvm_options | 启动子测试的JVM选项 |
| -jl | --jvmLauncher | path | specjvm.benchmark.startup.launcher | 启动子测试的JVM启动器 |
| -wt | --warmuptime | time | specjvm.benchmark.warmup.time | 设置预热时间，例如`2m`，可选单位有`ms`、`s`、`m`、`h` |
| -ops | --operations | int | specjvm.fixed.operations, specjvm.run.type | 设置每次迭代将包含多少个操作，这将明确一个固定的工作负载，迭代时间将被忽略 |
| -bt | --benchmarkThreads | int | specjvm.benchmark.threads | 设置需要使用的基准线程数 |
| -r | --reporter | raw file name |   | 从给定的文件中引入reporter，基准测试将不会运行 |
| -v | --verbose |   | specjvm.print.verbose, specjvm.print.progress | 输出详细信息（仅限测试框架） |
| -pja | --parseJvmArgs |   |   | 从命令行解析JVM参数信息 |
| -coe | --continueOnError |   | specjvm.continue.on.error | 允许测试失败时继续运行套件 |
| -ict | --ignoreCheckTest |   | specjvm.run.initial.check | 不运行检查基准 |
| -ikv | --ignoreKitValidation |   | specjvm.run.checksum.validation | 不运行校验和验证基准 |
| -crf | --createRawFile | boolean | specjvm.create.xml.report | 设置是否生成原始文件 |
| -ctf | --createTextFile | boolean | specjvm.create.txt.report | 设置是否生成文本报告，如果raw禁用则txt也禁用 |
| -chf | --createHtmlFile | boolean | specjvm.create.html.report | 设置是否生成html报告，如果raw禁用则html也禁用 |
| -xd | --xmlDir | path | specjvm.benchmark.xml.validation.input.dir | 设置XML输入文件路径 |
|   | <benchmark(s)> |   | specjvm.benchmarks | 注明要运行的全部基准测试的名称，默认运行所有基准 |

## 启动测试

测试环境：
- Machine's Architecture : x86_64
- Operating System : GNU/Linux
- OS Kernel Release Number : 5.11.0-37-generic
- OS Kernel Version : #41~20.04.2-Ubuntu SMP Fri Sep 24 09:06:38 UTC 2021
- CPU Model : Intel(R) Xeon(R) Gold 6226 CPU @ 2.70GHzCPU
- CPU Cores : 12
- Main Memory Size : 125GB
- Graphics Card Version : NVIDIA Corporation TU102 [GeForce RTX 2080 Ti]
- JDK Version : jdk-8u371-linux-x64
- JRE Version : 1.8.0_371-b11

测试模式：
- `--base`：总基础吞吐量测量，从完全兼容的基础运行中获得的总体吞吐量结果，不允许做任何JVM参数调整。
- `--peak`：总峰值吞吐量测量，从完全兼容的峰值运行中获得的总吞吐量结果，可以添加JVM调优参数。

跳过签名检查：`-ikv`

测试命令：
```shell
java -Djava.awt.headless=true -jar SPECjvm2008.jar -i console -ikv startup.helloworld  startup.compress startup.crypto.aes startup.crypto.rsa startup.crypto.signverify startup.mpegaudio startup.scimark.fft startup.scimark.lu startup.scimark.monte_carlo startup.scimark.sor startup.scimark.sparse startup.serial startup.sunflow startup.xml.validation  compress crypto.aes crypto.rsa crypto.signverify derby mpegaudio scimark.fft.large scimark.lu.large scimark.sor.large scimark.sparse.large scimark.fft.small scimark.lu.small scimark.sor.small scimark.sparse.small scimark.monte_carlo serial sunflow xml.validation
```

测试时间：略小于2h。（跳过了4个workflow）

测试结果：<br>
测试完成后，前往`SPECjvm2008/results/`目录下查看测试结果HTML文档。<br>
Noncompliant composite result : 969.38 ops/m

此系统环境下，内核版本是Ubuntu20.04.2，内核发行号是5.11.0-37-generic，硬件指令集是x86_64，能查找到的linux-tools-5.11.0-37-generic软件包只支持amd64，只不过amd64和x86_64是兼容的。问题会具体表现为：
- 启动`perf`时提示：
    ```text
    WARNING: perf not found for kernel 5.11.0-37
      You may need to install the following packages for this specific kernel:
        linux-tools-5.11.0-37-generic
        linux-cloud-tools-5.11.0-37-generic
      You may also want to install one of the following packages to keep up to date:
        linux-tools-generic
        linux-cloud-tools-generic
    ```
- 以`apt install linux-tools-5.11.0-37-generic`安装`linux-tools-5.11.0-37-generic`时报错：
    ```text
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    E: Unable to locate package linux-tools-5.11.0-37-generic
    E: Couldn't find any package by glob 'linux-tools-5.11.0-37-generic'
    ```

## 异常解决

推荐阅读：[SPECjvm2008已知问题解决方案](https://www.spec.org/jvm2008/docs/KnownIssues.html)

## 参考资料

1. [菜鸟教程 Linux apt 命令](https://www.runoob.com/linux/linux-comm-apt.html)
2. [菜鸟教程 Docker 容器使用](https://www.runoob.com/docker/docker-container-usage.html)
3. [Gist: Install perf inside docker container](https://gist.github.com/nidhi-ag/0eed632509a79ebc75218a8485a1ebe1)
