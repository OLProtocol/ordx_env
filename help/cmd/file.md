```shell
# lsof
lsof -n | awk '{print $1, $2}' | grep -v '^COMMAND PID' | sort | uniq -c | sort -nr | head -n 1
# scp
scp -P 2222 your_file.txt username@remote_host:/remote/directory
scp -r root@192.168.1.103:/data1/github/ordx/ ~/Desktop
# rsync
rsync -avv --delete --update --progress --delete root@192.168.1.103:/data2/ordxData-backup/ord-lastest  /Volumes/backup
# trzsz
trzsz ssh root@192.168.1.106
trzsz -d ssh root@192.168.1.101
trzsz ssh -t root@192.168.1.101
# tsz
tsz ./user.keystore
# find
find . -name 'Bitcoin-FullNodeData-March-16th-2024.7z.*' -exec shasum -a 256 {} \;
find /data/ordxData/testnet/basic /data/ordxData/testnet/ordx -mindepth 1 -delete
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
```