#!/bin/bash
# set -x
set -e

# install rustc
sudo apt-get install pkg-config libssl-dev
sudo apt install build-essential
rm -rf "$HOME/.cargo/registry"
if command -v rustc &> /dev/null
then
    echo "rustc is already installed"
else
    echo "preparing to install rustc"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # shellcheck disable=SC1091
    source "$HOME/.cargo/env"
    rustc --version
    rustup toolchain install 1.70
    rustup default 1.70
    # rustup show, rustup toolchain list
fi
