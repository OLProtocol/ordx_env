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
            exit 1
            ;;
        esac
        ;;
    b)
        brpcurl="$OPTARG"
        if [ -z "$brpcurl" ]; then
            echo "Please specify -b option for rpc url, ex: http://127.0.0.1:8332 or http://127.0.0.1:18332"
            exit 1
        fi
        ;;
    d)
        datadir="$OPTARG"
        if [ -z "$datadir" ]; then
            echo "Please specify -d option for data path, ex: /data/ord-data/0.16.0"
            exit 1
        fi
        ;;
    u)
        rpcuser="$OPTARG"
        if [ -z "$rpcuser" ]; then
            echo "Please specify -u option for rpc username, ex: jacky"
            exit 1
        fi
        ;;
    w)
        rpcpassword="$OPTARG"
        if [ -z "$rpcpassword" ]; then
            echo "Please specify -w option for rpc password, ex: _RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0"
            exit 1
        fi
        ;;
    p)
        rpcport="$OPTARG"
        if [ -z "$rpcport" ]; then
            echo "Please specify -p option for rpc port, ex: 80"
            exit 1
        fi
        ;;
    h)
        echo "Usage: ord.sh -n <network> -b <brpcurl> -d <datadir> [-h]"
        echo "Options:"
        echo "  -n <chain>: Specify the chain. Valid options are 'mainnet' or 'testnet' or 'regtest'"
        echo "  -b <brpcurl>: Specify the bitcoin rpc url, ex: http://127.0.0.1:8332 or http://127.0.0.1:18332"
        echo "  -d <datadir>: Specify the path to the data directory, ex: /data/ord-data/0.16.0"
        echo "  -u <rpcuser>: Specify the rpc username, ex: jacky"
        echo "  -w <rpcpassword>: Specify the rpc password, ex: _RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0"
        echo "  -p <rpcport>: Specify the rpc port, ex: 80"
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
