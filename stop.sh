#!/bin/bash

echo "stop all"

pid=$(ps aux | grep mint.sh | awk 'NR==2 {print $2}')
if [[ $pid =~ ^[0-9]+$ ]]; then
    kill -9 $pid
fi
pkill dev-server
pkill electrs
pkill bitcoind
