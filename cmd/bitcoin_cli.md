```shell
bitcoin-cli -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=18443 createwallet test
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=18443 getwalletinfo
bitcoin-cli -rpcwallet=ord -chain=regtest -datadir=./ generatetoaddress 1 <address>
bitcoin-cli -rpcwallet=ord -chain=regtest -datadir=./ getbalance
bitcoin-cli -rpcwallet=ord -chain=regtest -rpccookiefile=<bitcoinDataDir>/.cookie -datadir=<datadir> getblockchaininfo
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=18443 getnewaddress
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=18443 generate
# ref https://developer.bitcoin.org/reference/rpc/sendtoaddress.html
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcport=18443 -named sendtoaddress address=<address> amount=0.5 fee_rate=25
```
