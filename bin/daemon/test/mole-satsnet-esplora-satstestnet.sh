#!/bin/bash

set -x
while true; do
    if ! pgrep -f "mole start remote --verbose --source 103.103.245.177:3004" >/dev/null; then
        echo "Starting new process..."
        script_dir=$(dirname "$(readlink -f "$0")")
        shfilename=$(basename -- "$0")
        shfilename="${shfilename%.*}"
        logfilename="$script_dir/log/$shfilename.log"
        current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
        echo "[$current_datetime]: mole start remote --verbose --source 103.103.245.177:3004 --destination 127.0.0.1:3004 --server root@103.103.245.177 --key /root/.ssh/id_ed25519 -R 0 is start running ..." >>"$logfilename"
        mole start remote --verbose --source 103.103.245.177:3004 --destination 127.0.0.1:3004 --server root@103.103.245.177 --key /root/.ssh/id_ed25519 -R 0
    else
        echo "mole start remote --verbose --source 103.103.245.177:3004 --destination 127.0.0.1:3004 --server root@103.103.245.177 --key /root/.ssh/id_ed25519 -R 0 is already running with PID: $(pgrep -f "mole start remote --verbose --source 103.103.245.177:3004")"
    fi
    sleep 10
done
