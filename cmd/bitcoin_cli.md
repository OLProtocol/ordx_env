```shell
bitcoin-cli -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=18443 createwallet test
bitcoin-cli -rpcconnect=192.168.1.106 -rpcwallet=test -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=28443 getwalletinfo
bitcoin-cli -rpcwallet=ord -chain=regtest -datadir=./ generatetoaddress 1 <address>
bitcoin-cli -rpcwallet=ord -chain=regtest -datadir=./ getbalance
bitcoin-cli -rpcwallet=ord -chain=regtest -rpccookiefile=<bitcoinDataDir>/.cookie -datadir=<datadir> getblockchaininfo
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=18443 getnewaddress
# ref https://developer.bitcoin.org/reference/rpc/sendtoaddress.html

bitcoin-cli -rpcwallet=ord -chain=regtest -datadir=./ generatetoaddress 1 <address>
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcconnect=192.168.1.106 -rpcport=28443 -named sendtoaddress  address=bcrt1qmu0hsrf37394ljd4j2xhc3j4vpahrvzgx78vy9 amount=0.5 fee_rate=25
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcconnect=192.168.1.106 -rpcport=28443 generatetoaddress 1 bcrt1qmu0hsrf37394ljd4j2xhc3j4vpahrvzgx78vy9
```

bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcconnect=192.168.1.106 -rpcport=28443 getbestblockhash

bitcoin-cli -chain=test -rpcconnect=127.0.0.1 -rpcuser=jacky -rpcpassword=123456 stop
tail -f /data/bitcoinData/testnet3/debug.log