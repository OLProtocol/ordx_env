#!/bin/bash
# set -x
set -e

chain=""
indexData=""
use_basic=true
use_ord=false
dataDir=""
backupDir=""
ordxHeight=""
maintain=""
latest_height=""

while getopts ":c:m:o:i:d:b:h" opt; do
    case ${opt} in
    c)
        case $OPTARG in
        mainnet | testnet | sigtest | regtest)
            chain="$OPTARG"
            ;;
        *)
            echo "Invalid c option: $OPTARG"
            exit 1
            ;;
        esac
        ;;
    m)
        case $OPTARG in
        backup | recover)
            maintain="$OPTARG"
            ;;
        *)
            echo "Invalid o option: $OPTARG"
            exit 1
            ;;
        esac
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
    i)
        indexData="$OPTARG"
        case $OPTARG in
        basic)
            use_basic=true
            use_ord=false
            ;;
        ord)
            use_basic=false
            use_ord=true
            ;;
        all)
            use_basic=true
            use_ord=true
            ;;
        *)
            echo "Invalid i option: $OPTARG"
            exit 1
            ;;
        esac
        ;;
    d)
        dataDir="$OPTARG"
        ;;
    b)
        backupDir="$OPTARG"
        ;;
    h)
        echo "Usage: b2r.sh [-c <chain>] [-m <maintain>] [-o <ordxHeight>] [-i <indexData>] -d <dataDir> -b <backupDir> [-h]"
        echo "Options:"
        echo "  -c <chain>: Specify the chain. Valid options are 'mainnet' or 'testnet', default testnet"
        echo "  -m <maintain>: Specify the maintain mode. Valid options are 'backup' or 'restore', default backup"
        echo "  -o <ordxHeight>: Specify the max ordx height, default latest, other options: ordx(mainnet:827307; testnet:2570589), ord(mainnet:767430; testnet:2413342), special height"
        echo "  -i <indexData>: Specify the index data to use. Valid options are 'basic', 'ord', or 'all', default ord"
        echo "  -d <dataDir>: Specify the path to the data"
        echo "  -b <backupDir>: Specify the path to the backup"
        echo "  -h: Display this help message"
        exit 0
        ;;
    \?)
        echo "Invalid option: -$OPTARG"
        exit 1
        ;;
    :)
        echo "Option -$OPTARG requires an argument"
        exit 1
        ;;
    esac
done

if [ -z "$chain" ]; then
    echo "Please specify -c {chain} to chain"
    exit 1
fi

if [ -z "$maintain" ]; then
    echo "Please specify -m {maintain} to maintain mode"
    exit 1
fi

if [ -z "$ordxHeight" ]; then
    echo "Please specify -o {ordxHeight} to ordx height"
    exit 1
fi

if [ -z "$indexData" ]; then
    echo "Please specify -i {indexData} to index type"
    exit 1
fi

if [ -z "$dataDir" ]; then
    echo "Please specify -d {dataDir} to data directory"
    exit 1
fi

if [ -z "$backupDir" ]; then
    echo "Please specify -b {backupDir} to backup directory"
    exit 1
fi

start_time=$(date +%s)
echo "$(date -d "@$start_time" "+%Y-%m-%d %H:%M:%S") - prepare $maintain $chain ordx-server db"

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
        latest_height="height-827307"
        ;;
    "testnet")
        latest_height="height-2570589"
        ;;
    esac
    ;;
"latest")
    latest_height="height-latest"
    ;;
*)
    latest_height="$ordxHeight"
    ;;
esac

