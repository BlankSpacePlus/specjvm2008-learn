# Java性能优化

Java性能优化主要分为两部分：
- JVM性能优化：通过配置JVM标志来影响虚拟机性能。
    - 布尔标志：`-xx:+<FlagName>`表示开启FlagName，`-xx:-<FlagName>`表示关闭FlagName。
    - 附带参数的标志：`-xx:<FlagName>=<FlagValue>`设置FlagName的值为FlagValue。
- Java平台性能优化：应用程序编码中正确地应用最佳实践。
    - Java语言底层性能优化。
    - Java标准API调用优化。
