```shell
1 build latest ordx server
~/ordx/bin/ordx-data-maintain/build.sh -s /data1/github/ordx-rundata -p
# ~/ordx/bin/ordx-data-maintain/build.sh -s /data1/github/ordx-rundata

2 restore ordx basic index data:
~/ordx/bin/ordx-data-maintain/b2r.sh -m recover -c testnet -i basic -d /data/ordx-data -b /data/ordx-data-backup -o ordx
#~/ordx/bin/ordx-data-maintain/b2r.sh -m recover -c testnet -i basic -d /data/ordx-data -b /data/ordx-data-backup -o latest
#~/ordx/bin/ordx-data-maintain/b2r.sh -m recover -c testnet -i ord -d /data/ordx-data -b /data/ordx-data-backup -o latest
#~/ordx/bin/ordx-data-maintain/b2r.sh -m recover -c mainnet -i basic -d /data/ordx-data -b /data/ordx-data-backup -o latest

3 run ordx basic index data
~/ordx/bin/ordx-data-maintain/run.sh -c ~/ordx/bin/ordx-data-maintain/run-testnet.env -d ord -o latest
#~/ordx/bin/ordx-data-maintain/run.sh -c ~/ordx/bin/ordx-data-maintain/run-testnet.env -d basic -o latest
#~/ordx/bin/ordx-data-maintain/run.sh -c ~/ordx/bin/ordx-data-maintain/run-mainnet.env -d ord -o ord
#~/ordx/bin/ordx-data-maintain/run.sh -c ~/ordx/bin/ordx-data-maintain/run-mainnet.env -d ord -o latest

4 dbgc ordx basic index db 
~/ordx/bin/ordx-data-maintain/dbgc.sh -d /data/ordx-data/testnet/basic

5 backup ordx basic index data
~/ordx/bin/ordx-data-maintain/b2r.sh -m backup -c testnet -i basic -d /data/ordx-data -b /data/ordx-data-backup -o latest
#~/ordx/bin/ordx-data-maintain/b2r.sh -m backup -c testnet -i basic -d /data/ordx-data -b /data/ordx-data-backup -o ordx
#~/ordx/bin/ordx-data-maintain/b2r.sh -m backup -c testnet -i ord -d /data/ordx-data -b /data/ordx-data-backup -o latest
#~/ordx/bin/ordx-data-maintain/b2r.sh -m backup -c mainnet -i basic -d /data/ordx-data -b /data/ordx-data-backup -o latest
#~/ordx/bin/ordx-data-maintain/b2r.sh -m backup -c mainnet -i basic -d /data/ordx-data -b /data/ordx-data-backup -o ord

6 sync ordx basic index data:
~/ordx/bin/ordx-data-maintain/sync.sh -c testnet -o latest -i basic -l /data/ordx-data-backup -r /data/ordx-data-backup \
    -p root@192.168.1.101 -a 10000 -t root@192.168.1.102 -a 22
~/ordx/bin/ordx-data-maintain/sync.sh -c testnet -i basic -o latest -l /data/ordx-data-backup -r /data/ordx-data-backup \
    -t root@192.168.1.102 -a 22
~/ordx/bin/ordx-data-maintain/sync.sh -c testnet -i ord -l /data/ordx-data-backup -r /data/ordx-data-backup \
    -t root@192.168.1.102 -a 22

7 diagnosis ordx basic index data
~/ordx/bin/ordx-data-maintain/diagnosis.sh -c ~/ordx/bin/ordx-data-maintain/run-testnet.env -d /data/ordx-data -s 0 -o ord
~/ordx/bin/ordx-data-maintain/diagnosis.sh -c ~/ordx/bin/ordx-data-maintain/run-testnet.env -d /data/ordx-data -s 0 -o ordx
~/ordx/bin/ordx-data-maintain/diagnosis.sh -c ~/ordx/bin/ordx-data-maintain/run-mainnet.env -d /data/ordx-data \
-s 0 -o latest -b /data/ordx-data-backup 

```