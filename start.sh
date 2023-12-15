#!/bin/bash
# set -x

# bitcoind install and run
script_path=$(cd "$(dirname "$0")" && pwd)
"$script_path"/bitcoin/install.sh
"$script_path"/bitcoin/regtest/service.sh node1 node2

# auto mint
pids=$(ps aux | grep mint.sh | awk '{print $2}')
echo "mint pids: $pids"

for pid in $pids; do
    kill $pid 2>/dev/null
done

pid=$(ps aux | grep "$script_path"/bitcoin/regtest/mint.sh | awk 'NR==2 {print $2}')
if [[ $pid =~ ^[0-9]+$ ]]; then
    kill -9 $pid
fi
if [ "$1" == "-mint" ] && [ "$2" -gt 0 ]; then
    echo "start auto mint"
    "$script_path"/bitcoin/regtest/mint.sh 30 >> /dev/null &
fi

# electors
if [ ! -f "$script_path/electors/target/release/electrs" ]; then
    cd $script_path/electors && git checkout new-index && cargo build --release
fi

if pgrep electrs >/dev/null; then
    echo "Terminating existing electrs processes, restart electrs..."
    sudo pkill electrs
fi

if [ ! -d "$script_path/electorsData" ]; then
    mkdir -p "$script_path/electorsData"
fi

if [ ! -d "$script_path/log" ]; then
    mkdir -p "$script_path/log"
fi
electorLog="$script_path/log/elector.log"
nohup $script_path/electors/target/release/electrs -vvvv --db-dir $$script_path/electorsData --daemon-dir $script_path/bitcoin/regtest/node1/data --network regtest --cors "*" >> $electorLog 2>&1 &


echo "start electrs and test http://localhost:3002/blocks/tip/height:"
curl http://localhost:3002/blocks/tip/height

# install esplora
cd $script_path/esplora && npm i
export API_URL=http://localhost:3002/
esploraLog="$script_path/log/esplora.log"
nohup npm run dev-server >> $esploraLog 2>&1 &
