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
ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --rpc-url 192.168.1.106:28443 --data-dir ./ --height-limit 0 index run
ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --rpc-url 192.168.1.106:28443 --data-dir ./ wallet inscribe --file ./ord.md --fee-rate 25

ord --wallet ord --chain regtest --cookie-file /root/btcnet_env/bitcoin/regtest/node1/data/regtest/.cookie wallet create
ord --wallet ord --chain regtest --cookie-file /root/btcnet_env/bitcoin/regtest/node1/data/regtest/.cookie wallet receive
ord --wallet ord --chain regtest --cookie-file /root/btcnet_env/bitcoin/regtest/node1/data/regtest/.cookie wallet balance


ord --wallet ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --rpc-url 192.168.1.106:28443 wallet create
ord --wallet ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --rpc-url 192.168.1.106:28443 wallet receive
ord --wallet ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --rpc-url 192.168.1.106:28443 wallet balance

bitcoin-cli -rpcwallet=ord -chain=regtest -rpccookiefile=/root/btcnet_env/bitcoin/regtest/node1/data/regtest/.cookie generatetoaddress 1 bcrt1p3nl05t8euazahz53pg06zsk9dgxt3a3rhw00xl4a699a04m7xxwq5k7jpu
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcconnect=192.168.1.106 -rpcport=28443 -named sendtoaddress address=<address> amount=0.5 fee_rate=25
bitcoin-cli -rpcwallet=ord -chain=regtest -rpcuser=jacky -rpcpassword=123456 -rpcconnect=192.168.1.106 -rpcport=28443 generatetoaddress 100 bcrt1p3nl05t8euazahz53pg06zsk9dgxt3a3rhw00xl4a699a04m7xxwq5k7jpu
#12
ord --wallet ord --chain regtest --bitcoin-rpc-user jacky --bitcoin-rpc-pass 123456 --rpc-url 192.168.1.106:28443 --data-dir ./ wallet inscribe --file ./test.txt --fee-rate 25
#9
ord --wallet ord --chain regtest  --cookie-file /root/btcnet_env/bitcoin/regtest/node1/data/regtest/.cookie --data-dir ./ wallet inscribe --file ./ord.md --fee-rate 25
```