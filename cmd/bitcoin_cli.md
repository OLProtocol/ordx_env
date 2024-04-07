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

bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 getbestblockhash

# 原始交易，包括确认数，内存池交易没有确认数
bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 getrawtransaction e9208be66993442aab67cbebd9eda98a9994c64c630df699c69eadd5e853bbf1 true > test.txt
# 显示所有交易，包括内存池交易 第2个参数为out的索引号, 会显示确认数量
bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 gettxout e9208be66993442aab67cbebd9eda98a9994c64c630df699c69eadd5e853bbf1 1
# 只显示内存池交易信息
bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 getmempoolentry 2d2936d5270037324a11e198357189b7fc78863284c8ef195b4fb4454a0d3384

bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 getrawmempool false true

