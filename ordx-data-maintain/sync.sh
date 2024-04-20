#!/bin/bash
# set -x
set -e

chain="testnet"
use_basic=true
ordxHeight="lastest"
use_ord=false
localBackupDir=""
remoteBackupDir=""
prdUrl=""
prdPort="22"
testUrl=""
testPort="22"

while getopts "c:o:i:l:r::p:a:t:b:h" opt; do
    case ${opt} in
        c )
            case $OPTARG in
                mainnet)
                    chain="mainnet"
                    ;;
                testnet)
                    chain="testnet"
                    ;;
                *)
                    echo "Invalid chain option: $OPTARG, use default testnet"
                    chain="testnet"
                    ;;
            esac
            ;;
        o )
            case $OPTARG in
                ord)
                    ordxHeight="ord"
                    ;;
                ordx)
                    ordxHeight="ordx"
                    ;;
                lastest)
                    ordxHeight="lastest"
                    ;;
                *)
                    echo "Invalid ordxHeight option: $OPTARG, use default empty"
                    ordxHeight="lastest"
                    ;;
            esac
            ;;
        i )
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
                    echo "Invalid index option: $OPTARG, use default ord"
                    use_basic=true
                    use_ord=false
                    ;;
            esac
            ;;
        l )
            localBackupDir="$OPTARG"
            ;;
        r )
            remoteBackupDir="$OPTARG"
            ;;
        p )
            prdUrl="$OPTARG"
            ;;
        a )
            prdPort="$OPTARG"
            ;;
        t )
            testUrl="$OPTARG"
            ;;
        b )
            testPort="$OPTARG"
            ;;
        h )
            echo "Usage: run-ordxdata.sh [-c <chain>] [-o <ordxHeight>] [-i <indexData>] -l <localBackupDir> -r <remoteBackupDir> -p <prdUrl> [-a <prdPort>] -t <testUrl> [-b <testPort>] [-h]"
            echo "Options:"
            echo "  -c <chain>: Specify the chain. valid options are 'mainnet' or 'testnet', default testnet"
            echo "  -o <ordxHeight>: Specify the max ordx height, default lastest, other options: ordx(mainnet:827306; testnet:2570588, ord(mainnet:767429; testnet:2413342"
            echo "  -i <indexData>: Specify the index data to use. valid options are 'basic', 'ord', or 'all', default ord"
            echo "  -l <localBackupDir>: Specify the local backup path"
            echo "  -r <remoteBackupDir>: Specify the remote backup path"
            echo "  -p <prdUrl>: Specify production server url(ex: root@192.168.1.101)"
            echo "  -a <prdPort>: Specify production server port, default 22"
            echo "  -t <testUrl>: Specify test server url(root@192.168.1.102)"
            echo "  -b <testPort>: Specify test server port, default 22"
            echo "  -h: Display this help message"
            exit 0
            ;;
        \? )
            echo "Invalid option: -$OPTARG"
            exit 0
            ;;
        : )
            echo "Option -$OPTARG requires an argument"
            exit 0
            ;;
    esac
done

if [ -z "$localBackupDir" ]; then
    echo "Please specify -l {localBackupDir} to local backup path and try and again"
    exit 0
fi

if [ -z "$remoteBackupDir" ]; then
    echo "Please specify -r {remoteBackupDir} to remote backup path and try and again"
    exit 0
fi

if [ -z "$prdUrl" ] && [ -z "$testUrl" ]; then
    echo "Please specify one of -p {prdUrl}/-t {testUrl} specify to the production/test server url(ex: root@192.168.1.101)"
    exit 0
fi

lastest_height=""
case $ordxHeight in
    "ord")
        case $chain in
            "mainnet")
                lastest_height="height-767430"
                ;;
            "testnet")
                lastest_height="height-2413343"
                ;;
        esac
        ;;
    "ordx")
        case $chain in
            "mainnet")
                lastest_height="height-827306"
                ;;
            "testnet")
                lastest_height="height-2570588"
                ;;
        esac
        ;;
    "lastest")
        lastest_height="height-lastest"
        ;;
esac

