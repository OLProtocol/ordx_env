#!/bin/bash
# backup latest mainnet ordx data for test
echo "backup latest mainnet ordx data for test for 192.168.1.103"
rm -rf /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2
scp -r root@192.168.1.103:/data2/ordx-data-backup/mainnet/mainnet-849000-1.1.2 /data/ordx-data-backup/mainnet/

# resume latest mainnet ordx for test
echo "resume latest mainnet ordx for test for 192.168.1.102"
supervisorctl stop ordx-mainnet
rm -rf /data/ordx-data/mainnet/*
cpg -gR /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* /data/ordx-data/mainnet/
cd /data/github/ordx && git pull && go build -o ordx-mainnet
supervisorctl start ordx-mainnet

# backup latest mainnet ordx data for prd
echo "backup latest mainnet ordx data for prd for 192.168.1.101"
ssh root@192.168.1.101 rm -rf /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2
scp -r /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2 root@192.168.1.101:/data/ordx-data-backup/mainnet/

# resume latest mainnet ordx for prd master
echo "resume latest mainnet ordx(data and program) for prd master for 192.168.1.101"
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-master
ssh root@192.168.1.101 rm -rf /data/ordx-data/mainnet-master
ssh root@192.168.1.101 mkdir -p /data/ordx-data/mainnet-master
ssh root@192.168.1.101 cpg -gR /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* /data/ordx-data/mainnet-master/
scp /data/github/ordx/ordx-mainnet root@192.168.1.101:/usr/bin/ordx-mainnet-master
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-master

# resume latest mainnet ordx for prd slave
echo "resume latest mainnet ordx(data and program) for prd slave for 192.168.1.101"
ssh root@192.168.1.101 supervisorctl stop ordx-mainnet-slave
ssh root@192.168.1.101 rm -rf /data/ordx-data/mainnet-slave
ssh root@192.168.1.101 mkdir -p /data/ordx-data/mainnet-slave
ssh root@192.168.1.101 cpg -gR /data/ordx-data-backup/mainnet/mainnet-849000-1.1.2/* /data/ordx-data/mainnet-slave/
scp /data/github/ordx/ordx-mainnet root@192.168.1.101:/usr/bin/ordx-mainnet-slave
ssh root@192.168.1.101 supervisorctl start ordx-mainnet-slave
