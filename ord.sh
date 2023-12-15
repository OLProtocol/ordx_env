#!/bin/bash
# set -x

script_path=$(cd "$(dirname "$0")" && pwd)
ordBin="$script_path/ord/target/release/ord"
ordDataPath="$script_path/ordData"
bitcoinNode1Path="$script_path/bitcoin/regtest/node1/data"

node1Path="$script_path/bitcoin/regtest/node1"
node1DataPath="$node1Path/data"
node1CookiePath="$node1DataPath/regtest/.cookie"

if pgrep -x $ordBin >/dev/null; then
    echo "Terminating existing ord processes, restart ord..."
    sudo pkill -x ord
fi

if [ ! -f "$ordBin" ]; then
    sudo apt-get install libssl-dev
    cd ord && cargo build --release
    
fi

if [ ! -d "$ordDataPath" ]; then
    mkdir -p "$ordDataPath"
fi

if [ ! -f "$ordDataPath/inscribe.txt" ]; then
    echo "first inscribe" >> "$ordDataPath/inscribe.txt"
fi

param="--wallet ord --chain regtest --bitcoin-data-dir $bitcoinNode1Path --data-dir $ordDataPath"
seed=$(eval "$ordBin" "$param" wallet create 2>/dev/null)
if [ $? -eq 0 ]; then
    echo "ord wallet create success"
    echo "$seed" >> "$ordDataPath/walletSeed.txt"
    
    addressJsonStr=$(eval "$ordBin" "$param" wallet receive)
    address=$(echo "$addressJsonStr" | jq -r '.address')
    
    tx=$(bitcoin-cli -rpcwallet=test -chain=regtest -rpccookiefile="$node1CookiePath" -datadir="$node1Path" -named sendtoaddress address="$address" amount=1 fee_rate=25)
    echo "ord wallet create new receive address: $address and send 1 btc, tx: $tx"
    echo "ord wallet balance:"
    eval "$ordBin" "$param" wallet balance
    
    output=$(eval "$ordBin" "$param" wallet inscribe --file "$ordDataPath"/inscribe.txt --fee-rate 25)
    
    echo "ord wallet inscribe: $ordDataPath/inscribe.txt, fee_rate = 25, output: $output"
    echo "ord wallet balance:"
    eval "$ordBin" "$param" wallet balance
else
    echo "ord wallet is already existed"
fi

ordLog="$script_path/log/ord.log"

"$ordBin" --wallet ord --chain regtest --bitcoin-data-dir "$bitcoinNode1Path" --data-dir "$ordDataPath" server --enable-json-api --http >> "$ordLog" 2>&1 &

echo "ord service starting..."