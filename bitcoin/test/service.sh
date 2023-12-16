#!/bin/bash

script_path=$(cd "$(dirname "$0")" && pwd)
node1Path="$script_path"
node1DataPath=/media/sf_bitcoin/test
node1CookiePath="$node1DataPath/.cookie"
if [ ! -d "$node1DataPath" ]; then
    mkdir -p "$node1DataPath"
fi
bitcoind -conf="$node1Path/bitcoin.conf" -rpccookiefile="$node1CookiePath" -datadir="$node1DataPath"