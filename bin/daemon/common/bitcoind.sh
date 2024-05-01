#!/bin/bash

# set -x
set -e

chain=""
confdir=""
datadir=""

while getopts "n:c:d:h" opt; do
    case ${opt} in
    n)
        case $OPTARG in
        mainnet)
            chain="main"
            ;;
        testnet)
            chain="test"
            ;;
        signet)
            chain="signet"
            ;;
        regtest)
            chain="regtest"
            ;;
        *)
            echo "Invalid chain option: $OPTARG"
            exit 1
            ;;
        esac
        ;;
    c)
        confdir="$OPTARG"
        ;;
    d)
        datadir="$OPTARG"
        ;;
    h)
        echo "Usage: bitcoind.sh -n <network> -c <confdir> -d <datadir> [-h]"
        echo "Options:"
        echo "  -n <chain>: Specify the chain. Valid options are 'main' or 'test' or 'regtest'"
        echo "  -c <confdir>: Specify the path to the bitcoin.conf"
        echo "  -d <datadir>: Specify the path to the data directory"
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

if [ ! -f "$confdir" ]; then
    echo "bitcoin.conf not found, exit"
fi

if [ -z "$datadir" ]; then
    echo "Please specify -d option for data path, example -d /data/bitcoin-data"
    exit 1
fi

if [ ! -d "$datadir" ]; then
    mkdir -p "$datadir"
fi

command_str="bitcoind -rpcthreads=128 -rpcworkqueue=512 -chain=$chain -conf=$confdir -datadir=$datadir"

if pgrep -f "$command_str" >/dev/null; then
    echo "please stop $command_str and run again."
    exit 1
fi

$command_str
