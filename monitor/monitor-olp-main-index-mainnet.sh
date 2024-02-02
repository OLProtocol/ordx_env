#!/bin/bash

set -x
while true; do
    if ! pgrep -f "node /btcdata/mainnet/olpindex/modules/main_index/index.js" >/dev/null; then
        echo "Starting new process..."
        script_dir=$(dirname "$(readlink -f "$0")")
        shfilename=$(basename -- "$0")
        shfilename="${shfilename%.*}"
        logfilename="$script_dir/log/$shfilename.log"
        current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
        echo "[$current_datetime]: node /btcdata/mainnet/olpindex/modules/main_index/index.js is start running ..." >> "$logfilename"
        node /btcdata/mainnet/olpindex/modules/main_index/index.js
    else
        echo "node /btcdata/mainnet/olpindex/modules/main_index/index.js is already running with PID: $(pgrep -f "node /btcdata/mainnet/olpindex/modules/main_index/index.js")"
    fi
    sleep 1
done