start_time=$(date +%s)
local_basic_index_data_backup_tar_path="$localBackupDir/$chain/$lastest_height/$chain-ordx-basicindex.tar"
remote_basic_index_data_backup_path="$remoteBackupDir/$chain/$lastest_height"
remote_basic_index_data_tar_path="$remote_basic_index_data_backup_path/$chain-ordx-basicindex.tar"
local_ord_index_data_tar_path="$localBackupDir/ord-lastest/$chain-ordx-ordindex.tar"
remote_ord_index_data_backup_path="$remoteBackupDir/ord-lastest"
remote_ord_index_data_tar_path="$remote_ord_index_data_backup_path/$chain-ordx-ordindex.tar"
summary+=" local basic index data: $local_basic_index_data_backup_tar_path "
summary+=" local ord index data: $local_basic_index_data_backup_tar_path "
if [ ! -z "$prdUrl" ]; then
   summary+=" prd rsync: "
   # basic index data
   if [ "$use_basic" = true ]; then
      ssh -p "$prdPort" "$prdUrl" "mkdir -p $remote_basic_index_data_backup_path"
      if [ $? -ne 0 ]; then
         echo "Error: ssh mkdir -p command failed." >&2
         exit 1
      fi  
      summary+=" remote basic index data: $prdUrl:$prdPort:$remote_basic_index_data_tar_path "
      rsync -avv --update --progress -e "ssh -p $prdPort" "$local_basic_index_data_backup_tar_path" \
      "$prdUrl:$remote_basic_index_data_tar_path"
   fi
   if [ $? -ne 0 ]; then
      echo "Error: rsync command failed." >&2
      exit 1
   fi
   # ord index data
   if [ "$use_ord" = true ]; then
      ssh -p "$prdPort" "$prdUrl" "mkdir -p $remote_ord_index_data_backup_path"
      if [ $? -ne 0 ]; then
         echo "Error: ssh mkdir -p command failed." >&2
         exit 1
      fi  
      summary+=" remote ord index data: $prdUrl:$prdPort:$remote_ord_index_data_tar_path "
      rsync -avv --update --progress -e "ssh -p $prdPort" "$local_ord_index_data_tar_path" \
      "$prdUrl:$remote_ord_index_data_tar_path"
   fi 
   if [ $? -ne 0 ]; then
      echo "Error: rsync command failed." >&2
      exit 1
   fi
   
fi

if [ ! -z "$testUrl" ]; then
   summary+=" test rsync:"
   # basic index data
   if [ "$use_basic" = true ]; then
      ssh -p "$testPort" "$testUrl" "mkdir -p $remote_basic_index_data_backup_path"
      if [ $? -ne 0 ]; then
         echo "Error: ssh mkdir -p command failed." >&2
         exit 1
      fi  
      summary+=" remote basic index data: $testUrl:$testPort:$remote_basic_index_data_tar_path "
      rsync -avv --update --progress -e "ssh -p $testPort" "$local_basic_index_data_backup_tar_path" \
      "$testUrl:$remote_basic_index_data_tar_path"
   fi
   if [ $? -ne 0 ]; then
      echo "Error: rsync command failed." >&2
      exit 1
   fi
   # ord index data
   if [ "$use_ord" = true ]; then
      summary+=" remote ord index data: $testUrl:$testPort:$remote_ord_index_data_tar_path "
      ssh -p "$testPort" "$testUrl" "mkdir -p $remote_ord_index_data_backup_path"
      if [ $? -ne 0 ]; then
         echo "Error: rsync command failed." >&2
         exit 1
      fi
      rsync -avv --update --progress -e "ssh -p $testPort" "$local_ord_index_data_tar_path" \
      "$testUrl:$remote_ord_index_data_tar_path"
   fi
   if [ $? -ne 0 ]; then
      echo "Error: rsync command failed." >&2
      exit 1
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
echo "$(date -d "@$end_time" "+%Y-%m-%d %H:%M:%S")-> $chain ordx-server rsync is succ,\
 start time:$(date -d "@$start_time" "+%Y-%m-%d %H:%M:%S"), elapsed time:$formatted_time,$summary" \
 | tee -a "$log_file"