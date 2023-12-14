#!/bin/bash
# set -eux

# install bitcoind
script_path=$(cd "$(dirname "$0")" && pwd)
"$script_path"/bitcoin/install.sh

"$script_path"/bitcoin/regtest/service.sh node1 node2

pid=$(ps aux | grep mint.sh | awk 'NR==2 {print $2}')
if [[ $pid =~ ^[0-9]+$ ]]; then
    kill -9 $pid
fi
"$script_path"/bitcoin/regtest/mint.sh 30 >> /dev/null &

# install electors
if [ ! -f "$script_path/electors/target/release/electrs" ]; then
    cd $script_path/electors && git checkout new-index && cargo build --release
fi

if pgrep electrs >/dev/null; then
    echo "Terminating existing electrs processes, restart electrs..."
    pkill electrs
fi

if [ ! -d "$script_path/electorsData" ]; then
    mkdir -p "$script_path/electorsData"
fi
nohup $script_path/electors/target/release/electrs -vvvv --db-dir $script_path/electorsData --daemon-dir $script_path/bitcoin/regtest/node1/data --network regtest --cors "*" &

sleep 1
echo "start electrs and test http://localhost:3002/blocks/tip/height:"
curl http://localhost:3002/blocks/tip/height

# install esplora
cd $script_path/esplora && npm i
export API_URL=http://localhost:3002/
nohup npm run dev-server &






