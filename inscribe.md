```shell
brew install bitcoin

# 
bitcoind -server -rpcuser=jacky -rpcpassword=123456 -chain=regtest -datadir=./ -txindex
./Bitcoin-Qt -server -rpcuser=jacky -chain=regtest  -datadir=./ -txindex


#
ord --wallet test --bitcoin-data-dir ./ --chain regtest wallet create
ord --wallet test --bitcoin-data-dir ./ --chain regtest wallet receive
bitcoin-cli -datadir=./ -chain=regtest generatetoaddress 1 bcrt1paw9uuerpcaz7telg6amcfrz7c408h9hgrf5pgzhutx4ut3pcvkfs28hd38
ord --wallet test --bitcoin-data-dir ./ --data-dir ./ --chain regtest  wallet balance
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
bitcoin-cli -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 --chain=regtest generatetoaddress 1 bcrt1p0h5jgf3k9ljtfhu3c4ax5zudrtw3ewwva0hm0085agzn4phuxcusxp2swl
#
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest --data-dir ./ wallet balance
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet transactions
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest --data-dir ./ wallet inscribe --file ./ord.md --fee-rate 8
ord --wallet test --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest --data-dir ./  server --enable-json-api