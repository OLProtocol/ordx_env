#!/bin/bash

echo "stop all"
script_path=$(cd "$(dirname "$0")" && pwd)
pids=$(ps aux | grep "$script_path"/bitcoin/regtest/mint.sh | awk '{print $2}')
echo "mint pids: $pids"

for pid in $pids; do
    kill $pid 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "Failed to kill mint.sh process with PID $pid"
    fi
done

sudo pkill dev-server
sudo pkill electrs
sudo pkill bitcoind
