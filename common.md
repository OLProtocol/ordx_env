killall ordx-server
pgrep ordx-server
ps -p {pid}
ps -p {pid} -o lstart
top -p `pidof ordx-server-checkself`
top -p {pid,pid}
ls -l /proc/<PID>/exe
tail -f /proc/{pid}/fd/1

rsync -avv --delete --update --progress --delete root@192.168.1.103:/data2/ordxData-backup/ord-lastest  /Volumes/backup
scp -r root@192.168.1.103:/data1/github/ordx/ ~/Desktop
tsz ./user.keystore
trzsz ssh root@192.168.1.106
trzsz -d ssh root@192.168.1.101
trzsz ssh -t root@192.168.1.101

ssh root@192.168.1.103 -t tmux new -Asordx
ssh -p 10000 root@192.168.1.101
ssh-copy-id  root@103.103.245.177
ssh-copy-id -p 8020 root@103.103.245.177
ssh -J root@103.103.245.177:8020 root@192.168.1.103
ssh-keygen -R 192.168.1.106
ssh-keygen -t rsa -b 4096 -C "softwarecheng@126.com"
ssh-keygen -R root@192.168.1.106
ssh -T git@github.com
ssh -vT git@github.com

git add . && git commit -m "fix" && git push
git push -u origin main
git remote add origin git@github.com:tinyverse-web3/tvsconnect.git
git remote get-url origin
git fetch --all
git remote -v
git reset --hard 449da4b21ecbd17c991a5523e9235371bc977277^
git log -n 1 --pretty=format:%H

protoc-gen-go --version
protoc --go_out=. ./ordinals/indexer/pb/*.proto
protoc --go_out=paths=source_relative:. ./ordx/indexer/pb/*.proto

shasum -a 256 /Volumes/backup/2024-03-16/Bitcoin-FullNodeData-March-16th-2024.7z.002
find . -name 'Bitcoin-FullNodeData-March-16th-2024.7z.*' -exec shasum -a 256 {} \;

nc -z 192.168.1.102 5432
curl -H "Accept: application/json" https://apitest.ordx.space/testnet/bestheight
curl -X POST -d '{"utxos":"umc8wucmk599j3aklgaqw54zfq"}'  http://192.168.1.102:8007/testnet-go/testnet/utxo-ranges
netstat -ano | findstr :22
netstat -ano | grep 22
netstat -ano | grep :22
telnet 192.168.1.100 38443
lsof -i :5000

# mac
diskutil list
du -h -d 1 ../db/testnet-ord
pbcopy < ~/.ssh/id_rsa.pub
sudo brew services info bitcoin
sudo brew services stop bitcoin
sudo rm -rf  /Library/Application\ Support/Bitcoin


# sql
psql -h 192.168.1.101 -d ord2_mainnet -U postgres -c "SELECT * from ord2_event_types;"

# python
pyenv shell 3.9.2

# docker
docker exec -it 1826dd921684578026c350f70b34873ae6f1f42aa4c97b5c1a04bf7cb8548cd5 bash
docker run -it homebrew/ubuntu18.04 bash 
docker pull homebrew/ubuntu18.04

# licii

lncli unlock
lnd --configfile=/Users/chenwenjie/test/lnd/lnd.conf --lnddir=/Users/chenwenjie/test/lnd/data
openssl x509 -noout -text -in tls.cert | grep DNS:
lncli -lnddir=/Users/chenwenjie/test/lnd/data create
lncli -lnddir=/Users/chenwenjie/.lit/lnddata/ create
litd --configfile=~/.lit/lit.conf
lncli -lnddir=/Users/chenwenjie/.lit/lnddata/ unlock
lncli create

#panic
vim /etc/rsyslog.d/50-default.conf
 33 # Some "catch-all" log files.
 34 #
 35 #*.=debug;\
 36 #       auth,authpriv.none;\
 37 #       news.none;mail.none     -/var/log/debug
 38 #*.=info;*.=notice;*.=warn;\
 39 #       auth,authpriv.none;\
 40 #       cron,daemon.none;\
 41 #       mail,news.none          -/var/log/messages
systemctl restart rsyslog.service

grep "memory" /var/log/messages
egrep -i 'killed process' /var/log/messages
egrep -i -r "killed process" /var/log
journalctl -xb | egrep -i 'killed process'
dmesg | egrep -i -B100 'killed process'
