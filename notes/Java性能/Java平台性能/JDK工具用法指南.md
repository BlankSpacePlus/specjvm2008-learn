# jps：列出目标系统上已检测的JVM

[jps](https://docs.oracle.com/en/java/javase/20/docs/specs/man/jps.html)命令列出了目标系统上的已安装的具有访问权限的HotSpot虚拟机。

jps命令用法：
- `jps [-q] [-mlvV] [<host_id>]`
- `jps [-help]`

jps命令参数：
- `-q`：仅输出本地JVM标识的列表，不输出类全名、JAR文件名、传递给主方法的参数。
- `-mlvV`：可以任意组合。
    - `-m`：显示传递给主方法的参数。对于嵌入式JVM，输出可能为空。
    - `-l`：显示应用程序主类的完整包名或应用程序JAR文件的完整路径名。
    - `-v`：显示传递给JVM的参数。
    - `-V`：抑制类名、JAR文件名和传递给主方法的参数的输出，仅生成本地JVM标识的列表。
- `<host_id>`：应生成进程报告的主机标识符。hostid可以包括可选的组件，指示通信协议、端口号和其他特定于实现的数据。请参阅主机标识符。
- `-help`：显示jps命令的帮助消息。

如果未指定`<host_id>`运行jps命令，则它将在本地主机上搜索已安装的JVM；如果指定`<host_id>`运行jps命令，则它将使用指定的协议和端口在指定的主机上搜索JVM。

主机标识符`<host_id>`是一个字符串，用于指示目标系统，格式为：`[<protocol>:][[//]<host_name>][:<port>][/<server_name>]`。
- `<protocol>`：通信协议。
    - 如果省略协议并且未指定主机名，则默认协议是特定于平台的优化的本地协议。
    - 如果省略协议并且指定了主机名，则默认协议是rmi。
- `<host_name>`：指示目标主机的主机名或IP地址。
    - 如果省略`<host_name>`参数，则目标主机是本地主机。
- `<port>`：与远程服务器通信的默认端口。
    - 如果省略`<host_name>`参数或`<protocol>`参数指定了优化的本地协议，则忽略`<port>`参数。
    - 否则，`<port>`参数的处理方式取决于具体实现。对于默认的rmi协议，`<port>`参数指示远程主机上rmiregistry的端口号。如果省略`<port>`参数，并且`<protocol>`参数指定为rmi，则使用默认的rmiregistry端口（1099）。
- `<server_name>`：此参数的处理方式取决于具体实现。
    - 对于优化的本地协议，忽略此字段。
    - 对于rmi协议，该参数是一个表示远程主机上RMI远程对象名称的字符串。请参阅jstatd命令的-n选项。

jps命令报告了在目标系统上找到的每个已安装的JVM的lvmid。lvmid（本地JVM标识符）通常是操作系统对应JVM进程的进程标识符。

```shell
lvmid [ [ classname | JARfilename | "Unknown"] [ arg* ] [ jvmarg* ] ]
```

arg当尝试将参数映射到其实际位置参数时，包含嵌入空格的值会产生歧义。

Oracle官方指出：
> It's recommended that you don't write scripts to parse jps output because the format might change in future releases. If you write scripts that parse jps output, then expect to modify them for future releases of this tool.

如果没有选项，jps命令会列出每个Java应用程序的lvmid，后跟应用程序的类名或JAR文件名的简短形式（省略了类的包信息或JAR文件的路径信息）。

jps命令使用Java启动器来查找类名和传递给主方法的参数。<br>
如果目标JVM是使用自定义启动器启动的，则类或JAR文件名以及主方法的参数将不可用。在这种情况下，jps命令输出的类名或JAR文件名为"Unknown"，主方法的参数也为"Unknown"。

jps命令列出的JVM列表受到操作系统特定访问控制机制的限制。

命令示例1：
```shell
> jps
18027 Java2Demo.JAR
18032 jps
18005 jstat
```

命令示例2：
```shell
> jps -l remote.domain
3002 /opt/jdk1.7.0/demo/jfc/Java2D/Java2Demo.JAR
2857 sun.tools.jstatd.jstatd
```

命令示例3：
```shell
> jps -m remote.domain:2002
3002 /opt/jdk1.7.0/demo/jfc/Java2D/Java2Demo.JAR
3102 sun.tools.jstatd.jstatd -p 2002
```
