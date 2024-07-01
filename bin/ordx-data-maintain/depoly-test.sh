#!/bin/bash
# resesum latest ordx data for test
rm -rf /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2
scp -r root@192.168.1.103:/data2/ordx-data-backup/mainnet/mainnet-849000-1.1.2 /data/ordx-data-backup/mainnet/
supervisorctl stop ordx-mainnet
rm -rf /data/ordx-data/mainnet/*
cpg -gR /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* /data/ordx-data/mainnet/
supervisorctl start ordx-mainnet

# backup latest ordx for test
ssh root@192.168.1.101 rm -rf /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2

# backup latest ordx for prd
scp -r /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* root@192.168.1.101:/data/ordx-data-backup/mainnet/

# resume latest ordx data for prd master
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-master
ssh root@192.168.1.101 cp -r /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* root@192.168.1.101:/data/ordx-data/mainnet-master/
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-master

# resume latest ordx data for test slave
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-slave
ssh root@192.168.1.101 cp -r /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* root@192.168.1.101:/data/ordx-data/mainnet-slave/
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-slave
