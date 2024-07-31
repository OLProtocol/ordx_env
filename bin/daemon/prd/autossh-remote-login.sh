#!/bin/bash

set -x
while true; do
    if ! pgrep -f "autossh -M 20010" >/dev/null; then
        echo "Starting new process..."
        script_dir=$(dirname "$(readlink -f "$0")")
        shfilename=$(basename -- "$0")
        shfilename="${shfilename%.*}"
        logfilename="$script_dir/log/$shfilename.log"
        current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
        echo "[$current_datetime]: autossh is start running ..." >>"$logfilename"
        # autossh -M 20010 -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" \
        #     -o 'Ciphers aes128-ctr' -o 'KexAlgorithms diffie-hellman-group14-sha1' \
        #     -CN -R 8020:192.168.10.101:22 root@103.103.245.177
        autossh -M 20010 -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" \
            -CN -R 8020:192.168.10.101:22 root@103.103.245.177
    else
        echo "autossh is already running with PID: $(pgrep -f "autossh -M 20010")"
    fi
    sleep 10
done
