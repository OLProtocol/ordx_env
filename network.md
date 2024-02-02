现状:
192.168.1.117
size:984G  used:750G  avail:184G
633G    /data/bitcoinData/main
38G     /data/bitcoinData/testnet3
13G     /data/ordData/0.13.1/testnet3
63G     /data/electorsData/testnet

192.168.1.101
size:1.5T  used:799G  avail:627G
51G     /btcdata/ord/data/0.13.1/mainnet
156G    /btcdata/ord/data/0.15.0/mainnet
11G     /btcdata/test/olp/olpindex/modules/main_index/orddata/testnet3
155G    /btcdata/mainnet/olpindex/modules/main_index/orddata/index.redb
64G     /var/lib/postgresql/12/main
ord2_mainnet                	8937 kB
ord2_testnet	                10   MB
postgres_metaprotocol_main	    61   GB
postgres_metaprotocol_testnet   1396 MB


规划:
192.168.1.117
size:984G  used:750G  avail:184G
633G    /data/bitcoinData/main
156G    /btcdata/ord/data/0.15.0/mainnet
61G+8934kb    /var/lib/postgresql/12/main
ord2_mainnet                	8937 kB
postgres_metaprotocol_main	    61   GB

1012G     /data/electorsData/main ?

192.168.1.101
size:1.5T  used:?G  avail:?G
155G    /btcdata/mainnet/olpindex/modules/main_index/orddata/index.redb



192.168.1.102
size:?G  used:1133?G  avail:?G
bitcoind25.0-testnet   38G     /data/bitcoinData/testnet3
ord0.13.1-testnet      13G     /data/ordData/0.13.1/testnet3                                     
electrs-testnet        63G     /data/electorsData/testnet
olp-main-index-testnet 11G     /data/testnet/olpindex/modules/main_index/orddata/testnet3
#sql
postgresql12-testnet   915M   /var/lib/postgresql/12/main 
postgres_metaprotocol_testnet  904 MB
ord2_testnet	               11 MB
postgresql12-mainnet   64G     /var/lib/postgresql/12/main 
ord2_mainnet                   8937 kB
postgres_metaprotocol_main	   61   GB


633G    /data/bitcoinData/main
156G    /btcdata/ord/data/0.15.0/mainnet
155G    /btcdata/mainnet/olpindex/modules/main_index/orddata/index.redb

