./Bitcoin-Qt  -server  -datadir=./ -txindex  -chain=regtest  -rpcuser=jacky -rpcpassword=123456 -rpcallowip=0.0.0.0/0
./bitcoind  -server  -datadir=./ -txindex  -chain=regtest  -rpcuser=jacky -rpcpassword=123456 -rpcallowip=0.0.0.0/0 -rpcport=18443

bitcoind  -server  -datadir=./ -txindex  -chain=regtest -rpcbind=0.0.0.0:18443 -rpcuser=jacky -rpcpassword=123456 -rpcallowip=0.0.0.0/0
nohup bitcoind  -server  -datadir=./ -txindex  -chain=regtest -rpcbind=0.0.0.0:18443 -rpcuser=jacky -rpcpassword=123456 -rpcallowip=0.0.0.0/0 > ./log.log 2>&1 &

sudo apt install postgresql
sudo -i -u postgres 
