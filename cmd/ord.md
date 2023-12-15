```shell
ord --wallet ord --chain regtest --bitcoin-data-dir ./ wallet create
ord --wallet ord --chain regtest --bitcoin-data-dir ./ wallet receive
# generate index by balance
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ wallet balance
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ wallet transactions
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ wallet inscribe --file ./ord.md --fee-rate 25
ord --wallet ord --chain regtest --bitcoin-data-dir ./ --data-dir ./ server --enable-json-api --http
ord --wallet ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --data-dir ./ ....
```