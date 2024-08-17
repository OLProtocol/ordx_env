```shell

# start btcd
/data/github/satoshinet/satoshinet -C conf/regnet.conf --txindex --addrindex

/data/github/satoshinet/satoshinet -C conf/mainnet.conf --txindex --addrindex --connect=192.168.10.101 --maxpeers=1 --nodnsseed

# auto mint 
sudo apt-get install jq 
./mine.sh 10

mint.sh

#!/bin/bash

RPC_USER="jacky"
RPC_PASS="123456"
CHECK_INTERVAL=$1

# ADDRESS=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS getnewaddress)
FIXED_ADDRESS="your_fixed_bitcoin_address"
while true; do
  TX_COUNT=$(btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS getrawmempool | jq '. | length')
  if [ "$TX_COUNT" -gt 0 ]; then
    echo "New transactions found in mempool: $TX_COUNT. Mining a new block..."
    btcctl --regtest --rpcuser=$RPC_USER --rpcpass=$RPC_PASS generate 1 $FIXED_ADDRESS
  else
    echo "No new transactions in mempool."
  fi
  sleep $CHECK_INTERVAL
done

```