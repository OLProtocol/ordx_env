#!/bin/bash

set -x
#set -e

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
        ;;
    :)
        echo "Option -$OPTARG requires an argument."
        ;;
    esac
done

if [ -z "$chain" ]; then
    echo "chain not found, exit"
fi

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
bitcoind -rpcthreads=128 -rpcworkqueue=512 -chain="$chain" -conf="$confdir" -datadir="$datadir"
