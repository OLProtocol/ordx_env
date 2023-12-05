```shell
brew install bitcoin

./Bitcoin-Qt -server -datadir=./ -txindex -chain=regtest -rpcuser=jacky -rpcpassword=123456

curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "createwallet", "params": ["test"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/
curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:18443/
curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "generatetoaddress", "params": [101, "bcrt1qafmy5mz4hgjqx96wwlx2aq7ddrvug4lwx6erfj"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/
curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getbalance", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:18443/


bitcoin-cli  -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 -rpcport=18443 createwallet test
&& bitcoin-cli  -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 -rpcport=18443 getnewaddress
# 为什么生成101个区块是因为回归测试模式中，前100个块是拿不到 BTC 的，需要生成第101个块的时候才有BTC.
bitcoin-cli -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 -rpcport=18443 generatetoaddress 101 <getnewaddress>
bitcoin-cli  -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 -rpcport=18443 getbalance
bitcoin-cli  -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 -rpcport=18443 getwalletinfo

export ORD_BITCOIN_RPC_USER=jacky
export ORD_BITCOIN_RPC_PASS=123456
ord --wallet test  --chain regtest server
ord --wallet test --chain regtest wallet balance

ord --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 server
ord --wallet test  --bitcoin-data-dir ./ --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet create
ord --wallet test  --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet receive
bitcoin-cli -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 -rpcport=18443 generatetoaddress 101 <getnewaddress>
ord --wallet test  --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet balance
ord --wallet test  --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet transactions
ord --wallet panda --bitcoin-data-dir ./ --data-dir ./ wallet inscribe ./settings.json --fee-rate 8

```

### https://www.r9it.com/20181209/build-bitcoin-private-chain.html

### https://github.com/ordinals/ord