#!/bin/bash

PID=$1
SLEEP_INTERVAL=5
LOG_FILE="process_watch.log"
while true; do
    OUTPUT=$(top -b -n 1 -p "$PID" | grep "^ *$PID")
    if [ -z "$OUTPUT" ]; then
        echo "Process $PID not found at $(date)" >> $LOG_FILE
    else
        echo "$OUTPUT"
    fi
    sleep $SLEEP_INTERVAL
done