```shell
// for https://github.com/xxxx/electrs
# /target/release/electrs -vvvv --db-dir /data/electorsData --daemon-dir ./bitcoin/testnet -network testnet --cors "*"

# /target/release/electrs -vvvv --utxos-limit 5000 --electrum-txs-limit 5000 --db-dir /data/electorsData --daemon-rpc-addr "192.168.1.100:38443" --http-addr 0.0.0.0:3002 --network testnet --cors "*"

target/release/electrs -vvvv --cookie jacky:123456 --db-dir /data/electorsData --daemon-dir /media/sf_bitcoin/ --daemon-rpc-addr "192.168.1.100:38443" --network testnet --cors "*" --utxos-limit 5000 --electrum-txs-limit 5000 --electrum-rpc-addr "0.0.0.0:60001" --http-addr "0.0.0.0:3002" --log-filters = "INFO"

target/release/electrs -vvvv --cookie jacky:_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 --db-dir /Users/chenwenjie/test/rust/satsnet-electrs/data --daemon-rpc-addr "192.168.10.101:8332" --network mainnet

// for https://github.com/sat20-labs/satsnet-electrs
// for https://github.com/mempool/electrs
// default_http_port = 3000 
// default_electrum_port = 50001
// default_daemon_port = 8332
// default_monitoring_port = 4224
target/release/electrs -vvvv --cookie jacky:_RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 --daemon-rpc-addr "192.168.10.101:8332" --jsonrpc-import --network mainnet --cors "*"

// default_http_port = 3004
// default_electrum_port = 40001
// default_daemon_port = 48332
// default_monitoring_port = 44224
target/release/electrs -vvvv --cookie jacky:123456 --daemon-rpc-addr "192.168.10.101:28332" --jsonrpc-import --network testnet4 --cors "*"
```