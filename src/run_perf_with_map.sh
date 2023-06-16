#!/bin/bash

set -m
export setting PERF_RECORD_SECONDS=360

java -XX:+PreserveFramePointer -jar SPECjvm2008.jar -ikv compress &
spec_pid=$!
echo $spec_pid
echo $(pgrep -x java)
perf-java-flames $spec_pid -F 99 -a -g -p $spec_pid &

wait
echo "Command execution completed."
