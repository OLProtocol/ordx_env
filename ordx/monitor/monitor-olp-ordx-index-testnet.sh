#!/bin/bash

set -x
while true; do
    if ! pgrep -f "python3 /btcdata/test/olp/olpindex/modules/ord2_index/ord2_index.py" >/dev/null; then
        echo "Starting new process..."
        script_dir=$(dirname "$(readlink -f "$0")")
        shfilename=$(basename -- "$0")
        shfilename="${shfilename%.*}"
        logfilename="$script_dir/log/$shfilename.log"
        current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
        echo "[$current_datetime]: python3 /btcdata/test/olp/olpindex/modules/ord2_index/ord2_index.py is start running ..." >> "$logfilename"
        python3 /btcdata/test/olp/olpindex/modules/ord2_index/ord2_index.py
    else
        echo "python3 /btcdata/test/olp/olpindex/modules/ord2_index/ord2_index.py is already running with PID: $(pgrep -f "python3 /btcdata/test/olp/olpindex/modules/ord2_index/ord2_index.py")"
    fi
    sleep 1
done
