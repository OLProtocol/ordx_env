```shell
# sample 
btcwallet --regtest --rpcuser=jacky --rpcpass=123456 --rpccert=/root/.btcd/rpc.cert --rpclisten=192.168.10.102

# start btcd
/data/github/satoshinet/satoshinet -C conf/simnet.conf --txindex --addrindex --miningaddr=SQLoAw7Q24DiLkoecZEsULUYbqcuGi2LTS
/data/github/satoshinet/satoshinet -C conf/regtest.conf --txindex --addrindex
/data/github/satoshinet/satoshinet -C conf/mainnet.conf --txindex --addrindex --connect=192.168.10.101 --maxpeers=1 --nodnsseed

# dependencies
sudo apt-get install jq 

# wallet create and run rpc service
go install github.com/btcsuite/btcwallet@latest
btcwallet --simnet --create default
btcctl -C ./btcctl-wallet.conf --wallet createnewaccount default
btcwallet -C ./btcwallet.conf

btcctl -l # list commond list
btcctl -C ./btcctl-wallet.conf --wallet walletpassphrase "hht" 600 # unlock wallet timeout 600s
btcctl -C ./btcctl-wallet.conf --wallet getnewaddress
btcctl -C ./btcctl-wallet.conf --wallet getaddressesbyaccount default
btcctl -C ./btcctl-wallet.conf --wallet listaccounts

# generate new block
btcctl -C ./btcctl-btcd.conf generate 100
btcctl -C ./btcctl-wallet.conf --wallet getbalance default

# send transaction
btcctl -C ./btcctl-wallet.conf --wallet sendtoaddress SYaDYKqmywEGNUvVtCdnCdD2GpvSAWYBmn 100

# 1 auto mint
# mint.sh <receive-address>

# 2 generate new address: 
# gen-addr.sh

# 3 transaction
# gen-tx.sh <receive-address> <amount>
```