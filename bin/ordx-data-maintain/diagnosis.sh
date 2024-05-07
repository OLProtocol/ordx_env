#!/bin/bash
# set -x
set -e

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

runScript="run.sh"
ordxConfPath=""
dataDir=""
backupDir=""
ordxHeight=""
startHeight=0
while getopts ":c:d:s:o:b:h" opt; do
    case ${opt} in
    c)
        ordxConfPath="$OPTARG"
        ;;
    d)
        dataDir="$OPTARG"
        ;;
    s)
        if [[ "$OPTARG" =~ ^[1-9][0-9]*$ ]]; then
            startHeight="$OPTARG"
        else
            echo "Invalid -s option: $OPTARG. It must be a positive number greater than 0."
        fi
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
    b)
        backupDir="$OPTARG"
        ;;
    h)
        echo "Usage: diagnosis.sh -c <ordxConfPath> -d <dataDir> -s <startHeight> -o <ordxHeight> [-h]"
        echo "Description: Locate to the nearest block height that passes the base index checking."
        echo "Options:"
        echo "  -c <ordxConfPath>: Specify the ordx confuration path"
        echo "  -d <dataDir>: Specify the path to the ordx data directory"
        echo "  -s <startHeight> : Specify the start height"
        echo "  -o <ordxHeight>: Specify the max ordx height, default latest, other options: ordx(mainnet:827307; testnet:2570589), ord(mainnet:767430; testnet:2413342), special height"
        echo "  -b <backupDir>: Specify the path to the backup directory for restore when happened error"
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

if [ -z "$ordxConfPath" ]; then
    echo "Please specify -c option for ordx confuration path, example -c run-ordxdata-testnet.env"
    exit 1
fi

if [ ! -f "$ordxConfPath" ]; then
    echo "Please specify -c option for ordx confuration path, $ordxConfPath does not exist, please check and try again"
    exit 1
fi

if [ -z "$dataDir" ]; then
    echo "Please specify -d {dataDir} to data directory"
    exit 1
fi

if [ ! -d "$dataDir" ]; then
    echo "Please specify -d {dataDir} to data directory, $dataDir does not exist, please check and try again"
    exit 1
fi

if [ -z "$ordxHeight" ]; then
    echo "Please specify -o option for ordx height"
    exit 1
fi

if [ -z "$startHeight" ]; then
    echo "Please specify -s option for start height"
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
        ;;
    "testnet")
        latest_height="2413343"
        ;;
    *)
        echo "The configuration file $ordxConfPath require BITCOIN_CHAIN, please check and try again"
        exit 1
        ;;
    esac
    ;;
"ordx")
    case $chain in
    "mainnet")
        latest_height="827307"
        ;;
    "testnet")
        latest_height="2570589"
        ;;
    *)
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
*)
    latest_height="$ordxHeight"
    ;;
esac

if ((startHeight < latest_height)); then
    echo "The start height $startHeight is less than the latest height $latest_height"
    exit 1
fi

while ((startHeight < latest_height)); do
    command_str="$script_dir/${runScript} -c ${ordxConfPath} -d ord -o ${latest_height}"
    if pgrep -f "$command_str" >/dev/null; then
        echo "Please stop $command_str and run again."
        exit 1
    fi
    if ! eval "$command_str"; then
        command_status=$?
        end_time=$(date +%s)
        elapsed_time=$((end_time - start_time))
        formatted_time=$(format_time "$elapsed_time")

        if [ "$command_status" -eq 2 ]; then
            if [ -d "$backupDir" ]; then
                "$script_dir/b2r.sh -m recover -c $chain -i basic -d $dataDir -b $backupDir -o $latest_height"
            fi

            bi_data_dir="$dataDir/$chain"
            if [ -d "$bi_data_dir/basic" ]; then
                find "$bi_data_dir/basic" -delete
            fi
            if [ -d "$bi_data_dir/ordx" ]; then
                find "$bi_data_dir/ordx" -delete
            fi
            latest_height=$((startHeight + (latest_height - startHeight) / 2))
            echo "$(date -d "@$end_time" "$timeFormat") -> run ordx data failed with status 2, retrying with height $latest_height, elapsed time:$formatted_time, latest_height: $latest_height" |
                tee -a "$log_file"
        else
            echo "$(date -d "@$end_time" "$timeFormat") -> run ordx data failed with status $command_status, start time:$(date -d "@$start_time" "$timeFormat"), elapsed time:$formatted_time, latest_height: $latest_height" |
                tee -a "$log_file"
            exit 1
        fi
    else
        end_time=$(date +%s)
        elapsed_time=$((end_time - start_time))
        formatted_time=$(format_time "$elapsed_time")
        echo "$(date -d "@$end_time" "$timeFormat") -> run ordx data succeeded, start time:$(date -d "@$start_time" "$timeFormat"), elapsed time:$formatted_time, latest_height: $latest_height" |
            tee -a "$log_file"
        break
    fi
done

if ((startHeight >= latest_height)); then
    echo "startHeight ($startHeight) is greater than or equal to latest_height ($latest_height), no more retries." | tee -a "$log_file"
    exit 1
fi
