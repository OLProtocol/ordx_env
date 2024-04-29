#!/bin/bash

# 进程ID
PID=2896944
# 检查频率（秒）
SLEEP_INTERVAL=5
# 日志文件路径
LOG_FILE="process_watch.log"

while true; do
    # 使用 top 命令检查进程
    # -b：批处理模式（Batch mode 这个模式用于将 top 的输出用于脚本或文件。在批处理模式下，top 不会显示其交互式界面，而是直接将当前信息输出到标准输出
    # -n：指定更新次数（Number of iterations）。这个选项后面紧跟一个数字，用来指定 top 命令更新显示的次数。当指定 -n 1 时，top 会输出一次信息然后立即退出，而不是默认的持续更新直到用户退出
    OUTPUT=$(top -b -n 1 -p $PID | grep "^ *$PID")
    
    if [ -z "$OUTPUT" ]; then
        # 如果没有找到进程，记录时间
        echo "Process $PID not found at $(date)" >> $LOG_FILE
    else
        # 如果找到了进程，显示记录
        echo "$OUTPUT"
    fi
    
    sleep $SLEEP_INTERVAL
done