#!/bin/bash

set -x
#set -e

datadir=""
brpcurl=""
chain=""
first_inscription_height=""
rpcuser=""
rpcpassword=""
rpcport=""

while getopts "n:b:d:u:w:p:h" opt; do
    case ${opt} in
    n)
        case $OPTARG in
        main)
            chain="mainnet"
            ;;
        test)
            chain="testnet"
            ;;
        regtest)
            chain="regtest"
            ;;
        *)
            echo "Invalid chain option: $OPTARG"
            ;;
        esac
        ;;
    b)
        brpcurl="$OPTARG"
        ;;
    d)
        datadir="$OPTARG"
        ;;
    u)
        rpcuser="$OPTARG"
        ;;
    w)
        rpcpassword="$OPTARG"
        ;;
    p)
        rpcport="$OPTARG"
        ;;
    h)
        echo "Usage: ord.sh -n <network> -b <brpcurl> -d <datadir> [-h]"
        echo "Options:"
        echo "  -n <chain>: Specify the chain. Valid options are 'mainnet' or 'testnet' or 'regtest'"
        echo "  -b <brpcurl>: Specify the bitcoin rpc url, ex: http://127.0.0.1:8332 or http://127.0.0.1:18332"
        echo "  -d <datadir>: Specify the path to the data directory, ex: /data/ord-data/0.16.0"
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

if [ -z "$brpcurl" ]; then
    echo "Please specify -b option for rpc url, ex: http://127.0.0.1:8332 or http://127.0.0.1:18332"
fi

if [ -z "$rpcuser" ]; then
    echo "Please specify -u option for rpc username, ex: jacky"
fi

if [ -z "$rpcpassword" ]; then
    echo "Please specify -w option for rpc password, ex: _RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0"
fi

if [ -z "$rpcport" ]; then
    echo "Please specify -p option for rpc port, ex: 80"
fi

if [ -z "$datadir" ]; then
    echo "Please specify -d option for data path, ex: /data/ord-data/0.16.0"
    exit 1
fi

[ "${datadir: -1}" != "/" ] && datadir+="/"

case $chain in
mainnet)
    datadir+="main"
    first_inscription_height=767430
    ;;
testnet)
    first_inscription_height=2413343
    ;;
regtest)
    first_inscription_height=112402
    ;;
esac

if [ ! -d "$datadir" ]; then
    mkdir -p "$datadir"
fi

ord0.16.0 --chain "$chain" --bitcoin-rpc-url "$brpcurl" --data-dir "$datadir" \
    --bitcoin-rpc-username "$rpcuser" --bitcoin-rpc-password "$rpcpassword" \
    --first-inscription-height "$first_inscription_height" --index-sats --minify server --http --http-port "$rpcport"
