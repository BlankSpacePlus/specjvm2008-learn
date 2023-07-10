# 基本信息

[SPEC](https://www.spec.org)是一个非营利性组织，旨在建立、维护和认可用于评估最新一代计算系统性能和能源效率的标准化基准和工具。SPEC开发基准套件，并审查并发布来自SPEC的成员组织和其他基准许可方提交的结果。

SPECjvm2008是一个基准测试套件，包含几个现实场景的应用程序和一些专注于核心Java功能的基准测试。SPEC旨在通过SPECjvm2008基准来衡量系统和在这些系统上运行的JVM的整体性能。

下面是一些SPECjvm2008的关键基本信息：
- SPECjvm2008是由Java小组的核心设计团队开发的。AMD、BEA、HP、IBM、Intel、Sun都参与了该产品的设计、实施和测试阶段。
- SPECjvm2008计划在2006年发布，测试和其他延迟导致发布于2008年，因此命名为SPECjvm2008。
- SPECjvm2008测试JRE在典型Java应用程序上的性能，包括JAXP、Crypto库，不包括JavaEE内容（EJB、Servlet、JSP等）。SPECjvm2008的测试结果可以反映出JVM内部的各种组件，例如JRE、JIT、Java内存管理系统、线程和同步功能。
- SPECjvm2008在执行JRE的上下文中测量操作系统和硬件的性能，可以反映硬件处理器和内存子系统的性能（内核和处理器数量的影响、处理器频率、整数和浮点运算、高速缓存层次结构、内存子系统）。
- SPECjvm2008对文件I/O的依赖性低（执行期间对文件的读写操作较少甚至几乎没有），并且不包括远程网络I/O。这是为了尽量减少文件I/O操作对SPECjvm2008基准测试的影响，以便更好地集中在计算和内存访问等方面的性能测量，获得更准确的性能测量结果。
- SPECjvm2008除了测试吞吐量以外，还关注Java用户体验。
- SPECjvm2008的jar包中包含其全部源码。
- SPECjvm2008的源码也被公开在[GitHub](https://github.com/connorimes/SPECjvm2008)上。
- SPECjvm2008只能在单个JVM实例中工作，侧重于执行单个应用程序的JRE的性能。
- SPECjvm2008支持多线程，不局限于SPECjvm98的单线程支持，在设计时也考虑到了现代多核处理器。运行SPECjvm2008工作负载的单个JVM实例将生成足够多的线程来对底层硬件系统施加压力。
- SPECjvm2008采用定时运行的运行模式，其中基准测试应尽可能在测量期内完成。
- SPECjvm2008更偏向于服务器环境的Java性能测试，因为每个硬件线程的最低内存要求是512MB。
- SPECjvm2008的结果发布于[SPEC官方网站](https://www.spec.org/jvm2008/results/)。
- SPECjvm2008无法与任何其他基准进行比较。
- SPECjvm2008的工作负载为JVM产品提供了许多改进代码生成、线程、内存管理、锁算法调整的帮助，这种改进可能体现在各个SPECjvm2008工作负载得分上。

# 关键名词

- Operation：每次对基准测试工作负载的调用称为一个操作。测试框架会多次调用基准测试，使其在一次迭代中执行多个操作。
- Iteration：一次迭代持续一定的时间，默认为240秒。在此期间，测试框架将启动多个操作，每当前一个操作完成后立即启动新的操作。它不会中止一个操作，而是等待操作完成后再停止。测试框架期望在一个迭代内完成至少5个操作。迭代的持续时间不会少于指定的时间，但如果操作花费的时间过长，根据预热期间的性能情况，可能会增加迭代的时间。
- Warmup：第一次迭代可以称为预热迭代，默认的运行时间为120秒。预热迭代的结果不包括在基准测试结果中。如果想要跳过预热，可以将预热时间设置为0。
- Parallelism：大多数基准测试都是并行运行的，即多个操作在单独的线程中同时启动。从测试框架的角度来看，这些线程相互独立工作，但工作负载的设计旨在引入一系列有趣的问题，包括在应用程序级别共享数据和工作，以及使用JVM内部共享的资源。
- Analyzer：可以使用SPECjvm2008基准测试框架来分析运行过程中发生的情况（例如，查看基准测试运行期间的堆使用情况），以便了解和诊断产品。为了实现这一点，测试框架可以在基准测试运行期间运行一个或多个分析器。这些分析器将收集信息，并与基准测试结果一起提供结果。它将在报告的详细图表中绘制信息，其中绘制了每个基准测试操作，并且可以为每个迭代报告摘要指标。分析器可以在基准测试运行期间轮询信息，也可以实现回调方法，基于事件报告结果。
- Startup Benchmark：启动基准测试测量JVM和应用程序的启动性能。ops/m指标是使用新启动的JVM（通过java.lang.Runtime.exec()）运行每个工作负载一次操作所需的时间来计算的。这既测试了基本的JVM启动时间，也测试了启动基准测试工作负载的时间，因为为了获得多个基准测试中的最佳得分，优化代码的热点区域至关重要。
- SciMark Large and Small Workloads：SciMark工作负载使用小型和大型数据集大小进行运行。小型数据集适应大多数现代CPU架构上可用的L2缓存，并旨在测试JVM代码优化和计算性能，同时确保数据集仅在缓存中访问。大型数据集足够大，无法适应标准的L2缓存，并旨在测试针对内存和内存子系统性能的JVM优化。scimark.monte_carlo工作负载仅运行一次，因为它不使用可修改的计算数据集。

# 系统环境

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
- 外存：256MB
- 为了使用尽可能少的资源，可以只运行一个基准测试线程，使用选项`-bt 1`。但是，这会影响测试结果。

SPECjvm2008旨在在使用更大的机器（由逻辑CPU的数量决定）时扩展工作负载。当工作负载增加时，实时数据量会增加，并且上述最小内存、外存（derby基准测试会将数据存储在磁盘上）容量将不够用。

查看WSL版本：
```shell
wsl -l -v
```

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

# 版本约束

查看Java版本：
```shell
java -version
```

Java5以下版本可能无法运行SPECjvm2008。

Java5可能遇到如下问题：
- BEA JRockit、HP JVM、Sun Hotspot等JVM产品依赖的Apache Xerces库存在竞争，可能导致`xml.transform`测试失败。可以使用`java -jar SPECjvm2008.jar -Dspecjvm.benchmark.threads.xml.tranform=1`命令采用一个基准测试线程来避免竞争。<br>
- Unix或Linux操作系统上，Sun Hotspot依赖的JAXP库解析目录字符串的方式存在问题，可能导致`xml.validation`测试出现`java.lang.NullPointerException`。可以用`java -jar SPECjvm2008.jar -xd `\`pwd\``/resources/xml.validation`命令指定绝对路径来解决问题。

Java6、Java7可能是比较合适的版本。

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

# 安装配置

Linux环境无法用`wget`直接绕过Oracle的登录限制下载安装包，因此只能通过下载到本机后传输到Linux机器的方式实现下载。

例如，下面的命令获得的不是正确的tar.gz文件：
```shell
wget https://download.oracle.com/otn/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz
```

当执行解压命令时会报错：
```text
gzip: stdin: not in gzip format
tar: Child returned status 1
tar: Error is not recoverable: exiting now
```

## 安装配置Java8

解压JDK1.8压缩文件：
```shell
tar -zxvf jdk-8u371-linux-x64.tar.gz
```

配置Java8环境变量：
```shell
vim /etc/profile
```

向`/etc/profile`文件中添加下面的内容：
```shell
export JAVA_HOME=/home/<username>/jdk1.8.0_371
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$SRILM/bin/i686-m64:$SRILM/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JAVA_HOME
export PATH="$PATH:/tmp/bin"
```

修改后立即生效：
```shell
source /etc/profile
```

将安装的JDK加入java/javac候选清单：
```shell
sudo update-alternatives --install /usr/bin/java java /home/<username>/jdk1.8.0_371/bin/java 300
sudo update-alternatives --install /usr/bin/javac javac /home/<username>/jdk1.8.0_371/bin/javac 300
```

修改Ubuntu系统默认java/javac：
```shell
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

## 安装配置Java7

选择合适的Java安装包：

解压JDK1.7压缩文件：
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

将安装的JDK加入java/javac候选清单：
```shell
sudo update-alternatives --install /usr/bin/java java /home/<username>/jdk1.7.0_80/bin/java 300
sudo update-alternatives --install /usr/bin/javac javac /home/<username>/jdk1.7.0_80/bin/javac 300
```

修改Ubuntu系统默认java/javac：
```shell
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

## 安装配置SPECjvm2008

下载SPECjvm2008：<br>
获取[SPECjvm2008_1_01_setup.jar](https://www.spec.org/jvm2008/)

WSL2环境安装SPECjvm2008会卡住，因为缺少依赖，可通过补全依赖解决：
```shell
sudo apt install x11-apps
sudo apt install x11-session-utils
sudo apt install dconf-editor
sudo apt install gedit
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
- `SPECjvm2008/props/specjvm.reporter.properties`：用于丰富报表的输出内容，显示一些无法通过自动检测得到的环境信息，例如内存型号、逻辑CPU个数等。

SPECjvm2008配置文件`specjvm.properties`常见修改：
```properties
specjvm.additional.properties.file=props/specjvm.reporter.properties // 指定报表配置文件路径
specjvm.benchmark.analyzer.names=HeapMemoryFreeAnalyzer HeapMemoryTotalAnalyzer // JVM堆分析器
specjvm.home.dir=/home/<user_name>/SPECjvm2008 // SPEC_HOME路径
specjvm.iteration.time=240s // 迭代时长
specjvm.startup.jvm_options=-Xms1024m -Xmx1024m -XX:+UseConcMarkSweepGC // 默认JVM调优参数
```

空白行和以字符`#`开头的行将被忽略。

安装成功测试：
```shell
java -jar SPECjvm2008.jar -wt 5s -it 5s -bt 2 -i console -ikv compress
```

# 工作负载

SPECjvm2008提供了以下38项工作负载：
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
- `startup.xml.transform`：测试单次XML转换所需的时间，转换包括DOM、SAX、Stream方式。
- `startup.xml.validation`：测试单次XMLSchema校验所需的时间。
- `compiler.compiler`：在规定时间内，多线程迭代测试OpenJDK编译器的编译，得出ops/m。
- `compiler.sunflow`：在规定时间内，多线程迭代测试sunflow图像渲染的编译，得出ops/m。
- `compress`：在规定时间内，多线程迭代测试压缩，得出ops/m。
- `crypto.aes`：在规定时间内，多线程迭代测试AES/DES加解密算法，得出ops/m。
- `crypto.rsa`：在规定时间内，多线程迭代测试RSA加解密算法，得出ops/m。
- `crypto.signverify`：在规定时间内，多线程迭代测试使用MD5withRSA、SHA1withRSA、SHA1withDSA、SHA256withRSA来签名，识别，得出ops/m。
- `derby`：在规定时间内，迭代测试数据库相关逻辑，包括数据库锁、BigDecimal计算等，最后得出ops/m。
- `mpegaudio`：在规定时间内，多线程迭代mpeg音频解码，得出ops/m。
- `scimark.fft.large`：在规定时间内，多线程迭代测试快速傅立叶变换（按位反转、时间复杂度$O(n\log{n})$），使用32M大数据集，最后得出ops/m。
- `scimark.lu.large`：在规定时间内，多线程迭代测试矩阵LU分解（计算密集型、$2048×2048$），执行线性代数核(BLAS)和密集矩阵运算，使用32M大数据集，最后得出ops/m。
- `scimark.sor.large`：在规定时间内，多线程迭代测试矩阵（$2048×2048$）Jacobi逐次超松弛迭代法，在有限差分应用程序中练习典型的访问模式，采用用基本的“网格平均”记忆模式，使用32M大数据集，最后得出ops/m。
- `scimark.sparse.large`：在规定时间内，多线程迭代测试稀疏矩阵（$200000×200000$、4000000个非0数值）乘积，对数据集进行间接寻址和非常规内存引用，使用32M大数据集，最后得出ops/m。
- `scimark.fft.small`：在规定时间内，多线程迭代测试快速傅立叶变换（按位反转、时间复杂度$O(n\log{n})$），使用512K小数据集，最后得出ops/m。
- `scimark.lu.small`：在规定时间内，多线程迭代测试矩阵LU分解（计算密集型、$100×100$），执行线性代数核(BLAS)和密集矩阵运算，使用512KB小数据集，最后得出ops/m。
- `scimark.sor.small`：在规定时间内，多线程迭代测试矩阵（$250×250$）Jacobi逐次超松弛迭代法，在有限差分应用程序中练习典型的访问模式，采用用基本的“网格平均”记忆模式，使用512KB小数据集，最后得出ops/m。
- `scimark.sparse.small`：在规定时间内，多线程迭代测试稀疏矩阵乘积（$25000×25000$、62500个非0数值），对数据集进行间接寻址和非常规内存引用，使用512KB小数据集，最后得出ops/m。
- `scimark.monte_carlo`：在规定时间内，多线程迭代测试蒙特卡罗算法，对$[0,1]$上的四分之一圆$y=\sqrt{1-x^{2}}$积分近似求$\pi$，对$[0,1]$上的单位正方形及其内切圆计算随机点分布在圆内与圆外的比率，得出ops/m。`scimark.monte_carlo`只运行一次，但要经过large和small数据集上的计算。
- `serial`：在规定时间内，多线程迭代测试通过Socket传输Java序列化对象到对端反序列化（基于JBoss Serialization Benchmark），得出ops/m。
- `sunflow`：在规定时间内，利用Sunflow多线程迭代测试图片渲染，得出ops/m。
- `xml.transform`：在规定时间内，多线程迭代测试XML转换，通过使用DOM、SAX、Stream源执行XSLT转换来执行JAXP实现，采用了10个源自日常生活的数据样例，得出ops/m。
- `xml.validation`：在规定时间内，多线程迭代测试XMLSchema验证，根据XMLSchema验证XML实例文档来执行JAXP实现，采用了6个源自日常生活的数据样例，得出ops/m。

这些工作负载可以分为11类：

| 工作负载类别 | 工作负载数量 | 工作负载清单 | 类别信息说明 |
|:----:|:----:|:----:|:----|
| `compiler` | 2 | `compiler.compiler`<br>`compiler.sunflow` | 该基准测试使用OpenJDK前端编译器来编译一组.java文件。所编译的代码包括javac本身和SPECjvm2008中的sunflow子基准。该基准测试使用SPEVjvm2008实现的spec.benchmarks.compiler.SpecFileManager来处理内存、缓存，而不是进行磁盘和文件系统操作，以期减少I/O的影响。采用'-proc:none'选项可以使该基准测试与1.5版本兼容。 |
| `compress` | 1 | `compress` | 该基准测试使用修改后的Lempel-Ziv算法(LZW)对数据进行压缩，查找常见的子字符串并用可变长度的编码替换它们。该算法是确定性的，并且可以即时执行。该算法来源于[Welch, "A Technique for High-Performance Data Compression," in Computer, vol. 17, no. 6, pp. 8-19, June 1984, doi: 10.1109/MC.1984.1659158.](https://ieeexplore.ieee.org/document/1659158)，使用大约为67KB的内部表和基于输入数据的伪随机访问。该基准测试继承自SPECjvm98，测试的数据量从90KB扩展到3.36MB。为了最大限度地减少I/O的影响，数据被缓冲。当JVM生成和处理混合长度数据访问时，此工作负载会执行即时编译、内联、数组访问和缓存性能。|
| `crypto` | 3 | `crypto.aes`<br>`crypto.rsa`<br>`crypto.signverify` | 该基准测试侧重于加密领域的不同方面，并分为三个不同的子基准测试。这些不同的基准测试使用产品内部的实现，因此重点关注协议的供应商实现以及执行方式。<br>`aes`加密和解密使用AES和DES协议，使用CBC/PKCS5Padding和CBC/NoPadding。输入数据大小为100B、713KB。<br>`rsa`加密和解密使用RSA协议，使用输入数据大小为100B、16KB。<br>`signverify`使用MD5withRSA、SHA1withRSA、SHA1withDSA、SHA256withRSA协议进行签名和验证，输入数据大小为1KB、65KB、1MB。 |
| `derby` | 1 | `derby` | 该基准测试使用纯Java编写的开源数据库derby。启动此工作负载时会实例化多个数据库，每4个线程共享一个数据库实例。该基准测试与业务逻辑结合，在对数据库（特别是锁）测试的同时，会针对java.math.BigDecimal进行压力测试。java.math.BigDecimal的计算数值尽量超过64位二进制，以便不仅仅关注“简单”的java.math.BigDecimal。该基准测试是SPECjvm98的db基准测试的直接替代，但具备更强的功能，并且尽可能接近一个真实的应用程序。 |
| `mpegaudio` | 1 | `mpegaudio` | 该基准测试与SPECjvm98的mpegaudio非常相似，只是其中mp3库已被替换为JLayer。JLayer主要依赖浮点数运算，对mp3解码任务表现良好。 |
| `scimark large` | 5 | `scimark.fft.large`<br>`scimark.lu.large`<br>`scimark.sor.large`<br>`scimark.sparse.large`<br>`scimark.monte_carlo` | 这个基准测试是由NIST开发的，被业界广泛使用作为一个浮点数基准测试，主要针对密集数学计算的浮点运算和数据访问模式。每个子测试（fft、lu、monte_carlo、sor、sparse）都被纳入SPECjvm2008中。这个测试有两个版本，这里是使用“大”数据集，数据量有32MB，对对内存子系统进行压力测试，测试缓存外系统性能。 |
| `scimark small` | 5 | `scimark.fft.small`<br>`scimark.lu.small`<br>`scimark.sor.small`<br>`scimark.sparse.small`<br>`scimark.monte_carlo` | 这个基准测试是由NIST开发的，被业界广泛使用作为一个浮点数基准测试。每个子测试（fft、lu、monte_carlo、sor、sparse）都被纳入SPECjvm2008中。这个测试有两个版本，这里是使用“小”数据集，数据量有512KB，对JVM进行压力测试。 |
| `serial` | 1 | `serial` | 该基准测试对基本类型和引用类型进行序列化和反序列化，使用了JBoss基准测试的数据。该基准测试采用生产者-消费者场景，生产者线程通过socket发送序列化的对象，并由同一系统上的消费者线程进行反序列化。该基准测试重点测试java.lang.Object.equals()方法，需要调用java.lang.reflect包。 |
| `startup` | 17 | `startup.helloworld`<br>`startup.compiler.compiler`<br>`startup.compiler.sunflow`<br>`startup.compress`<br>`startup.crypto.aes`<br>`startup.crypto.rsa`<br>`startup.crypto.signverify`<br>`startup.mpegaudio`<br>`startup.scimark.fft`<br>`startup.scimark.lu`<br>`startup.scimark.monte_carlo`<br>`startup.scimark.sor`<br>`startup.scimark.sparse`<br>`startup.serial`<br>`startup.sunflow`<br>`startup.xml.transform`<br>`startup.xml.validation` | 该基准测试为每个操作启动一个新的JVM，并从开始到结束进行时间测量。启动基准测试是单线程的，这允许在启动时进行多线程JVM优化。启动器必须与提交时的“main”JVM相同。可以修改启动器和启动器参数。每个启动基准测试都使用单个基准测试作为启动基准测试的参数，除了derby。其中，startup.scimark基准测试使用512千字节的数据集。 |
| `sunflow` | 1 | `sunflow` | 该基准测试使用开源的全局光照渲染系统进行图形可视化的测试。sunflow库在内部是多线程的，即可以运行多个依赖线程束以渲染图像。此工作负载是浮点繁重的，其高对象分配率会对内存带宽造成压力。实际应用中，只需要4个内部sunflow线程即可符合要求，具体线程数可以通过属性specjvm.benchmark.sunflow.threads.per.instance进行配置，不能超过16个。默认情况下，基准测试工具将使用基准线程数的一半，即会并行运行与硬件线程数一半相当的sunflow基准测试实例。这可以在specjvm.benchmark.threads.sunflow中进行配置。 |
| `xml` | 2 | `xml.transform`<br>`xml.validation` | 该基准测试有两个子基准测试：xml.transform、XML.validation，每个用例对工作负载得分的影响大致相同。两种XML工作负载都具有高对象分配率和高级别的争用锁。此外，它们还涉及大量的字符串操作。<br>`xml.transform`通过将样式表（.xsl文件）应用于XML文档来测试JRE对javax.xml.transform（及其相关API）的实现。样式表和XML文档是几个实际示例，其大小和所使用的样式表功能各不相同（从3KB到156KB）。对xml.transform进行结果验证比对其他基准测试进行结果验证更复杂，因为不同的XML样式表处理器可能会产生略有不同但仍然正确的结果。<br>操作过程：首先，在测量间隔开始之前，运行一次工作负载并收集输出，对其进行规范化处理（符合规范化XML格式的规范）并与预期的规范化输出进行比较。在进行规范化之前，将产生HTML的转换输出转换为XML。此外，从此输出生成一个校验和。在测量间隔内，仅使用校验和检查每个操作的输出。<br>`xml.transform`的一次“操作”包括处理每个样式表/文档对，并以DOM源、SAX源和流源访问XML文档。为了确保每个样式表/文档对对于单个操作所花费的时间大致相等，一些输入对在一个操作期间会被多次处理。<br>`xml.validation`通过使用XML模式（.xsd文件）对XML实例文档进行验证，测试JRE对javax.xml.validation（及其相关API）的实现。模式和XML文档是几个实际示例，其大小和所使用的XML模式功能各不相同（从1KB到607KB）。xml.validation的一个“操作”包括处理每个样式表/文档对，并以DOM源和SAX源访问XML文档。与xml.transform类似，一些输入对在一个操作期间会被多次处理，以确保每个输入对对于单个操作所花费的时间大致相等。 |

通过对工作负载及其分组的联合分析，我们可以发现：
1. helloworld工作负载没有吞吐量测试
2. 除了derby，非startup（吞吐量测试）工作负载分组的工作负载都有对应的startup（启动）工作负载项。

# 测试周期

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

SPECjvm2008的一项基准测试需要2分钟（120s）的预热时间和4分钟（240s）的测量运行时间。在此期间，多项不被中断的操作将被执行，直到所有线程都完成了在测量间隔内开始的操作才会终止。实际的测量周期会长于预估的4分钟，某些情况下时间甚至会明显增加。<br>
因此，总的执行时间至少为$21×6=126$分钟，即大约2小时。

为了保证公平和准确性、确保在测量期内开始的每个操作都会对测量结果产生影响，SPECjvm2008的操作会继续执行直到所有在测量期内开始的操作都完成（即使测量期已经结束），但只有在测量期内执行的部分会被计算在内。<br>如果有一部分操作在测量期内开始但没有在期内完成，那么它对测量结果的贡献程度将取决于它在测量期内执行的时间比例，这个数值位于0到1之间。为了确保在测量期外执行操作不会有任何优势，测试框架会继续执行线程，直到所有在测量期内开始的操作都完成为止。这样可以确保测量结果的准确性，并使不同操作在相同条件下进行比较。

SPECjvm2008关注秒为单位的操作时长。通过连续运行多个操作（很可能是短时间的操作）并持续一段时间，会出现一些典型的JVM问题，例如内存系统的负载（分配、垃圾回收等），这是Java性能的关键。当连续运行基准测试操作4分钟时，JVM需要处理这些"副作用"。

## 预热时间

在进行Java性能测试时，预热（warm-up）是一个重要的步骤。预热是指在实际进行性能测试之前，先运行一段时间的代码，让JVM有足够的时间来进行优化和准备。
- 完成JVM优化：Java虚拟机在执行代码时会进行各种优化，如即时编译（Just-In-Time Compilation）、内联优化等。这些优化需要一定的时间来生效。通过进行预热，可以让JVM在真正的性能测试之前完成优化过程，使得测试结果更加准确。与此同时，JIT编译器会根据代码的执行情况来动态优化代码，预热可以让JIT编译器收集足够的执行数据，以便更好地进行优化。
- 完成类加载和初始化：Java应用程序通常涉及大量的类加载和初始化操作。在预热阶段，JVM可以加载和初始化所有相关的类，避免在性能测试期间由于类加载导致的性能波动。
- 完成缓存预热：在Java应用程序中，缓存对性能有着重要的影响。在预热阶段，可以通过模拟实际运行场景来预先填充缓存，使得性能测试期间的缓存命中率更接近真实情况。

# 测试启动

## 启动参数

完整命令格式：
```shell
java [<jvm options>] -jar SPECjvm2008.jar [<SPECjvm2008 options>] [<benchmark name> ...]
```

运行示例：
```shell
java -jar SPECjvm2008.jar --help
```

SPECjvm2008启动参数如下：

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

## 启动源码

从`src/META-INF/specjvm2008.mf`中查看到如下信息：

```java
Manifest-Version: 1.0
Main-Class: spec.harness.Launch
Class-Path: lib/derby.jar lib/jl1.0.jar lib/jcommon-1.0.9.jar lib/jfreechart-1.0.5.jar lib/sunflow.jar lib/janino.jar lib/javac.jar lib/xom-1.1.jar lib/Tidy.jar lib/check.jar build/classes
```

这意味着SPECjvm2008的jar包Main类是`spec.harness.Launch`。

`spec.harness.Launch`的main()方法是SPECjvm2008的入口，

```shell
public static void main(String [] args) {
    Properties commandLineProps = new Properties();
    boolean cont = CommandLineParser.parseArgs(args, commandLineProps);
    if (cont == false) {
        return;
    }
    runBenchmarkSuite(commandLineProps);
}
```

`spec.harness.CommandLineParser`的parseArgs()方法逐一解析String[]参数列表，将数据解析到Properties入参中。在一个for循环中不断地if...else if...else...，选择语句的判断条件通过部分硬编码和`spec.harness.Constants`实现。

回到，`spec.harness.Launch`的main()方法调用runBenchmarkSuite()方法：
1. 读取运行属性参数。
2. 添加命令行参数（覆盖属性文件中的参数）。
3. 设置上下文+1。
4. 获取版本信息。
5. 检查属性。
6. 确保基准测试存在（尽早发现拼写错误）。
7. 检查JAR文件和资源的校验和和签名，以便用户在输出之前就能得到一些结果。
8. 打开用于原始结果的文件。
9. 运行JVM检查基准测试。
10. 运行基准测试。
11. 处理分析器。
12. 处理结果。
13. 创建结果报告（可选）。
14. 在运行结束时打印已知的问题，暴露更多的细节。

# 测试模式

- `--base`：总基础吞吐量测量，从完全兼容的基础运行中获得的总体吞吐量结果，不允许做任何JVM参数调整。（默认）
- `--peak`：总峰值吞吐量测量，从完全兼容的峰值运行中获得的总吞吐量结果，可以使用命令行参数和属性文件配置JVM ，还允许反馈优化和代码缓存。peak模式对预热时间或测量间隔没有限制，但是每个工作负载只允许1次测量迭代。
- `--lagom`：Lagom工作负载是一个固定大小的工作负载，这意味着它会对每个基准测试执行一定数量的操作。Lagom是基准测试的base模式和peak模式的补充，用于需要运行固定数量的工作时。工作负载将在每个基准测试线程中运行指定数量的操作（每个基准测试的数量不同）。默认情况下，基准测试线程的数量将根据机器的硬件线程数进行调整，因此为了在不同大小的两个不同系统上具有相同数量的工作量，应该设置基准测试线程的数量。<br>Lagom工作负载不符合标准，旨在用于研究用途，作为衡量进展、开销或研究目的的工具。

| 属性 | base模式 | peak模式 |
|:----:|:----:|:----:|
| 迭代轮次 | 1 | 1 |
| 预热时间 | 120s | 随意 |
| 迭代时间 | 240s | 240s或更多 |
| 基准线程数 | 随意 | 随意 |

# 测试开销

SPECjvm2008的所有基准测试都需要很少的内核时间，并且CPU几乎总是处于用户模式，利用率不低于99%。SPECjvm2008的I/O开销做到了尽可能小，上下文切换率也较低。值得一提的是，SPECjvm2008上下文切换率最高的基准测试是derby。

## 上下文切换开销

SPECjvm2008团队官方提供的一组基准指标数据如下所示（没有startup基准和serial基准）：

| 基准测试 | 用户模式CPU占有率 | 内核模式CPU占有率 | 上下文切换次数/操作次数 |
|:----:|:----:|:----:|:----:|
| `compiler.compiler` | 99.57% | 0.27% | 33.92 |
| `compiler.sunflow` | 99.44% | 0.41% | 30.00 |
| `compress` | 99.93% | 0.02% | 50.78 |
| `crypto.aes` | 99.94% | 0.01% | 141.20 |
| `crypto.rsa` | 98.81% | 0.87% | 137.75 |
| `crypto.signverify` | 99.91% | 0.05% | 27.60 |
| `derby` | 97.80% | 1.06% | 2065.01 |
| `mpegaudio` | 99.79% | 0.19% | 87.01 |
| `scimark.fft.large` | 98.83% | 0.22% | 1895.77 |
| `scimark.lu.large` | 93.72% | 0.08% | 5409.42 |
| `scimark.sor.large` | 97.67% | 0.09% | 1073.89 |
| `scimark.sparse.large` | 92.70% | 0.35% | 1674.87 |
| `scimark.fft.small` | 99.97% | 0.01% | 6.94 |
| `scimark.lu.small` | 99.92% | 0.02% | 6.37 |
| `scimark.sor.small` | 99.97% | 0.01% | 40.97 |
| `scimark.sparse.small` | 99.82% | 0.03% | 59.13 |
| `scimark.monte_carlo` | 99.97% | 0.03% | 5.71 |
| `sunflow` | 99.45% | 0.08% | 414.96 |
| `xml.transform` | 88.75% | 0.71% | 417.58 |
| `xml.validation` | 99.93% | 0.02% | 30.47 |
| `SPECjbb2005` | 99.79% | 0.20% | 2.00 |
| `SPECjAppServer2004` | 78.63% | 19.50% | 37.00 |

## 垃圾收集开销

SPECjvm2008着重分析了与GC相关的MB/S、MB/OP、GC%三个指标。
- MB/S：MB/S代表每秒分配的内存总量大小，可以用来衡量内存分配的速度和频率。较高的MB/S值表示程序在较短的时间内分配了大量的内存，可能意味着程序对内存的需求较高或者存在内存泄漏等问题。
- MB/OP：MB/OP代表每个操作分配的平均内存大小，可以用来衡量单个操作对内存的消耗情况。具体的操作可以是方法调用、对象创建或其他需要内存分配的操作。较高的MB/OP值可能表示某些操作需要较大的内存空间，可能需要进一步优化以减少内存的使用。
- GC%：GC%代表在一定时间内进行垃圾回收的次数或占总执行时间的比例，反映了垃圾回收的频繁程度。GC率的高低与程序的内存使用情况有关。如果GC率较高，意味着垃圾回收发生频繁，可能说明程序在执行过程中产生了大量的临时对象或者存在内存泄漏等问题。这可能会导致较长的停顿时间，影响程序的性能和响应速度。如果GC率较低，即垃圾回收发生较少的次数或占总执行时间的比例较小，可以认为程序的内存使用较为有效，内存中的对象得到了有效的管理和释放，减少了不必要的资源浪费。

| 基准测试 | 内存分配MB/S | 内存分配MB/OP | 垃圾收集使用率 |
|:----:|:----:|:----:|:----:|
| `compiler.compiler` | 2422.45 | 155.10 | 3.97% |
| `compiler.sunflow` | 2590.88 | 143.27 | 2.31% |
| `compress` | 141.04 | 13.72 | 0.07% |
| `crypto.aes` | 868.22 | 237.53 | 0.16% |
| `crypto.rsa` | 298.96 | 9.14 | 0.02% |
| `crypto.signverify` | 875.96 | 44.80 | 0.05% |
| `derby` | 3041.56 | 1058.30 | 0.46% |
| `mpegaudio` | 317.34 | 54.73 | 0.01% |
| `scimark.fft.large` | 11.45 | 44.42 | 0.05% |
| `scimark.lu.large` | 8.31 | 97.04 | 0.06% |
| `scimark.sor.large` | No GC during measurement | No GC during measurement | No GC during measurement |
| `scimark.sparse.large` | 18.27 | 57.48 | 0.01% |
| `scimark.fft.small` | 604.26 | 8.27 | 0.04% |
| `scimark.lu.small` | 1277.90 | 15.95 | 0.09% |
| `scimark.sor.small` | No GC during measurement | No GC during measurement | No GC during measurement |
| `scimark.sparse.small` | 160.64 | 18.88 | 0.01% |
| `scimark.monte_carlo` | 9.95 | 0.12 | 0.03% |
| `sunflow` | 3405.07 | 1097.76 | 0.32% |
| `xml.transform` | 2832.37 | 109.14 | 0.27% |
| `xml.validation` | 2343.78 | 126.39 | 0.38% |
| `SPECjbb2005` | 3655.00 | 0.01 | 2.20% |
| `SPECjAppServer2004` | 1100.00 | 0.55 | 7.50% |

SPECjvm2008团队没有监测到`scimark.sor.large`和`scimark.sor.small`基准测试过程中的GC行为。多数基准测试的GC率低于0.1%，但`compiler.compiler`和`compiler.sunflow`基准测试的GC率明显偏高。

`derby`、`sunflow`、`xml.transform`、`xml.validation`这4项基准测试表现出了较高的内存分配率和较低的垃圾收集使用率。由于调用GC的速率与内存分配速率直接相关，因此它们运行时GC速率较快，而GC花费的时间较少。

## CPI与Pathlength

CPI（Cycles Per Instruction）是计算机体系结构和处理器性能的指标之一，它表示执行一条指令所需的平均时钟周期数，用于衡量程序执行的效率和处理器的性能。较低的CPI值表示指令执行效率高，每条指令完成所需的时钟周期较少，而较高的CPI值则表示指令执行效率较低，每条指令完成所需的时钟周期较多。

CPI的计算公式为：CPI=CPU时钟周期数/CPU执行的指令数

根据SPECjvm2008团队的研究结果，一些没有较低内存带宽要求的工作负载具有较低的CPI，具有较高CPI的工作负载显示出非常低的带宽需求。

Pathlength是软件工程的静态度量指标之一，它表示计算机程序中执行某个特定任务或代码段所经过的路径的长度。路径长度通常用于评估和比较不同程序或代码段之间的复杂性和执行效率。通过分析和优化路径长度，可以提高程序的性能和可维护性。

在程序执行过程中，每个语句和分支都会构成程序的一部分路径。路径长度是通过计算执行路径上的语句和分支数量来衡量的。路径长度可以用于衡量代码的复杂性，因为路径越长，程序的逻辑就越复杂。同时，路径长度也可以用于评估代码的执行效率，因为路径越长，执行过程中需要经过的操作就越多，可能导致程序的执行时间变长。

# 测试结果

## 测试结果文件

单次测试产物如下：
- `SPECjvm2008.<num>.raw`
- `SPECjvm2008.<num>.html`
- `SPECjvm2008.<num>.txt`
- `SPECjvm2008.<num>.sub`
- `SPECjvm2008.<num>.summary`

就此的一些说明：
- raw文件是在运行结束时从基准测试内部数据结构中的数据生成的，用于提交给SPEC。
- txt文件和html文件包含相同的基本信息，用于测试者查看。
- 如果html结果文件存在，还会有一个images子目录存放html中的图像。

## 测试评分数据

在性能测试中，通常会模拟真实场景下的负载并执行一系列操作，如请求处理、数据读写、计算等。通过测量在一分钟内完成的操作数，可以评估系统的处理能力和性能。SPECjvm2008选择opm/s作为度量吞吐量的单位。

ops/m是性能测试中的一个常见指标，表示每分钟完成的操作数（Operations Per Minute）。它用于衡量系统或应用程序在单位时间内能够处理的操作数量。较高的ops/m值表示系统具有更高的吞吐量和处理能力，能够在单位时间内处理更多的请求或操作。

SPECjvm2008对不同基准测试组的分数采用几何平均数来整合，计算公式为：$Score=\sqrt[k]{\sqrt[n_{1}]{X_{11}...X_{1n1}}...\sqrt[n_{k}]{X_{k1}...X_{knk}}}$。

根据[Wikipedia](https://en.wikipedia.org/wiki/Mean)的记录，平均数主要包括：
- Arithmetic Mean（算术平均数）：
    - 计算方法：将一组数据的所有值相加，然后除以数据个数。
    - 用途：用于计算数据的集中趋势，常用于描述一组数据的平均值。
- Arithmetic-Geometric Mean（算术-几何平均数）：
    - 计算方法：迭代计算算术平均数和几何平均数，直到收敛到一个特定值。
    - 用途：用于解决某些数学问题，如计算无理数的近似值等。
- Cubic Mean（立方平均数）：
    - 计算方法：将一组数据的所有值的立方相加，然后除以数据个数，再取立方根。
    - 用途：用于描述数据的集中趋势，对数据中较大值的影响更为敏感。
- Generalized/Power Mean（幂平均数）：
    - 计算方法：对一组数据的所有值进行幂运算（指定幂次），然后计算平均值。
    - 用途：用于计算数据集合的平均值，幂次可以控制对数据的敏感程度。
- Geometric Mean（几何平均数）：
    - 计算方法：将一组数据的所有值相乘，然后开根号（取乘积的n次方根，其中n为数据个数）。
    - 用途：用于计算数据的比例关系和增长率，适用于正数数据。
- Harmonic Mean（调和平均数）：
    - 计算方法：将一组数据的倒数相加，然后取倒数的平均值。
    - 用途：用于计算频率、速率和比率相关的数据，对较小值较为敏感。
- Heronian Mean（Heronian平均数）：
    - 计算方法：一种特殊形式的平均数，用于计算三个数的平均值。
    - 用途：常用于几何学和三角学中的特定计算。
- Heinz Mean（Heinz平均数）：
    - 计算方法：一种平均数定义，涉及素数分解和整数划分。
    - 用途：主要用于研究数论和数学中的特殊问题。
- Lehmer Mean（Lehmer平均数）：
    - 计算方法：一种平均数定义，涉及整数划分和多项式。
    - 用途：主要用于研究数论和数学中的特殊问题。

对于其中更常见的算术平均数、几何平均数、调和平均数，其优劣势与适用场景各不相同，具体选择哪种平均数取决于数据的特点和分析的目的。
- 算术平均数：
    - 优势：算术平均数是最常见和易于理解的平均数。它对异常值的影响较小，能够较好地代表数据的集中趋势。
    - 劣势：算术平均数对极端值较为敏感，受到极大或极小值的影响，可能不适用于偏斜或存在异常值的数据集。
    - 适用场景：如果数据集没有明显的异常值，并且数据分布接近正态分布，则算术平均数是一个常用的选择。
- 几何平均数：
    - 优势：几何平均数适用于对数值进行比例分析的情况，尤其在涉及增长率或比率的数据中非常有用。它对数据的乘积更敏感，因此能够平衡不同数据之间的影响。
    - 劣势：几何平均数对负数或零值无法计算，且较算术平均数更复杂，不太直观。
    - 适用场景：如果数据涉及比例、增长率或速率，而且数据集中存在较大的差异或极端值，那么几何平均数可能更合适。
- 调和平均数：
    - 优势：调和平均数在处理比例或速度相关的数据时很有用。它对极大或极小值较为敏感，能够突出较小值的影响。
    - 劣势：调和平均数对极端值和非正数值（零和负数）很敏感，且较算术平均数和几何平均数更复杂，不太直观。
    - 适用场景：如果数据集涉及比率、频率或速率，并且对较小值较为敏感，调和平均数可能是更恰当的选择。

SPECjvm2008团队官方提供的一组baseline数据如下所示：

| 工作负载 | 测试得分 |
|:----:|:----:|
| `compiler.compiler` | 937.23 |
| `compiler.sunflow` | 1119.25 |
| `compress` | 614.14 |
| `crypto.aes` | 214.77 |
| `crypto.rsa` | 2012.82 |
| `crypto.signverify` | 1173.08 |
| `derby` | 174 |
| `mpegaudio` | 350.44 |
| `scimark.fft.large` | 15.49 |
| `scimark.lu.large` | 5.14 |
| `scimark.sor.large` | 25.99 |
| `scimark.sparse.large` | 18.93 |
| `scimark.fft.small` | 4384.62 |
| `scimark.lu.small` | 4903.85 |
| `scimark.sor.small` | 713.61 |
| `scimark.sparse.small` | 509.41 |
| `scimark.monte_carlo` | 4903.85 |
| `sunflow` | 195.7 |
| `xml.transform` | 1540.12 |
| `xml.validation` | 1117.91 |

SPECjvm2008团队观察到相当数量的结果数据波动，波动幅度偶尔超过5%。

SPECjvm2008每个基准测试的分数都采用ops/m作为统一度量标准。而根据上表显示的结果，`scimark.lu.large`的结果数据只有5.14ops/m，反观`scimark.lu.small`和`scimark.monte_carlo`的结果数据分别高达4903.85ops/m和4903.85ops/m，这种差异是显著的。这种显著的差异是SPECjvm2008团队选择几何平均数而非算术平均数的重要原因。

与此同时，这样做意味着仅影响1项基准测试组的平台改进不太可能改变SPECjvm2008基准测试获得的总体指标。例如，将`derby`基准测试的性能提高一倍，同时保持其他组件不变，只能将SPECjvm2008的性能提升6%。

想要了解score计算的实现代码，我们可以关注SPECjvm2008的`spec.reporter.BenchmarkGroupRecords`类。

```java
public class BenchmarkGroupRecords {	
    TreeMap<String, BenchmarkGroupRecord> groupRecords = new TreeMap<String, BenchmarkGroupRecord>();    
    int  validBenchmarksNumber;
    boolean allBenchmarksValid = true;
    TreeMap<String, Double> scores = new TreeMap<String, Double>();    
 
    void addNewBenchmarkRecord(BenchmarkRecord record) {
    	if (record.isValidRun() && !Constants.CHECK_BNAME.equals(record.name)) {
    		if (!Constants.CHECK_BNAME.equals(record.name)) {
    		    validBenchmarksNumber ++;
    		}    		
    	}
    	allBenchmarksValid = allBenchmarksValid && record.isValidRun();    	
    	int index = record.name.indexOf(".");
    	if (index >= 0) {
    		String subgroup = record.name.substring(0, index);
    		if (Utils.isScimarkLarge(record)) {
    			subgroup += "." + Constants.SCIMARK_BNAME_LARGE_POSTFIX;
    		} else if (Utils.isScimarkSmall(record)) {
    			subgroup += "." + Constants.SCIMARK_BNAME_SMALL_POSTFIX;    			 
    		}    
    		if (Utils.isScimarkMonteCarlo(record)) {
    			updateGroupRecord(Constants.SCIMARK_SMALL_GNAME, record);
    			updateGroupRecord(Constants.SCIMARK_LARGE_GNAME, record);
    		}  else {
    			updateGroupRecord(subgroup, record);
    		}
    		
    	} else {
    		groupRecords.put(record.name, new BenchmarkGroupRecord(record));
    	}
    }   

    double computeCompositeScore() {    	
    	Iterator iter = groupRecords.keySet().iterator();
    	double product = 1;
    	int counter = 0;
    	while (iter.hasNext()) {
    		String key = (String) iter.next();
    		BenchmarkGroupRecord r = (BenchmarkGroupRecord)groupRecords.get(key);
    		if (r.bmRecords.size() > 0 && !Utils.isCheck(r.bmRecords.get(0))) {
    			double groupScore = r.computeScore();
    			Utils.dbgPrint("geo_mean: " + r.groupName + " " + groupScore);
    		    product *= groupScore;
    		    counter ++;
    		    scores.put(r.groupName, groupScore);
    		}     
    	}
    	if (counter == 0) {
    		return 1;
    	} 
    	double compositeScore = allBenchmarksValid ? Math.pow(product, (double) 1/counter) : Utils.INVALID_SCORE;
    	Utils.dbgPrint("composite score: " + compositeScore);
    	return compositeScore;
    }

    private void updateGroupRecord(String name, BenchmarkRecord record) {
    	if (!groupRecords.containsKey(name)) {
    		groupRecords.put(name, new BenchmarkGroupRecord(name));
    	}
    	groupRecords.get(name).addBenchmarkRecord(record);
    }   
}
```

`computeCompositeScore()`方法计算来自多个`spec.reporter.BenchmarkGroupRecords.BenchmarkGroupRecord`的混合分数：
1. 通过迭代器遍历`groupRecords`中的每个键值对，获取每个`spec.reporter.BenchmarkGroupRecords.BenchmarkGroupRecord`对象。
2. 判断该对象中的`bmRecords`属性值是否为空（集合中是否存在`spec.reporter.BenchmarkRecord`元素）且第一个元素不是`"check"`，如果满足条件，则调用该对象的`computeScore()`方法计算组得分。
3. 计算组得分后，将得分存入`scores`中，并将每个组得分累乘到`product`上，计数器`counter`记录有效组数。
4. 确认是否所有基准测试都是有效的，如果有效则计算组合得分，否则返回无效得分。

`spec.reporter.BenchmarkGroupRecords.BenchmarkGroupRecord`是`spec.reporter.BenchmarkGroupRecords`的内部类。

```java
static class BenchmarkGroupRecord {    
    String groupName;
    boolean isSingleBenchmark;    
    ArrayList<BenchmarkRecord> bmRecords = new ArrayList<BenchmarkRecord>();
    double score;
    boolean isValid = true;

    public BenchmarkGroupRecord(BenchmarkRecord record) {
        isSingleBenchmark = true;
        bmRecords.add(record);
        groupName = record.name;
    }

    public BenchmarkGroupRecord(String name) {
        groupName = name;            
    }

    void addBenchmarkRecord(BenchmarkRecord bmRecord) {
        bmRecords.add(bmRecord);            
    }

    double computeScore() {
        if (isSingleBenchmark) {
            BenchmarkRecord record = bmRecords.get(0); 
            score = record.maxScore;
            isValid = record.isValidRun();                
        } else {
            double product = 1;
            for (int i = 0; i < bmRecords.size(); i ++) {
                BenchmarkRecord record = bmRecords.get(i);                    
                isValid = isValid && record.isValidRun();
                Utils.dbgPrint("\t" + record.name + " " + isValid + " " + record.maxScore);
                product *= record.maxScore;
            }
            score = Math.pow(product, (double) 1/bmRecords.size());
        }
        score = isValid ? score : Utils.INVALID_SCORE;
        return score;
    }
}
```

`spec.reporter.BenchmarkGroupRecords.BenchmarkGroupRecord`的关键方法`computeScore()`计算来自多个`spec.reporter.BenchmarkRecord`的混合分数：
- 如果是单个基准测试组，则：
    1. 获取第一个基准测试记录。
    2. 将第一个基准测试记录的最大得分作为组得分。
    3. 判断该记录是否为有效运行。
- 如果是多个基准测试组，则：
    1. 通过循环遍历每个基准测试记录：
        1. 将其最大得分相乘得到一个累乘积。
        2. 判断每个记录是否为有效运行。
    2. 计算组得分，使用`java.lang.Math.pow()`函数对累乘积取几何平均数，并将结果作为组得分。
- 如果组得分为有效，则返回该得分；否则返回无效得分。

`spec.reporter.BenchmarkGroupRecords.BenchmarkGroupRecord`类提供了一个含`spec.reporter.BenchmarkRecord`类型属性的`java.util.ArrayList`集合。

```java
public class BenchmarkRecord {
    String name;
    String iterationsInfo;
    ArrayList<IterationRecord> iterRecords = new ArrayList<IterationRecord>();
    double maxScore = Double.MIN_VALUE;
    String[] configuration = new String[Utils.BM_CONFIGURATION_ENAMES.length];
    boolean isSubgroupMember;

    public BenchmarkRecord(String name, int numberBmThreads) {
        this.name = name;
        isSubgroupMember = name.indexOf(".") >= 0;
    }

    public void startHandling(String info) {
        iterationsInfo = info;
    }

    public IterationRecord addIterationRecord(String iter, String expectedRunTime, String startTime, String endTime, String operations) {
        String key = Constants.WARMUP_RESULT_ENAME.equals(iterationsInfo)
        ? "warmup" : "iteration " + iter;
        IterationRecord record = new IterationRecord(key, expectedRunTime, startTime, endTime, operations);
        if (!key.equals("warmup")) {
            maxScore = Math.max(maxScore, record.score);
        }
        iterRecords.add(record);
        return record;
    }

    public void printAllRecordedInfo() {
        for (int i = 0; i < iterRecords.size(); i ++) {
            IterationRecord record = (IterationRecord)iterRecords.get(i);
            System.out.println(record.iterName + " " + record.runTime + " " + record.operations);
        }
    }

    public boolean isValidRun() {
        boolean result = true;
        for (int i = 0; i < iterRecords.size(); i ++) {
            result = result & ((IterationRecord)iterRecords.get(i)).isValidIteration();
        }
        return result;
    }
}
```

`spec.reporter.BenchmarkRecord`类提供了一个含`spec.reporter.BenchmarkRecord.IterationRecord`类型属性的`java.util.ArrayList`集合，而`spec.reporter.BenchmarkRecord.IterationRecord`正是`spec.reporter.BenchmarkRecord`的一个内部类。

```java
static class IterationRecord {
    long runTime;
    String iterName;
    double operations;
    double score;
    String expectedRunTime;
    ArrayList<String> errors;

    public IterationRecord(String iterName, String expectedRunTime, String startTime, String endTime, String operations) {
        this.iterName = iterName;
        runTime = Long.parseLong(endTime) - Long.parseLong(startTime);
        this.operations = Double.parseDouble(operations);
        this.score = ((double) Double.parseDouble(operations)) * 60000 / (double)runTime;
        this.expectedRunTime = expectedRunTime;
    }

    final boolean isValidIteration() {
        return errors == null;
    }

    final void addError(String message) {
        if (errors == null) {
            errors = new ArrayList<String>();
        }
        errors.add(message);  
    }
}
```

`reporter.BenchmarkRecord.IterationRecord`提供了score属性，用于记录一个`spec.reporter.BenchmarkRecord`的分数。

# 标准流程

产生合规结果的推荐步骤：
1. 使用系统和提交信息`SPECjvm2008/props/specjvm.reporter.properties`为报告者编辑属性文件。这样做是为了确保未在基本运行中设置JVM参数属性和堆大小属性。
2. 使用harness配置`SPECjvm2008/props/specjvm.properties`编辑reporter的属性文件。一般来说，保留默认值即可，无需修改属性文件。如果修改，需要确保此配置文件指向报告者信息文件，还要确保这不包括对运行时的任何更改。
3. 使用运行脚本或直接从命令行运行base模式：
    ```shell
    java -jar SPECjvm2008.jar --base --propfile props/specjvm.properties
    ```
4. 更新peak运行的属性文件，包括JVM参数属性的更新。
5. 使用运行脚本或直接从命令行运行peak模式：
    ```shell
    java -Xms3000m -Xmx3000m -jar SPECjvm2008.jar --peak --propfile props/specjvm.properties
    ```
6. 查看`SPECjvm2008/results/`文件夹中的输出结果。

提交合规结果的推荐步骤：
1. 生成一个新的raw文件（以前文件的合并版本），然后生成一个包含新raw文件的zip文件。
    ```shell
    java -jar SPECjvm2008.jar --reporter --prepare <base raw file> <optional peak raw file>
    ```
2. 通过将zip文件复制到新位置并运行来检查原始文件，检查的过程中创建一个简短的摘要报告，该报告链接到子文件夹中每次运行的完整报告：
    ```shell
    java -jar SPECjvm2008.jar --reporter --specprocess <zip file>
    ```
3. 将此zip文件邮寄到[subjvm2008@spec.org](subjvm2008@spec.org)。

# 启动测试

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

测试命令：
```shell
java -Djava.awt.headless=true -jar SPECjvm2008.jar -i console -ikv startup.helloworld  startup.compress startup.crypto.aes startup.crypto.rsa startup.crypto.signverify startup.mpegaudio startup.scimark.fft startup.scimark.lu startup.scimark.monte_carlo startup.scimark.sor startup.scimark.sparse startup.serial startup.sunflow startup.xml.validation compress crypto.aes crypto.rsa crypto.signverify derby mpegaudio scimark.fft.large scimark.lu.large scimark.sor.large scimark.sparse.large scimark.fft.small scimark.lu.small scimark.sor.small scimark.sparse.small scimark.monte_carlo serial sunflow xml.validation
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
- 以`sudo apt install linux-tools-5.11.0-37-generic`安装`linux-tools-5.11.0-37-generic`时报错：
    ```text
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    E: Unable to locate package linux-tools-5.11.0-37-generic
    E: Couldn't find any package by glob 'linux-tools-5.11.0-37-generic'
    ```

# 异常解决

推荐阅读：[SPECjvm2008已知问题解决方案](https://www.spec.org/jvm2008/docs/KnownIssues.html)
