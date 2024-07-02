#!/bin/bash

# resume latest mainnet ordx for test
supervisorctl stop ordx-mainnet
cd /data/github/ordx && git pull && go build -o ordx-mainnet
supervisorctl start ordx-mainnet

# resume latest mainnet ordx for prd master
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-master
scp /data/github/ordx/ordx-mainnet root@192.168.1.101:/usr/bin/ordx-mainnet-master
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-master

# resume latest mainnet ordx for prd slave
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-slave
scp /data/github/ordx/ordx-mainnet root@192.168.1.101:/usr/bin/ordx-mainnet-slave
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-slave
