#!/bin/bash
# set -x
set -e

# mac for bitciond and bitcoin-cli
# brew install bitcoin

# install bitcoind
version=25.0
if command -v bitcoind &>/dev/null; then
    echo "bitcoind is already installed"
else
    echo "preparing to install bitcoind"
    wget \
        -O bitcoin.tar.gz \
        https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-x86_64-linux-gnu.tar.gz

    tar \
        -xzvf bitcoin.tar.gz \
        -C /usr/local/bin \
        --strip-components 2 \
        bitcoin-$version/bin/{bitcoin-cli,bitcoind}
fi
