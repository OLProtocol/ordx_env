#!/bin/bash
# set -x
set -e

git submodule update --init --recursive

script_path=$(cd "$(dirname "$0")" && pwd)

# electrs
projectPath="$script_path/../../electrs"
binPath="$projectPath/target/release/electrs"

if [ ! -f "$binPath" ]; then
    cd "$projectPath" && git checkout new-index && cargo build --release
    cp "$binPath" /usr/local/bin/electrs
else
    echo "electrs already copy to bin"
fi
