#!/bin/bash
# set -x
set -e

programName="ordx-server"
ordxConfPath=""
ordxHeight="latest"
disable_basic=false
disable_ord=true
dataDir=""
backupDir=""

while getopts "c:d:b:o:h" opt; do
    case ${opt} in
        c )
            ordxConfPath=$(eval echo "$OPTARG")
        ;;
        d )
            dataDir="$OPTARG"
        ;;
        b )
            backupDir="$OPTARG"
        ;;
        o )
            case $OPTARG in
                ord)
                    ordxHeight="ord"
                ;;
                ordx)
                    ordxHeight="ordx"
                ;;
                latest)
                    ordxHeight="latest"
                ;;
                *)
                    echo "Invalid ordxHeight option: $OPTARG, use default latest"
                    ordxHeight="latest"
                ;;
            esac
        ;;
        h )
            echo "Usage: run-ordxdata.sh -c <ordxConfPath> [-d <indeData>] [-o <ordxHeight>] [-h]"
            echo "Options:"
            echo "  -c <ordxConfPath>: Specify the ordx confuration path"
            echo "  -d <dataDir>: Specify the path to the data"
            echo "  -b <backupDir>: Specify the path to the backup"
            echo "  -o <ordxHeight>: Specify the max ordx height, default latest, other options: ordx(mainnet:827306; testnet:2570588, ord(mainnet:767429; testnet:2413342"
            echo "  -h: Display this help message"
            exit 0
        ;;
        \? )
            echo "Invalid option: -$OPTARG"
        ;;
        : )
            echo "Option -$OPTARG requires an argument."
        ;;
    esac
done

if [ -z "$ordxConfPath" ]; then
    echo "Please specify -c option for ordx confuration path, example -c run-ordxdata-testnet.env"
    exit 1
fi

if [ ! -f "$ordxConfPath" ]; then
    echo "ordx confuration path $ordxConfPath does not exist, please check and try again"
    exit 1
fi

latest_height=""
chain=$(grep -w BITCOIN_CHAIN "$ordxConfPath" | awk -F= '{print $2}')
case $ordxHeight in
    "ord")
        case $chain in
            "mainnet")
                latest_height="height-767430"
            ;;
            "testnet")
                latest_height="height-2413343"
            ;;
        esac
    ;;
    "ordx")
        case $chain in
            "mainnet")
                latest_height="height-827306"
            ;;
            "testnet")
                latest_height="height-2570588"
            ;;
        esac
    ;;
    "latest")
        latest_height="height-latest"
    ;;
esac

ordxParam=""
if [ "$disable_basic" = true ]; then
    ordxParam+=" -dbi "
fi
if [ "$disable_ord" = true ]; then
    ordxParam+=" -doi "
fi

command_str="${programName} -env ${ordxConfPath} ${ordxParam}"
if pgrep -f "$command_str" > /dev/null; then
    echo "please stop $command_str and run again."
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
        "$script_dir/b2r.sh m recover -c $chain -i basic -d $dataDir -b $backupDir -o latest"
    else
        init=false
    fi
    
    eval "$command_str" &
    pid=$!
    wait $pid
    result_code=$?
    
    if $result_code -eq 0; then
        result="succ"
        sleep 10
    else
        result="fail"
    fi
    timeFormat="+%Y-%m-%d %H:%M:%S"
    echo "$(date -d "@$end_time" "$timeFormat") -> run $command_str is $result, start time:$(date -d "@$start_time" "$timeFormat"), elapsed time:$formatted_time, latest_height: $latest_height" \
    | tee -a "$log_file"
done