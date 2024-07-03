#!/bin/bash

# testnet4 ordx for test
echo "deploying(reset) testnet4 ordx data on 192.168.1.102 for test"
supervisorctl stop ordx-testnet4
rm -rf /data/ordx-data/testnet4/*
cd /data/github/ordx-testnet && git pull && go build -o ordx-testnet
supervisorctl start ordx-testnet4

# testnet4 ordx for prd master
echo "deploying(reset)  testnet4 ordx data on 192.168.1.101 for prd master"
ssh root@192.168.1.101 supervisorctl stop ordx-testnet4-master
ssh root@192.168.1.101 rm -rf /data/ordx-data/testnet4-master
ssh root@192.168.1.101 mkdir -p /data/ordx-data/testnet4-master
scp /data/github/ordx-testnet/ordx-testnet root@192.168.1.101:/usr/bin/ordx-testnet4-master
ssh root@192.168.1.101 supervisorctl start ordx-testnet4-master

# testnet4 ordx for prd slave
echo "deploying(reset) testnet4 ordx data on 192.168.1.101 for prd slave"
ssh root@192.168.1.101 supervisorctl stop ordx-testnet4-slave
ssh root@192.168.1.101 rm -rf /data/ordx-data/testnet4-slave
ssh root@192.168.1.101 mkdir -p /data/ordx-data/testnet4-slave
scp /data/github/ordx-testnet/ordx-testnet root@192.168.1.101:/usr/bin/ordx-testnet4-slave
ssh root@192.168.1.101 supervisorctl start ordx-testnet4-slave
