#!/bin/bash

CHECK_INTERVAL=30

while true; do
  TX_COUNT=$(btcctl -C ./btcctl-btcd.conf getrawmempool | jq '. | length')

  # shellcheck disable=SC2181
  if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch mempool transactions."
    sleep "$CHECK_INTERVAL"
    continue
  fi

  if [ "$TX_COUNT" -gt 0 ]; then
    echo "$(date): New transactions found in mempool: $TX_COUNT. Mining a new block..."
    if ! btcctl -C ./btcctl-btcd.conf generate 1; then
      echo "Error: Failed to generate new block."
    else
      echo "New block generated successfully."
    fi
  else
    echo "$(date): No new transactions in mempool."
  fi

  sleep "$CHECK_INTERVAL"
done
