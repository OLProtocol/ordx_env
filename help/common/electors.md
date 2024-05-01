```shell
# /target/release/electrs -vvvv --db-dir /data/electorsData --daemon-dir ./bitcoin/testnet -network testnet --cors "*"

# /target/release/electrs -vvvv --utxos-limit 5000 --electrum-txs-limit 5000 --db-dir /data/electorsData --daemon-rpc-addr "192.168.1.100:38443" --http-addr 0.0.0.0:3002 --network testnet --cors "*"

target/release/electrs -vvvv --cookie jacky:123456 --db-dir /data/electorsData --daemon-dir /media/sf_bitcoin/ --daemon-rpc-addr "192.168.1.100:38443" --network testnet --cors "*" --utxos-limit 5000 --electrum-txs-limit 5000 --electrum-rpc-addr "0.0.0.0:60001" --http-addr "0.0.0.0:3002" --log-filters = "INFO"
```