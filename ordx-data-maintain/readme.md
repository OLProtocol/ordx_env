1 build lastest ordx server
~/ordx-data-maintain/build.sh -s /data1/github/ordx-rundata -p
# ~/ordx-data-maintain/build.sh -s /data1/github/ordx-rundata

2 restore ordx basic index data:
~/ordx-data-maintain/b2r.sh -m recover -c testnet -i basic -d /data2/ordxData -b /data2/ordxData-backup -o ordx
#~/ordx-data-maintain/b2r.sh -m recover -c testnet -i basic -d /data2/ordxData -b /data2/ordxData-backup -o lastest
#~/ordx-data-maintain/b2r.sh -m recover -c testnet -i ord -d /data2/ordxData -b /data2/ordxData-backup -o lastest

3 run ordx basic index data
~/ordx-data-maintain/run.sh -c "~/ordx-data-maintain/run-testnet.env" -d ord -o lastest
#~/ordx-data-maintain/run.sh -c "~/ordx-data-maintain/run-mainnet.env" -d ord -o ord
#~/ordx-data-maintain/run.sh -c "~/ordx-data-maintain/run-mainnet.env" -d ord -o lastest

4 backup ordx basic index data
~/ordx-data-maintain/b2r.sh -m backup -c testnet -i basic -d /data2/ordxData -b /data2/ordxData-backup -o lastest
#~/ordx-data-maintain/b2r.sh -m backup -c testnet -i basic -d /data2/ordxData -b /data2/ordxData-backup -o ordx
#~/ordx-data-maintain/b2r.sh -m backup -c testnet -i ord -d /data2/ordxData -b /data2/ordxData-backup

5 sync ordx basic index data:
~/ordx-data-maintain/sync.sh -c testnet -o lastest -i basic -l /data2/ordxData-backup -r /data/ordxData-backup \
    -p root@192.168.1.101 -a 10000 -t root@192.168.1.102 -a 22
~/ordx-data-maintain/sync.sh -c testnet -i basic -o lastest -l /data2/ordxData-backup -r /data/ordxData-backup \
    -t root@192.168.1.102 -a 22
~/ordx-data-maintain/sync.sh -c testnet -i ord -l /data2/ordxData-backup -r /data/ordxData-backup \
    -t root@192.168.1.102 -a 22