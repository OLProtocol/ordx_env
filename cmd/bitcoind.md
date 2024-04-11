```shell
bitcoind -server -daemon -rpcworkqueue=32 -chain=regtest -txindex -maxmempool=1024 -datadir=/var/lib/bitcoind -conf=/etc/bitcoin/bitcoin.conf  
bitcoind -server -daemon -rpcworkqueue=32 -chain=regtest -txindex -maxmempool=1024 -datadir=./ -rpcuser=jacky -rpcpassword=123456 -rpcallowip=0.0.0.0/0 -rpcbind=0.0.0.0:18443 -rpcport=18443 
# ./Bitcoin-Qt 
```