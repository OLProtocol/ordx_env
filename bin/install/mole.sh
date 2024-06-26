#!/bin/bash
# set -x
set -e

script_path=$(cd "$(dirname "$0")" && pwd)
cd "$script_path/../.."
git submodule update --init --recursive mole

if command -v mole &> /dev/null
then
    echo "mole is already installed"
else
    script_path=$(cd "$(dirname "$0")" && pwd)
    projectPath="$script_path/../../mole"
    export GOOS=linux
    export GOARCH=amd64
    export CGO_ENABLED=0
    cd "$projectPath" && go build -o /usr/local/bin/mole
fi
