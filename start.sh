#!/bin/bash
# set -x

if command -v python3 &> /dev/null
then
    echo "rustc is python3 installed"
else
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.8
    update-alternatives --remove python /usr/bin/python2
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10
    python --version
    sudo apt install python3-pip
    python -m pip install pip
    source ~/.zshrc
    pip3 --version
fi

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



# nodejs
if command -v nvm &> /dev/null
then
    echo "nvm is already installed"
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm list
    nvm install 16.13.0
    nvm use 16
fi

# rust: dependencies: ord, electors
if command -v rustc &> /dev/null
then
    echo "rustc is already installed"
else
    echo "preparing to install rustc"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustc --version
    rustup toolchain install 1.70
    rustup default 1.70
    source "$HOME/.cargo/env"
    # rustup show, rustup toolchain list
fi

# just/mdbook: tool
if command -v just &> /dev/null
then
    echo "just is already installed"
else
    cargo install just
    cargo install mdbook
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

# esplora
cd $script_path/esplora && npm i
export API_URL=http://localhost:3002/
esploraLog="$script_path/log/esplora.log"
nohup npm run dev-server >> $esploraLog 2>&1 &




