#!/bin/bash
# set -x
set -e

script_path=$(cd "$(dirname "$0")" && pwd)
cd "$script_path/../.."
git submodule update --init --recursive ord

# ord
projectPath="$script_path/../../ord"
binPath="$projectPath/target/release/ord"
if [ ! -f "$binPath" ]; then
    sudo apt-get install libssl-dev
    cd "$projectPath" && git checkout 0.16.0-ordx && cargo build --release
    cp "$binPath" /usr/local/bin/ord0.16.0-ordx
else
    echo "ord already copy to bin"
fi