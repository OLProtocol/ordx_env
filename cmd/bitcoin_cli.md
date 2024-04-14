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

# 原始交易（所有交易包括内存池），字段中有确认数（内存池交易没有确认数）
bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 getrawtransaction 87652d8a228df4e54cae06ed39354795a517c9c9ac6cd9159aac359cb5ab909f true > test.txt
# 显示交易，包括内存池交易(不一定能显示，内存池中已使用的未花费输出不会出现) 第2个参数为out的索引号, 会显示确认数量
bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 gettxout 87652d8a228df4e54cae06ed39354795a517c9c9ac6cd9159aac359cb5ab909f 0 true
# 只显示内存池交易信息
bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 getmempoolentry fc36ab299ba69646aed873d737a9df4658faf7bdc94e7e30d60f018e4acad226 > test.txt
# 得到所有的内存池交易
bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 getrawmempool false true

bitcoin-cli -chain=main -rpcuser=jacky -rpcpassword=_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 -rpcconnect=192.168.1.102 -rpcport=8332 sendrawtransaction 0100000001e34ac1e2baac09c366fce1c2245536bda8f7db0f6685862aecf53ebd69f9a89c000000006a47304402203e8a16522da80cef66bacfbc0c800c6d52c4a26d1d86a54e0a1b76d661f020c9022010397f00149f2a8fb2bc5bca52f2d7a7f87e3897a273ef54b277e4af52051a06012103c9700559f690c4a9182faa8bed88ad8a0c563777ac1d3f00fd44ea6c71dc5127ffffffff02a0252600000000001976a914d90d36e98f62968d2bc9bbd68107564a156a9bcf88ac50622500000000001976a91407bdb518fa2e6089fd810235cf1100c9c13d1fd288ac00000000