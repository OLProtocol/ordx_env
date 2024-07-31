#!/bin/bash

# testnet4 ordx for test
echo "deploying testnet4 on 192.168.10.102 for test"
supervisorctl stop ordx-testnet4
cd /data/github/ordx-testnet && git pull && go build -o ordx-testnet
supervisorctl start ordx-testnet4

# testnet4 ordx for prd master
echo "deploying testnet4 on 192.168.10.101 for prd master"
ssh root@192.168.10.101 supervisorctl stop ordx-testnet4-master
scp /data/github/ordx-testnet/ordx-testnet root@192.168.10.101:/usr/bin/ordx-testnet4-master
ssh root@192.168.10.101 supervisorctl start ordx-testnet4-master

# testnet4 ordx for prd slave
echo "deploying testnet4 on 192.168.10.101 for prd slave"
ssh root@192.168.10.101 supervisorctl stop ordx-testnet4-slave
scp /data/github/ordx-testnet/ordx-testnet root@192.168.10.101:/usr/bin/ordx-testnet4-slave
ssh root@192.168.10.101 supervisorctl start ordx-testnet4-slave
