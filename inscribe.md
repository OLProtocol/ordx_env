```shell
brew install bitcoin

# 
bitcoind -server -datadir=./ -txindex -chain=regtest



#
ord --wallet test --bitcoin-data-dir ./ --chain regtest wallet create
ord --wallet test --bitcoin-data-dir ./ --chain regtest wallet receive
bitcoin-cli -datadir=./ -chain=regtest generatetoaddress 101 bcrt1pywa8lmn2lgtty7jrlu5lnqueqf3zujuueslly9n6hqrldqfsdjhqwuwzku
ord --wallet test --bitcoin-data-dir ./ --chain regtest --data-dir ./ wallet balance
ord --wallet test --bitcoin-data-dir ./ --chain regtest --data-dir ./ wallet transactions
ord --wallet test --bitcoin-data-dir ./ --chain regtest --data-dir ./ wallet inscribe --file ./regtest.md --fee-rate 8

