### 铭刻操作

1 start bitcoin service for regtest
```shell
#linux
bitcoind -server -datadir=./ -txindex -chain=regtest -rpcbind=0.0.0.0:18443 -rpcuser=jacky -rpcpassword=123456 -rpcallowip=0.0.0.0/0
nohup bitcoind -server -datadir=./ -txindex -chain=regtest -rpcbind=0.0.0.0:18443 -rpcuser=jacky -rpcpassword=123456 -rpcallowip=0.0.0.0/0 > ./log.log 2>&1 &

#mac 
nohup Bitcoin-Qt -server -datadir=./ -txindex -chain=regtest -rpcuser=jacky -rpcpassword=123456  > ./log.log 2>&1 &
```

2 create wallet by ord
```shell
ord --wallet test  --bitcoin-data-dir ./ --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet create
ord --wallet test  --bitcoin-data-dir ./ --chain regtest wallet create
```

3

curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "createwallet", "params": ["test"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/

curl --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "createwallet", "params": ["testwallet"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/

curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:18443/

## view wall transactions
```shell
ord --wallet test  --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet transactions
```

## view wallet balance
```shell
ord --wallet test  --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet balance
```

## create wallet address
```shell
ord --wallet test  --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet receive
```

bitcoin-cli  -rpcwallet=test -rpcuser=jacky  -rpcpassword=123456 -rpcport=18443  -generate

3 mint btc coin
```shell
curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "generatetoaddress", "params": [1, "bcrt1qz4f8zl2mdt2acyu85vlk75md07e7t9wzwy6v58"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/
```


2 生成ord索引
ord  --wallet test  --data-dir ./ordData --bitcoin-data-dir ./ --bitcoin-rpc-pass 123456 --bitcoin-rpc-user jacky --chain regtest wallet balance


3 铸造铭文