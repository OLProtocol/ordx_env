#!/bin/bash
# set -x
set -e

programName="ordx-server"
ordxConfPath=""
ordxHeight=""
disable_basic=false
disable_ord=true
dataDir=""
backupDir=""

while getopts ":c:d:b:o:h" opt; do
    case ${opt} in
    c)
        ordxConfPath="$OPTARG"
        ;;
    d)
        dataDir="$OPTARG"
        ;;
    b)
        backupDir="$OPTARG"
        ;;
    o)
        case $OPTARG in
        ord | ordx | latest)
            ordxHeight="$OPTARG"
            ;;
        *)
            if [[ "$OPTARG" =~ ^[1-9][0-9]*$ ]]; then
                ordxHeight="$OPTARG"
            else
                echo "Invalid -o option: $OPTARG. It must be 'ord', 'ordx', 'latest', or a positive number greater than 0."
                exit 1
            fi
            ;;
        esac
        ;;
    h)
        echo "Usage: guard.sh -c <ordxConfPath> -d <dataDir> -o <ordxHeight> [-h]"
        echo "Options:"
        echo "  -c <ordxConfPath>: Specify the ordx confuration path"
        echo "  -d <dataDir>: Specify the path to the data"
        echo "  -b <backupDir>: Specify the path to the backup"
        echo "  -o <ordxHeight>: Specify the max ordx height, default latest, other options: ordx(mainnet:827307; testnet:2570589), ord(mainnet:767430; testnet:2413342), special height"
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

if [ ! -f "$ordxConfPath" ]; then
    echo "Please specify -c option for ordx conf path, $ordxConfPath does not exist, please check and try again"
    exit 1
fi

if [ -z "$dataDir" ]; then
    echo "Please specify -d option for data directory"
    exit 1
fi

if [ -z "$backupDir" ]; then
    echo "Please specify -b option for backup directory"
    exit 1
fi

if [ -z "$ordxHeight" ]; then
    echo "Please specify -o option for ordx height"
    exit 1
fi

chain=$(grep -w BITCOIN_CHAIN "$ordxConfPath" | awk -F= '{print $2}')

ordxParam=""
if [ "$disable_basic" = true ]; then
    ordxParam+=" -dbi "
fi
if [ "$disable_ord" = true ]; then
    ordxParam+=" -doi "
fi

command_str="${programName} -env ${ordxConfPath} ${ordxParam}"
if pgrep -f "$command_str" >/dev/null; then
    echo "please stop $command_str and run again."
    exit 1
fi

start_time=$(date +%s)
script_dir=$(dirname "$(realpath "$0")")
log_file="$script_dir/operation.log"
end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
formatted_time=$(echo "$elapsed_time" | awk '{
    days = int($1 / 86400);
    hours = int($1 % 86400 / 3600);
    minutes = int($1 % 3600 / 60);
    seconds = $1 % 60;
    printf "%dd%dh%dm%ds", days, hours, minutes, seconds;
}')

result_code=1
init=true
while $result_code -eq 0; do
    if [ $init = false ]; then
        "$script_dir/b2r.sh -m recover -c $chain -i basic -d $dataDir -b $backupDir -o latest"
    else
        init=false
    fi

    eval "$command_str" &
    pid=$!
    wait $pid
    result_code=$?

    if $result_code -eq 0; then
        result="succ"
    else
        result="fail"
    fi
    timeFormat="+%Y-%m-%d %H:%M:%S"
    echo "$(date -d "@$end_time" "$timeFormat") -> run $command_str is $result, start time:$(date -d "@$start_time" "$timeFormat"), elapsed time:$formatted_time" |
        tee -a "$log_file"
done
