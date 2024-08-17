#!/bin/bash

RPC_USER="jacky"
RPC_PASS="123456"
RPC_HOST="192.168.10.102"
RPC_PORT="18334"
TLS_CERT_PATH="./rpc.cert"
NEW_ADDRESS=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpcserver=$RPC_HOST --rpcport=$RPC_PORT --rpccert=$TLS_CERT_PATH getnewaddress)
btcctl --regtest --rpcuser=jacky--rpcpass=123456 --rpcserver=192.168.10.102 --rpcport=18334 --rpccert=./rpc.cert getnewaddress

echo "New Bitcoin address: $NEW_ADDRESS"
