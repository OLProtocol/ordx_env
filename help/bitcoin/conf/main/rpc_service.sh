#!/bin/bash

script_path=$(cd "$(dirname "$0")" && pwd)
node1Path="$script_path"
node1DataPath=/media/sf_bitcoin/main
if [ ! -d "$node1DataPath" ]; then
    mkdir -p "$node1DataPath"
fi
bitcoind -conf="$node1Path/rpc_bitcoin.conf" -datadir="$node1DataPath"