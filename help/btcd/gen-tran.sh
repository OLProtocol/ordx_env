#!/bin/bash

RPC_USER="jacky"
RPC_PASS="123456"
RPC_HOST="192.168.10.102"
RPC_PORT="18334"
TLS_CERT_PATH="./rpc.cert"

SENDER_ADDRESS=$1
RECEIVER_ADDRESS=$2
AMOUNT=$3

UTXOS=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpchost=$RPC_HOST --rpcport=$RPC_PORT --tlscertpath=$TLS_CERT_PATH listunspent 0 9999999 '["'"$SENDER_ADDRESS"'"]')
TXID=$(echo "$UTXOS" | jq -r '.[0].txid')
VOUT=$(echo "$UTXOS" | jq -r '.[0].vout')

# create raw transaction
RAW_TX=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpchost=$RPC_HOST --rpcport=$RPC_PORT --tlscertpath=$TLS_CERT_PATH createrawtransaction '[{"txid":"'"$TXID"'","vout":'"$VOUT"'}]' '{"'"$RECEIVER_ADDRESS"'":'"$AMOUNT"'}')

# sign raw transaction
SIGNED_TX=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpchost=$RPC_HOST --rpcport=$RPC_PORT --tlscertpath=$TLS_CERT_PATH signrawtransactionwithwallet "$RAW_TX" | jq -r '.hex')

# send raw transaction
TXID=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpchost=$RPC_HOST --rpcport=$RPC_PORT --tlscertpath=$TLS_CERT_PATH sendrawtransaction "$SIGNED_TX")

echo "Transaction sent with TXID: $TXID"
