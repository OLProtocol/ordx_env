#!/bin/bash
# set -x
set -e

programName="ordx-server"
srcCodePath=""
needPull=false

while getopts ":s:ph" opt; do
    case ${opt} in
    s)
        srcCodePath="$OPTARG"
        ;;
    p)
        needPull=true
        ;;
    h)
        echo "Usage: build.sh -s <source_code_path> [-p] [-h]"
        echo "Options:"
        echo "  -s <source_code_path>: Specify the source code path"
        echo "  -p: Pull updates from remote repository, default false"
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

if [ -z "$srcCodePath" ]; then
    echo "Please specify -s option for source code path, example -s /data1/github/ordx-rundata"
    exit 1
fi
if [ ! -d "$srcCodePath" ]; then
    echo "Please speciafy -s option for source code path, $srcCodePath does not exist, please check the path and try again"
    exit 1
fi

originalDir=$(pwd)
cd "$srcCodePath"
if [ "$needPull" = true ]; then
    if ! git reset --hard origin/main; then
        echo "Error resetting to origin/main. Return code: $?"
        exit 1
    fi

    if ! git pull; then
        echo "Error pulling from remote. Return code: $?"
        exit 1
    fi
fi

if ! go build -o "/usr/local/bin/$programName"; then
    echo "Error building the program. Return code: $?"
    exit 1
fi
cd "$originalDir"

script_dir=$(dirname "$(realpath "$0")")
echo "$script_dir"
log_file="$script_dir/operation.log"
end_time=$(date +%s)
echo "$(date -d "@$end_time" "+%Y-%m-%d %H:%M:%S")-> build ordx succ, bin output: /usr/local/bin/$programName" |
    tee -a "$log_file"
