#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please provide a parameter: node1 or node2"
    exit 1
fi

if pgrep bitcoind >/dev/null; then
    echo "Terminating existing bitcoind processes..."
    pkill bitcoind
fi

# node1
script_path=$(cd "$(dirname "$0")" && pwd)
node1Path="$script_path/node1"
node1DataPath="$node1Path/data"
node1CookiePath="$node1DataPath/regtest/.cookie"
if [ "$1" == "node1" ] || [ "$2" == "node1" ]; then
    if [ ! -d "$node1DataPath" ]; then
        mkdir -p "$node1DataPath"
    fi
    bitcoind -conf="$node1Path/bitcoin.conf" -rpccookiefile="$node1CookiePath" -datadir="$node1DataPath"
    sleep 1
    echo "create node1 wallet test"
    param="-chain=regtest -rpccookiefile=$node1CookiePath -datadir=$node1Path"
    bitcoin-cli $param createwallet test 2> /dev/null
    if [ $? -ne 0 ]; then
        echo "node1 wallet exists, load wallet"
        bitcoin-cli $param loadwallet test
    else
        echo "create node1 wallet success"
        newaddress=$(bitcoin-cli -rpcwallet=test -rpccookiefile="$node1CookiePath" -datadir="$node1Path" getnewaddress)
        echo "get node1 wallet new address:$newaddress, generate 101 blocks for first mint"
        bitcoin-cli -rpcwallet=test -rpccookiefile="$node1CookiePath" -datadir="$node1Path" generatetoaddress 101 "$newaddress"
    fi
    echo "node1 wallet info:"
    bitcoin-cli $param getwalletinfo
    echo "node1 wallet balance:"
    bitcoin-cli $param getbalance
fi

# node2
node2Path="$script_path/node2"
node2DataPath="$node2Path/data"
if [ "$1" == "node2" ] || [ "$2" == "node2" ]; then
    if [ ! -d "$node2DataPath" ]; then
        mkdir -p "$node2DataPath"
    fi
    bitcoind -conf="$node2Path/bitcoin.conf" -datadir="$node2DataPath"
    sleep 1
    echo "create node2 wallet test"
    param="-chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=28443"
    bitcoin-cli $param createwallet test # 2> /dev/null
    if [ $? -ne 0 ]; then
        echo "node2 wallet exists, load wallet"
        bitcoin-cli $param loadwallet test
    else
        echo "create node2 wallet success"
        newaddress=$(bitcoin-cli -rpcwallet=test -rpcuser=jacky -rpcpassword=123456 -rpcport=28443 getnewaddress)
        echo "get node2 wallet new address:$newaddress, generate 101 blocks for first mint"
        bitcoin-cli -rpcwallet=test -rpcuser=jacky -rpcpassword=123456 -rpcport=28443 generatetoaddress 101 "$newaddress"
    fi
    echo "node2 wallet info:"
    bitcoin-cli $param getwalletinfo
    echo "node2 wallet balance:"
    bitcoin-cli $param getbalance
fi



