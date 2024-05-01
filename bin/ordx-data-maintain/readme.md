1 build latest ordx server
~/ordx-data-maintain/build.sh -s /data1/github/ordx-rundata -p
# ~/ordx-data-maintain/build.sh -s /data1/github/ordx-rundata

2 restore ordx basic index data:
~/ordx-data-maintain/b2r.sh -m recover -c testnet -i basic -d /data2/ordx-data -b /data2/ordx-data-backup -o ordx
#~/ordx-data-maintain/b2r.sh -m recover -c testnet -i basic -d /data2/ordx-data -b /data2/ordx-data-backup -o latest
#~/ordx-data-maintain/b2r.sh -m recover -c testnet -i ord -d /data2/ordx-data -b /data2/ordx-data-backup -o latest
#~/ordx-data-maintain/b2r.sh -m recover -c mainnet -i basic -d /data2/ordx-data -b /data2/ordx-data-backup -o latest

3 run ordx basic index data
~/ordx-data-maintain/run.sh -c "~/ordx-data-maintain/run-testnet.env" -d ord -o latest
#~/ordx-data-maintain/run.sh -c "~/ordx-data-maintain/run-testnet.env" -d basic -o latest
#~/ordx-data-maintain/run.sh -c "~/ordx-data-maintain/run-mainnet.env" -d ord -o ord
#~/ordx-data-maintain/run.sh -c "~/ordx-data-maintain/run-mainnet.env" -d ord -o latest

4 backup ordx basic index data
~/ordx-data-maintain/b2r.sh -m backup -c testnet -i basic -d /data2/ordx-data -b /data2/ordx-data-backup -o latest
#~/ordx-data-maintain/b2r.sh -m backup -c testnet -i basic -d /data2/ordx-data -b /data2/ordx-data-backup -o ordx
#~/ordx-data-maintain/b2r.sh -m backup -c testnet -i ord -d /data2/ordx-data -b /data2/ordx-data-backup -o latest
#~/ordx-data-maintain/b2r.sh -m backup -c mainnet -i basic -d /data2/ordx-data -b /data2/ordx-data-backup -o latest
#~/ordx-data-maintain/b2r.sh -m backup -c mainnet -i basic -d /data2/ordx-data -b /data2/ordx-data-backup -o ord

5 sync ordx basic index data:
~/ordx-data-maintain/sync.sh -c testnet -o latest -i basic -l /data2/ordx-data-backup -r /data/ordx-data-backup \
    -p root@192.168.1.101 -a 10000 -t root@192.168.1.102 -a 22
~/ordx-data-maintain/sync.sh -c testnet -i basic -o latest -l /data2/ordx-data-backup -r /data/ordx-data-backup \
    -t root@192.168.1.102 -a 22
~/ordx-data-maintain/sync.sh -c testnet -i ord -l /data2/ordx-data-backup -r /data/ordx-data-backup \
    -t root@192.168.1.102 -a 22