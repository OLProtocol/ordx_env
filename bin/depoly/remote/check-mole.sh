#!/bin/bash

# 定义要检查的端口
ports=(8001 8007 8003 8008 8005 8009)

# 检查端口函数
check_port() {
    port=$1
    result=$(lsof -i:"$port" | wc -l)
    if [ "$result" -lt 2 ]; then
        echo "Port $port is not running. Restarting sshd..."
        systemctl restart sshd
    else
        # 检查超过1行的情况
        lsof -i:"$port" | awk 'NR > 1 && $8 ~ /TIME_WAIT|CLOSE_WAIT/ && ++count[$8] > 3 {system("kill -9 " $2)}'
    fi
}

# 循环检查端口
while true; do
    for port in "${ports[@]}"; do
        check_port "$port"
    done
    sleep 300 # 等待5分钟
done
