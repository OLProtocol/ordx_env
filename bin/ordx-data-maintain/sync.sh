#!/bin/bash
# set -x
set -e

chain=""
indexData=""
use_basic=true
ordxHeight=""
use_ord=false
localBackupDir=""
remoteBackupDir=""
prdUrl=""
prdPort="22"
testUrl=""
testPort="22"

while getopts ":c:o:i:l:r::p:a:t:b:h" opt; do
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
    o)
        case $OPTARG in
        ord | ordx | latest)
            ordxHeight="$OPTARG"
            ;;
        *)
            echo "Invalid o option: $OPTARG"
            exit 1
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
    l)
        localBackupDir="$OPTARG"
        ;;
    r)
        remoteBackupDir="$OPTARG"
        ;;
    p)
        prdUrl="$OPTARG"
        ;;
    a)
        prdPort="$OPTARG"
        ;;
    t)
        testUrl="$OPTARG"
        ;;
    b)
        testPort="$OPTARG"
        ;;
    h)
        echo "Usage: sync.sh -c <chain> -o <ordxHeight> -i <indexData> -l <localBackupDir> -r <remoteBackupDir> -p <prdUrl> [-a <prdPort>] -t <testUrl> [-b <testPort>] [-h]"
        echo "Options:"
        echo "  -c <chain>: Specify the chain. valid options are 'mainnet' or 'testnet', default testnet"
        echo "  -o <ordxHeight>: Specify the max ordx height, default latest, other options: ordx(mainnet:827307; testnet:2570589, ord(mainnet:767430; testnet:2413342"
        echo "  -i <indexData>: Specify the index data to use. valid options are 'basic', 'ord', or 'all', default ord"
        echo "  -l <localBackupDir>: Specify the local backup path"
        echo "  -r <remoteBackupDir>: Specify the remote backup path"
        echo "  -p <prdUrl>: Specify production server url(ex: root@192.168.10.101)"
        echo "  -a <prdPort>: Specify production server port, default 22"
        echo "  -t <testUrl>: Specify test server url(root@192.168.10.102)"
        echo "  -b <testPort>: Specify test server port, default 22"
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

if [ -z "$ordxHeight" ]; then
    echo "Please specify -o {ordxHeight} to ordx height"
    exit 1
fi

if [ -z "$indexData" ]; then
    echo "Please specify -i {indexData} to index type"
    exit 1
fi

if [ -z "$localBackupDir" ]; then
    echo "Please specify -l {localBackupDir} to local backup path and try and again"
    exit 1
fi

if [ -z "$remoteBackupDir" ]; then
    echo "Please specify -r {remoteBackupDir} to remote backup path and try and again"
    exit 1
fi

if [ -z "$prdUrl" ] && [ -z "$testUrl" ]; then
    echo "Please specify one of -p {prdUrl}/-t {testUrl} specify to the production/test server url(ex: root@192.168.10.101)"
    exit 1
fi

latest_height=""
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
esac

start_time=$(date +%s)
local_basic_index_data_backup_tar_path="$localBackupDir/$chain/$latest_height/$chain-ordx-basicindex.tar"
remote_basic_index_data_backup_path="$remoteBackupDir/$chain/$latest_height"
remote_basic_index_data_tar_path="$remote_basic_index_data_backup_path/$chain-ordx-basicindex.tar"
local_ord_index_data_tar_path="$localBackupDir/ord-latest/$chain-ordx-ordindex.tar"
remote_ord_index_data_backup_path="$remoteBackupDir/ord-latest"
remote_ord_index_data_tar_path="$remote_ord_index_data_backup_path/$chain-ordx-ordindex.tar"
summary+=" local basic index data: $local_basic_index_data_backup_tar_path "
summary+=" local ord index data: $local_basic_index_data_backup_tar_path "
if [ -n "$prdUrl" ]; then
    summary+=" prd rsync: "
    # basic index data
    if [ "$use_basic" = true ]; then
        if ! ssh -p "$prdPort" "$prdUrl" "mkdir -p $remote_basic_index_data_backup_path"; then
            echo "Error: ssh mkdir -p command failed." >&2
            exit 1
        fi
        summary+=" remote basic index data: $prdUrl:$prdPort:$remote_basic_index_data_tar_path "
        rsync -avv --update --progress -e "ssh -p $prdPort" "$local_basic_index_data_backup_tar_path" \
            "$prdUrl:$remote_basic_index_data_tar_path"

        if ! rsync -avv --update --progress -e "ssh -p $prdPort" "$local_basic_index_data_backup_tar_path" \
            "$prdUrl:$remote_basic_index_data_tar_path"; then
            echo "Error: rsync command failed." >&2
            exit 1
        fi
    fi

    # ord index data
    if [ "$use_ord" = true ]; then
        if ! ssh -p "$prdPort" "$prdUrl" "mkdir -p $remote_ord_index_data_backup_path"; then
            echo "Error: ssh mkdir -p command failed." >&2
            exit 1
        fi
        summary+=" remote ord index data: $prdUrl:$prdPort:$remote_ord_index_data_tar_path "
        if ! rsync -avv --update --progress -e "ssh -p $prdPort" "$local_ord_index_data_tar_path" \
            "$prdUrl:$remote_ord_index_data_tar_path"; then
            echo "Error: rsync command failed." >&2
            exit 1
        fi
    fi
fi

if [ -n "$testUrl" ]; then
    summary+=" test rsync:"
    # basic index data
    if [ "$use_basic" = true ]; then
        if ! ssh -p "$testPort" "$testUrl" "mkdir -p $remote_basic_index_data_backup_path"; then
            echo "Error: ssh mkdir -p command failed." >&2
            exit 1
        fi
        summary+=" remote basic index data: $testUrl:$testPort:$remote_basic_index_data_tar_path "
        if ! rsync -avv --update --progress -e "ssh -p $testPort" "$local_basic_index_data_backup_tar_path" \
            "$testUrl:$remote_basic_index_data_tar_path"; then
            echo "Error: rsync command failed." >&2
            exit 1
        fi
    fi
    # ord index data
    if [ "$use_ord" = true ]; then
        summary+=" remote ord index data: $testUrl:$testPort:$remote_ord_index_data_tar_path "
        if ! ssh -p "$testPort" "$testUrl" "mkdir -p $remote_ord_index_data_backup_path"; then
            echo "Error: rsync command failed." >&2
            exit 1
        fi
        if ! rsync -avv --update --progress -e "ssh -p $testPort" "$local_ord_index_data_tar_path" \
            "$testUrl:$remote_ord_index_data_tar_path"; then
            echo "Error: rsync command failed." >&2
            exit 1
        fi
    fi
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
echo "$(date -d "@$end_time" "+%Y-%m-%d %H:%M:%S")-> $chain ordx-server rsync is succ, \
start time:$(date -d "@$start_time" "+%Y-%m-%d %H:%M:%S"), elapsed time:$formatted_time,$summary" |
    tee -a "$log_file"
