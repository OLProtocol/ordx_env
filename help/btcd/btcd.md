```shell
# sample 
btcwallet --regtest --rpcuser=jacky --rpcpass=123456 --rpccert=/root/.btcd/rpc.cert --rpclisten=192.168.10.102

# start btcd
/data/github/satoshinet/satoshinet -C conf/regnet.conf --txindex --addrindex
/data/github/satoshinet/satoshinet -C conf/mainnet.conf --txindex --addrindex --connect=192.168.10.101 --maxpeers=1 --nodnsseed

# dependencies
sudo apt-get install jq 
go install github.com/btcsuite/btcwallet@latest


# 1 auto mint
# mint.sh <receive-address>

# 2 generate new address: 
# gen-addr.sh

# 3 transaction
# gen-tx.sh <receive-address> <amount>
```