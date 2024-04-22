#!/bin/bash
# set -x
set -e

programName="ordx-server"
ordxConfPath=""
ordxHeight="latest"
disable_basic=false
disable_ord=true

while getopts "c:o:d:h" opt; do
    case ${opt} in
        c )
            ordxConfPath=$(eval echo "$OPTARG")
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
        d )
            case $OPTARG in
                basic)
                    disable_basic=true
                    disable_ord=false
                ;;
                ord)
                    disable_basic=false
                    disable_ord=true
                ;;
                *)
                    echo "Invalid index option: $OPTARG, use default ord"
                    disable_basic=false
                    disable_ord=true
                ;;
            esac
        ;;
        h )
            echo "Usage: run-ordxdata.sh -c <ordxConfPath> [-d <indeData>] [-o <ordxHeight>] [-h]"
            echo "Options:"
            echo "  -c <ordxConfPath>: Specify the ordx confuration path"
            echo "  -o <ordxHeight>: Specify the max ordx height, default latest, other options: ordx(mainnet:827306; testnet:2570588, ord(mainnet:767429; testnet:2413342"
            echo "  -d <indeData>: Specify the index data to disable run. Valid options are 'basic', 'ord', or 'all', default ord"
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
ordRpc=""
chain=$(grep -w BITCOIN_CHAIN "$ordxConfPath" | awk -F= '{print $2}')
case $ordxHeight in
    "ord")
        case $chain in
            "mainnet")
                latest_height="767430"
                # latest_height="100000"
            ;;
            "testnet")
                latest_height="2413343"
            ;;
            \? )
                echo "The configuration file $ordxConfPath require BITCOIN_CHAIN, please check and try again"
                exit 1
            ;;
        esac
    ;;
    "ordx")
        case $chain in
            "mainnet")
                # latest_height="827306"
            ;;
            "testnet")
                latest_height="2570588"
            ;;
            \? )
                echo "The configuration file $ordxConfPath require BITCOIN_CHAIN, please check and try again"
                exit 1
            ;;
        esac
    ;;
    "latest")
        ordRpc=$(grep -w ORD_RPC_URL "$ordxConfPath" | awk -F= '{print $2}')
        if [ -z "$ordRpc" ]; then
            echo "The configuration file $ordxConfPath require ORD_RPC_URL, please check and try again"
            exit 1
        fi
        latest_height=$(curl -H "Accept: application/json" "$ordRpc/status" 2>/dev/null | jq -r '.height')
        if [ -z "$latest_height" ]; then
            echo "ordinal rpc error: latest_height is empty"
            exit 1
        fi
    ;;
esac

sed -i "s/^#*MAX_INDEX_HEIGHT=.*/MAX_INDEX_HEIGHT=$latest_height/" "$ordxConfPath"

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

timeFormat="+%Y-%m-%d %H:%M:%S"
if eval "$command_str" | tee /dev/tty; then
    echo "$(date -d "@$end_time" "$timeFormat") -> run ordx data is succ, start time:$(date -d "@$start_time" "$timeFormat"), elapsed time:$formatted_time, latest_height: $latest_height" \
    | tee -a "$log_file"
else
    echo "$(date -d "@$end_time" "$timeFormat") -> run ordx data is fail, start time:$(date -d "@$start_time" "$timeFormat"), elapsed time:$formatted_time, latest_height: $latest_height" \
    | tee -a "$log_file"
    exit 1
fi
