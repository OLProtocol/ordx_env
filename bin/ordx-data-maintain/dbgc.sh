#!/bin/bash
# set -x
set -e

programName="ordx-server"
dbPath=""

while getopts ":d:h" opt; do
    case ${opt} in
    d)
        dbPath="$OPTARG"
        ;;
    h)
        echo "Usage: dgbc.sh -d <dbPath> [-h]"
        echo "Options:"
        echo "  -d <dbPath>: Specify the db path, ex: /data/ordx-data/testnet/basic"
        echo "  -h: Display this help message"
        exit 0
        ;;
    \?)
        echo "Invalid option: -$OPTARG"
        exit 1
        ;;
    :)
        echo "Option -$OPTARG requires an argument."
        exit 1
        ;;
    esac
done

if [ -z "$dbPath" ]; then
    echo "Please specify -d option for the db path, example -d /data/ordx-data/testnet/basic"
    exit 1
fi

if [ ! -d "$dbPath" ]; then
    echo "Please specify -d option for the db path, $dbPath does not exist, please check and try again"
    exit 1
fi

command_str="${programName} -dbgc ${dbPath}"
if pgrep -f "$command_str" >/dev/null; then
    echo "please stop $command_str and run again."
    exit 1
fi

start_time=$(date +%s)
script_dir=$(dirname "$(realpath "$0")")
log_file="$script_dir/operation.log"
timeFormat="+%Y-%m-%d %H:%M:%S"

format_time() {
    local elapsed=$1
    local days hours minutes seconds
    days=$((elapsed / 86400))
    hours=$((elapsed % 86400 / 3600))
    minutes=$((elapsed % 3600 / 60))
    seconds=$((elapsed % 60))
    printf "%dd%dh%dm%ds" "$days" "$hours" "$minutes" "$seconds"
}

old_db_size=$(du -sh "$dbPath" | cut -f1)

if eval "$command_str"; then
    end_time=$(date +%s)
    elapsed_time=$((end_time - start_time))
    formatted_time=$(format_time "$elapsed_time")
    echo "$(date -d "@$end_time" "$timeFormat") -> run $programName -dbgc is succ, start time:$(date -d "@$start_time" "$timeFormat"), \
elapsed time:$formatted_time, db path: $dbPath, old db size: $old_db_size, new db size: $(du -sh "$dbPath" | cut -f1)" | tee -a "$log_file"
else
    end_time=$(date +%s)
    elapsed_time=$((end_time - start_time))
    formatted_time=$(format_time "$elapsed_time")
    echo "$(date -d "@$end_time" "$timeFormat") -> run ordx data is fail, start time:$(date -d "@$start_time" "$timeFormat"), \
elapsed time:$formatted_time, db path: $dbPath, old db size: $old_db_size" | tee -a "$log_file"
    exit 1
fi
