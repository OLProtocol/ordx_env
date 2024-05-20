```shell
# lsof
lsof -n | awk '{print $1, $2}' | grep -v '^COMMAND PID' | sort | uniq -c | sort -nr | head -n 1
# scp
scp -P 2222 your_file.txt username@remote_host:/remote/directory
scp -r root@192.168.1.103:/data1/github/ordx/ ~/Desktop
# rsync
rsync -avv --delete --update --progress --delete root@192.168.1.103:/data2/ordx-data-backup/ord-lastest  /Volumes/backup
# trzsz
trzsz ssh root@192.168.1.106
trzsz -d ssh root@192.168.1.101
trzsz ssh -t root@192.168.1.101
# tsz
tsz ./user.keystore
# find
find . -name 'Bitcoin-FullNodeData-March-16th-2024.7z.*' -exec shasum -a 256 {} \;
find /data/ordx-data/testnet/basic /data/ordx-data/testnet/ordx -mindepth 1 -delete
# shasum
shasum -a 256 ./Bitcoin-FullNodeData-March-16th-2024.7z.002
# du
du -ah --max-depth=1 /data2
# tar
sudo tar czf /backup.tar.gz --exclude=/backup.tar.gz
sudo tar -czvf ldb ldb.gz
# dd
dd if=/dev/urandom of=random-file bs=1k  count=1
# jq
apt-get install jq
jq config.json
jq empty your_file.json >/dev/null || jq -n 'inputs | [path(..)|tostring] | unique | .[]' ./config.json
# diff
diff config.json config1.json
# ln
sudo ln -s /snap/bin/certbot /usr/bin/certbot
# history
history | grep ipfs

# search and show the line number of the string
grep -no "\{\"height\":826230" /data2/ordx-data-backup/ord-latest/mainnet-all-inscription-data.ordx | cut -d: -f1
# print the line number of the string
sed -n '51030p' /data2/ordx-data-backup/ord-latest/mainnet-all-inscription-data.ordx
# delete the string
sed -i '51032d' /data2/ordx-data-backup/ord-latest/mainnet-all-inscription-data.ordx
# replace the string
sed -i '51032r test2.out' /data2/ordx-data-backup/ord-latest/mainnet-all-inscription-data.ordx
# search and replace the string
sed -i 's/git:/https:/g' .gitmodules
```