#!/bin/bash
# set -x
set -e

# mac for bitciond and bitcoin-cli
# brew install bitcoin

# install bitcoind
# ubuntu 22.04
# ref: https://bitcointalk.org/index.php?topic=5496494

if command -v bitcoind-testnet4 &>/dev/null; then
    echo "bitcoind-testnet4 is already installed"
else
    echo "preparing to install bitcoind-testnet4"
    #install all prereqs
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && apt-get -y install git autoconf pkg-config libtool build-essential bsdmainutils libevent-dev libdb-dev libdb++-dev clang python3 libssl-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libsqlite3-dev ccache
    #pull pr
    git clone https://github.com/bitcoin/bitcoin.git ./bitcoin
    cd ./bitcoin
    git fetch origin pull/29775/head:pr-29775 && git checkout pr-29775
    #compile
    ./autogen.sh
    ./configure --with-incompatible-bdb CC=clang CXX=clang++
    make -j "$(($(nproc) + 1))"
    cd src
    strip bitcoin-util && strip bitcoind && strip bitcoin-cli && strip bitcoin-tx && strip qt/bitcoin-qt
    cp bitcoind /usr/local/bin/bitcoind-testnet4
fi
