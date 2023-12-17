```shell
ord --wallet ord --chain regtest --bitcoin-data-dir ./ wallet create
ord --wallet ord --chain regtest --bitcoin-data-dir ./ wallet receive
# generate index by balance
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ wallet balance
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ wallet transactions
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ wallet inscribe --file ./ord.md --fee-rate 25
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ server --enable-json-api --http
ord --wallet ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --data-dir ./ ....
ord --chain regtest --cookie-file /root/btcnet_env/bitcoin/regtest/node1/data/regtest/.cookie --height-limit 0 index run
ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --data-dir ./ --rpc-url 192.168.1.106:28443 --height-limit 0 index run
```