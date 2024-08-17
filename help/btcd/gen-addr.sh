#!/bin/bash

RPC_USER="jacky"
RPC_PASS="123456"
RPC_HOST="192.168.10.102"

TLS_CERT_PATH="./rpc.cert"
NEW_ADDRESS=$(btcctl -C ./regtest.conf --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpcserver=$RPC_HOST --rpccert=$TLS_CERT_PATH getnewaddress)

echo "New Bitcoin address: $NEW_ADDRESS"
