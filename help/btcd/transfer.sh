#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <receiver_address> <amount>"
    exit 1
fi

RECEIVER_ADDRESS=$1
AMOUNT=$2
# SENDER_ADDRESS=$3

# UTXOS=$(btcctl -C ./regtest.conf --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpcserver=$RPC_HOST --rpccert=$TLS_CERT_PATH listunspent 0 9999999 '["'"$SENDER_ADDRESS"'"]')
# TXID=$(echo "$UTXOS" | jq -r '.[0].txid')
# VOUT=$(echo "$UTXOS" | jq -r '.[0].vout')

# create raw transaction
#RAW_TX=$(btcctl -C ./regtest.conf --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpcserver=$RPC_HOST --rpccert=$TLS_CERT_PATH createrawtransaction '[{"txid":"'"$TXID"'","vout":'"$VOUT"'}]' '{"'"$RECEIVER_ADDRESS"'":'"$AMOUNT"'}')

# sign raw transaction
#SIGNED_TX=$(btcctl -C ./regtest.conf --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpcserver=$RPC_HOST --rpccert=$TLS_CERT_PATH signrawtransactionwithwallet "$RAW_TX" | jq -r '.hex')

# send raw transaction
#TXID=$(btcctl -C ./regtest.conf --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS --rpcserver=$RPC_HOST --rpccert=$TLS_CERT_PATH sendrawtransaction "$SIGNED_TX")

# unlock wallet
btcctl -C ./btcctl-wallet.conf --wallet walletpassphrase "lover" 600

# send transaction
btcctl -C ./btcctl-wallet.conf --wallet sendtoaddress "$RECEIVER_ADDRESS" "$AMOUNT"

echo "Transaction sent with TXID: $TXID"
