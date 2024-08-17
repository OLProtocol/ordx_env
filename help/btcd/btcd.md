```shell
# sample 
btcwallet --regtest --rpcuser=jacky --rpcpass=123456 --rpccert=/root/.btcd/rpc.cert --rpclisten=192.168.10.102

# start btcd
/data/github/satoshinet/satoshinet -C conf/simnet.conf --txindex --addrindex
/data/github/satoshinet/satoshinet -C conf/regtest.conf --txindex --addrindex
/data/github/satoshinet/satoshinet -C conf/mainnet.conf --txindex --addrindex --connect=192.168.10.101 --maxpeers=1 --nodnsseed

# dependencies
sudo apt-get install jq 

# wallet create and run rpc service
go install github.com/btcsuite/btcwallet@latest
btcwallet --simnet --create
btcwallet -C ./btcwallet.conf
btcctl -C ./btcctl.conf --wallet getnewaddress

# generate new block
btcctl -C ./btcctl.conf generate 10

# send transaction
btcctl -C ./btcctl.conf --wallet sendtoaddress SYaDYKqmywEGNUvVtCdnCdD2GpvSAWYBmn 100

# 1 auto mint
# mint.sh <receive-address>

# 2 generate new address: 
# gen-addr.sh

# 3 transaction
# gen-tx.sh <receive-address> <amount>
```