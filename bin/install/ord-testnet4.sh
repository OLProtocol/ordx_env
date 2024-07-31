#!/bin/bash
# set -x
set -e

# source code
# 1 https://github.com/softwarecheng/ord branch ordx0.16.0-ordx-testnet4
# 2 https://github.com/softwarecheng/rust-bitcoin  branch testnet4
# 3 https://github.com/softwarecheng/rust-bitcoincore-rpc branch testnet4

# libray https://crates.io/
# 1 https://crates.io/crates/bitcoint4
# 2 https://crates.io/crates/bitcoint4_hashes
# 3 https://crates.io/crates/bitcoint4-private
# 4 https://crates.io/crates/ord-bitcoincoret4-rpc
# 5 https://crates.io/crates/ord-bitcoincoret4-rpc-json

# build
# cargo build --release

# publish
# cargo login // softwarecheng
# cargo publish -p bitcoint4
# cargo publish -p ord-bitcoincoret4-rpc
# cargo publish -p ord-bitcoincoret4-rpc-json
# cargo publish -p bitcoint4-private

# run
# ord0.16.0-ordx-testnet4 --chain testnet4 --bitcoin-rpc-url 192.168.10.102:28332 --data-dir /data2/ord-data/0.16.0 \
#--bitcoin-rpc-username jacky --bitcoin-rpc-password 123456 --first-inscription-height 0 --index-sats \
#--minify server --http --http-port 80
