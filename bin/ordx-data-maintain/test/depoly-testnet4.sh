#!/bin/bash

# reset testnet4 ordx for test
supervisorctl stop ordx-testnet4
rm -rf /data/ordx-data/testnet4/*
cd /data/github/ordx-testnet && git pull && go build -o ordx-testnet
supervisorctl start ordx-testnet4

# reset latest testnet4 ordx for prd master
ssh root@192.168.1.101 supervisorctl stop ordx-testnet4-master
ssh root@192.168.1.101 rm -rf /data/ordx-data/testnet4-master/*
scp /data/github/ordx-testnet/ordx-testnet root@192.168.1.101:/usr/bin/ordx-testnet4-master
ssh root@192.168.1.101 supervisorctl start ordx-testnet4-master

# reset latest testnet4 ordx for prd slave
ssh root@192.168.1.101 supervisorctl stop ordx-testnet4-slave
ssh root@192.168.1.101 rm -rf /data/ordx-data/testnet4-slave/*
scp /data/github/ordx-testnet/ordx-testnet root@192.168.1.101:/usr/bin/ordx-testnet4-slave
ssh root@192.168.1.101 supervisorctl start ordx-testnet4-slave
