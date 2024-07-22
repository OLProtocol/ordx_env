#!/bin/bash

ports=(8001 8007 8003 8008 8005 8009)

check_port() {
    port=$1
    result=$(lsof -i:"$port" | wc -l)
    if [ "$result" -lt 2 ]; then
        echo "Port $port is not running. Restarting sshd..."
        systemctl restart sshd
    else
        lsof -i:"$port" | awk 'NR > 1 && $8 ~ /TIME_WAIT|CLOSE_WAIT/ && ++count[$8] > 3 {system("kill -9 " $2)}'
    fi
}

while true; do
    for port in "${ports[@]}"; do
        check_port "$port"
    done
    sleep 300
done
