#!/bin/bash
# set -x
set -e

ports=(8001 8003 8005 8007 8008 8009 8011)

check_port() {
    local port="$1"
    result=$(lsof -i:"$port" | wc -l)
    if [ "$result" -lt 2 ]; then
        # systemctl restart sshd
        echo "sshd service for port $port is not running. need? to Restarting sshd..."
    else
        processes=$(lsof -i:"$port" | grep -E 'CLOSE_WAIT|TIME_WAIT' | awk '{print $2}' | awk '!a[$0]++' | xargs)
        echo "check port $port for TIME_WAIT and CLOSE_WAIT and kill it, processes: $processes"
        if [ -n "$processes" ]; then
            for pid in $processes; do
                kill -9 "$pid"
            done
        fi
    fi
}

while true; do
    echo "Start checking ports..."
    for port in "${ports[@]}"; do
        check_port "$port"
    done
    echo "Checking ports is done, waiting for 5 minutes..."
    sleep 60 # Wait for 5 minutes
done
