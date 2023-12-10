```shell
brew install bitcoin

# 
bitcoind -server -rpcuser=jacky -rpcpassword=123456 -chain=regtest -datadir=./ -txindex
./Bitcoin-Qt -server -rpcuser=jacky -chain=regtest  -datadir=./ -txindex


#
ord --wallet test --bitcoin-data-dir ./ --chain regtest wallet create
ord --wallet test --bitcoin-data-dir ./ --chain regtest wallet receive
bitcoin-cli -datadir=./ -chain=regtest generatetoaddress 1 bcrt1paw9uuerpcaz7telg6amcfrz7c408h9hgrf5pgzhutx4ut3pcvkfs28hd38
ord --wallet test --bitcoin-data-dir ./ --data-dir ./ --chain regtest wallet balance
ord --wallet test --bitcoin-data-dir ./ --chain regtest --data-dir ./ wallet transactions
ord --wallet test --bitcoin-data-dir ./ --chain regtest --data-dir ./ wallet inscribe --file ./ord.md --fee-rate 8

ord --wallet test --bitcoin-data-dir ./ --chain regtest --data-dir ./ server

bitcoin-cli -datadir=./ -chain=regtest generatetoaddress 1 bcrt1prvv9a4ag7hk5836d6nt5sgqu6fxuu9sftsrf7ffyrknm20ms3syq6dnczv

bitcoin-cli -datadir=./ -chain=regtest  getbalance

#
cd <bitcoin_data>
rm -rf regtest
# bitcoind -server -datadir=./ -chain=signet -conf=./bitcoin.conf --txindex=1  -maxmempool=1024 -daemon=1
bitcoind -server -rpcuser=jacky -rpcpassword=123456 -chain=regtest -datadir=./ -txindex

ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet create
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet receive
bitcoin-cli -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 --chain=regtest getblockchaininfo
#
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest --data-dir ./ wallet balance
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet transactions
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest --data-dir ./ wallet inscribe --file ./ord.md --fee-rate 8
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest --data-dir ./  server --enable-json-api

#
bitcoind -server -daemon -conf=/etc/bitcoin/bitcoin.conf -chain=regtest -datadir=/var/lib/bitcoind -txindex

ord --bitcoin-data-dir /var/lib/bitcoind --cookie-file /var/lib/bitcoind/regtest/.cookie --data-dir /var/lib/ord --chain regtest wallet create
ord --bitcoin-data-dir /var/lib/bitcoind --cookie-file /var/lib/bitcoind/regtest/.cookie --data-dir /var/lib/ord --chain regtest wallet receive
ord --bitcoin-data-dir /var/lib/bitcoind --cookie-file /var/lib/bitcoind/regtest/.cookie --data-dir /var/lib/ord --chain regtest wallet balance
bitcoin-cli -rpcwallet=ord -rpccookiefile=/var/lib/bitcoind/regtest/.cookie -datadir=/var/lib/bitcoind -chain=regtest getblockchaininfo 
bitcoin-cli -rpcwallet=ord -rpccookiefile=/var/lib/bitcoind/regtest/.cookie -datadir=/var/lib/bitcoind -chain=regtest generatetoaddress 101 bcrt1p4t4gvt63xhmmkt6c760enyqw0j3wteqpw8uezwrw0d7rf6tw5p2s0n37s9
ord --bitcoin-data-dir /var/lib/bitcoind --cookie-file /var/lib/bitcoind/regtest/.cookie --data-dir /var/lib/ord --chain regtest wallet inscribe --file ./test.md --fee-rate 8
bitcoin-cli -rpcwallet=ord -rpccookiefile=/var/lib/bitcoind/regtest/.cookie -datadir=/var/lib/bitcoind -chain=regtest generatetoaddress 1 bcrt1p4t4gvt63xhmmkt6c760enyqw0j3wteqpw8uezwrw0d7rf6tw5p2s0n37s9
ord --bitcoin-data-dir /var/lib/bitcoind --cookie-file /var/lib/bitcoind/regtest/.cookie --data-dir /var/lib/ord --chain regtest server --enable-json-api --http
