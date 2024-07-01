#!/bin/bash
# backup latest mainnet ordx data for test
rm -rf /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2
scp -r root@192.168.1.103:/data2/ordx-data-backup/mainnet/mainnet-849000-1.1.2 /data/ordx-data-backup/mainnet/

# resume latest mainnet ordx data for test
supervisorctl stop ordx-mainnet
rm -rf /data/ordx-data/mainnet/*
cpg -gR /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* /data/ordx-data/mainnet/
cd /data/github/ordx && git pull && go build -o ordx-mainnet
supervisorctl start ordx-mainnet

# backup latest mainnet ordx for prd
ssh root@192.168.1.101 rm -rf /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2
scp -r /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* root@192.168.1.101:/data/ordx-data-backup/mainnet/

# resume latest mainnet ordx data for prd master
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-master
ssh root@192.168.1.101 rm -rf /data/ordx-data/mainnet-master/*
ssh root@192.168.1.101 cpg -gR /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* root@192.168.1.101:/data/ordx-data/mainnet-master/
scp /data/github/ordx/ordx-mainnet root@192.168.1.101:/usr/bin/rdx-testnet4-master
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-master

# resume latest mainnet ordx data for test slave
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-slave
ssh root@192.168.1.101 rm -rf /data/ordx-data/mainnet-slave/*
ssh root@192.168.1.101 cpg -gR /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* root@192.168.1.101:/data/ordx-data/mainnet-slave/
scp /data/github/ordx/ordx-mainnet root@192.168.1.101:/usr/bin/rdx-testnet4-slave
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-slave