dataContent=""
summary=""
# basic index data
if [ "$use_basic" = true ]; then
    bi_backup_dir="$backupDir/$chain/$latest_height"
    bi_data_dir="$dataDir/$chain"
    backup_tar="$bi_backup_dir/$chain-ordx-basicindex.tar"

    case $maintain in
    "backup")
        if [ ! -d "$bi_backup_dir" ]; then
            mkdir -p "$bi_backup_dir"
        fi
        if ! tar --checkpoint=1 --checkpoint-action=echo="%T packing... (%u)" -cf "$backup_tar" -C "$dataDir" "$chain/basic" "$chain/ordx"; then
            echo "Error: tar command failed." >&2
            exit 1
        fi
        ;;
    "recover")
        if [ ! -f "$backup_tar" ]; then
            echo "backup ordx tar $backup_tar isn't exist, please check and try again"
            exit 1
        fi
        if [ -d "$bi_data_dir/basic" ]; then
            find "$bi_data_dir/basic" -delete
        fi
        if [ -d "$bi_data_dir/ordx" ]; then
            find "$bi_data_dir/ordx" -delete
        fi
        if [ ! -d "$bi_data_dir" ]; then
            mkdir -p "$bi_data_dir"
        fi
        if ! tar --checkpoint=1 --checkpoint-action=echo="%T unpacking... (%u)" -xf "$backup_tar" -C "$bi_data_dir" --strip-components=1; then
            echo "Error: tar command failed." >&2
            exit 1
        fi
        ;;
    esac

    dataContent+=" basic index(basic,ordx) "
    backup_tar_size=$(du -sh "$backup_tar" | cut -f1)
    data_dir_size=$(du -sh "$bi_data_dir/basic" | cut -f1)
    summary+=" basic index basic data path:$bi_data_dir/basic, size:$data_dir_size"
    data_dir_size=$(du -sh "$bi_data_dir/ordx" | cut -f1)
    summary+=" basic index data path:$bi_data_dir/ordx, size:$data_dir_size"
    summary+=" basic index backup tar path:$backup_tar, size:$backup_tar_size "
fi

# ord index data
if [ "$use_ord" = true ]; then
    oi_backup_dir="$backupDir/ord-latest"
    oi_data_dir="$dataDir/$chain"
    backup_tar="$oi_backup_dir/$chain-ordx-ordindex.tar"
    ord_data_dir="$oi_data_dir/ord"
    case $maintain in
    "backup")
        if [ ! -d "$oi_backup_dir" ]; then
            mkdir -p "$oi_backup_dir"
        fi
        if ! tar --checkpoint=1 --checkpoint-action=echo="%T packing... (%u)" -cf "$backup_tar" -C "$oi_data_dir" "ord"; then
            echo "Error: tar command failed." >&2
            exit 1
        fi
        ;;
    "recover")
        if [ ! -f "$backup_tar" ]; then
            echo "backup ord tar $backup_tar isn't exist, please check and try again"
            exit 1
        fi
        if [ -d "$ord_data_dir" ]; then
            find "$ord_data_dir" -delete
        fi
        if [ ! -d "$ord_data_dir" ]; then
            mkdir -p "$ord_data_dir"
        fi
        if ! tar --checkpoint=1 --checkpoint-action=echo="%T unpacking... (%u)" -xf "$backup_tar" -C "$ord_data_dir" --strip-components=1; then
            echo "Error: tar command failed." >&2
            exit 1
        fi
        ;;
    esac

    dataContent+=" ord index(ord) "
    data_dir_size=$(du -sh "$ord_data_dir" | cut -f1)
    backup_tar_size=$(du -sh "$backup_tar" | cut -f1)
    summary+=" ord index data path:$ord_data_dir, size:$data_dir_size"
    summary+=" ord index backup tar path:$backup_tar, size:$backup_tar_size "
fi

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
formatted_time=$(echo "$elapsed_time" | awk '{
    days = int($1 / 86400);
    hours = int($1 % 86400 / 3600);
    minutes = int($1 % 3600 / 60);
    seconds = $1 % 60;
    printf "%dd%dh%dm%ds", days, hours, minutes, seconds;
}')

script_dir=$(dirname "$(realpath "$0")")
log_file="$script_dir/operation.log"
echo "$(date -d "@$end_time" "+%Y-%m-%d %H:%M:%S")-> $maintain $chain ordx-server$dataContent db is succ,\
 start time:$(date -d "@$start_time" "+%Y-%m-%d %H:%M:%S"), elapsed time:$formatted_time,$summary" |
    tee -a "$log_file"
