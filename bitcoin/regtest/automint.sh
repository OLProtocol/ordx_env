#!/bin/bash

script_path=$(cd "$(dirname "$0")" && pwd)
node1Path="$script_path/node1"
node1DataPath="$node1Path/data"
node1CookiePath="$node1DataPath/regtest/.cookie"
echo "node1 cookie path: $node1CookiePath"
echo "node1 data path: $node1DataPath"
node1cli="bitcoin-cli -chain=regtest -rpccookiefile=$node1CookiePath -datadir=$node1DataPath -generate 1"
node2cli="bitcoin-cli -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=28443 -generate 1"

# the mining interval in seconds
if [ -z "$1" ]; then
    blockTime=5
else
    blockTime=$1
fi

while true
do
    # each node has a 50% chance of mining the next block
    rnd=$((RANDOM%2))
    if [ "$rnd" = "0" ];
    then
        echo node1 generated the next block:
        $node1cli
    else
        echo node2 generated the next block:
        $node2cli
    fi
    sleep "$blockTime"
done

# ref https://medium.com/@kay.odenthal_25114/create-a-private-bitcoin-network-with-simulated-mining-b35f5b03e534