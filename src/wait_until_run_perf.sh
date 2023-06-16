#!/bin/bash

# 设置要查找的特定命令
command_name="java"
perf_args="record -p"

# 循环等待直到获取到特定命令的PID
while true; do
    # 使用pgrep命令获取命令的PID
    pid=$(pgrep "$command_name")
    # 如果找到PID，则输出并退出循环
    if [ -n "$pid" ]; then
        echo "PID: $pid"
	perf $perf_args "$pid" "-g"
        break
    fi
done

# 等待特定命令执行结束
while ps -p "$pid" > /dev/null; do
    sleep 1
done

# 特定命令执行结束后输出提示信息并退出程序
echo "Command execution completed."
