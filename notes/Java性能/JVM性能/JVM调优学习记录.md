# JVM调优标志

除了少数例外，JVM接收两种标志：布尔标志和附带参数的标志。
- 布尔标志：`-xx:+<FlagName>`表示开启FlagName，`-xx:-<FlagName>`表示关闭FlagName。
- 附带参数的标志：`-xx:<FlagName>=<FlagValue>`设置FlagName的值为FlagValue。
