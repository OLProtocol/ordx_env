#!/bin/bash
# set -x
set -e

# Define the ports to check
ports=(8001 8007 8003 8008 8005 8009)

# Function to check a port
check_port() {
    port="$1"
    echo "Start checking port $port"
    result=$(lsof -i:"$port" | wc -l)
    if [ "$result" -lt 2 ]; then
        echo "Port $port is not running. Restarting sshd..."
        systemctl restart sshd
    else
        # Check for more than one line
        lsof -i:"$port" | awk 'NR > 1 && $8 ~ /TIME_WAIT|CLOSE_WAIT/ && ++count[$8] > 3 {system("kill -9 " $2)}'
    fi
    echo "Checking port $port is done"
}

# Loop to check ports
while true; do
    echo "Start checking ports..."
    for port in "${ports[@]}"; do
        check_port "$port"
    done
    echo "Checking ports is done, waiting for 5 minutes..."
    sleep 300 # Wait for 5 minutes
done
