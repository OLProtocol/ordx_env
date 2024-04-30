#!/bin/bash
# set -x
set -e

script_path=$(cd "$(dirname "$0")" && pwd)
cd "$script_path/../.."
git submodule update --init --recursive electrs esplora
projectPath="$script_path/../../electrs"
binPath="$projectPath/target/release/electrs"

if [ ! -f "$binPath" ]; then
    cd "$projectPath" && git checkout new-index && cargo build --release
    cp "$binPath" /usr/local/bin/electrs
else
    echo "electrs already copy to bin"
fi
