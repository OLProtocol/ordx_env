#!/bin/bash

FIXED_ADDRESS=$1

RPC_USER="jacky"
RPC_PASS="123456"
RPC_HOST="192.168.10.102"
RPC_PORT="18334"
TLS_CERT_PATH="./rpc.cert"

CHECK_INTERVAL=30

while true; do
  TX_COUNT=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpchost=$RPC_HOST --rpcport=$RPC_PORT --tlscertpath=$TLS_CERT_PATH getrawmempool | jq '. | length')
  if [ "$TX_COUNT" -gt 0 ]; then
    echo "New transactions found in mempool: $TX_COUNT. Mining a new block..."
    btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpchost=$RPC_HOST --rpcport=$RPC_PORT --tlscertpath=$TLS_CERT_PATH generate 1 "$FIXED_ADDRESS"
  else
    echo "No new transactions in mempool."
  fi
  sleep "$CHECK_INTERVAL"
done
