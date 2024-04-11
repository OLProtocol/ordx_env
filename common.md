systemctl list-timers
date -R|awk '{printf"%d",$6}'
ulimit -n
ulimit -n 65535
sudo ln -s /snap/bin/certbot /usr/bin/certbot
killall ordx-server
pkill -e tvbot
kill -2 {pid} // SIGINT ctrl-c
kill {pid} // SIGTERM  == kill -15 pid
pgrep ordx-server
ps -p {pid}
ps -p {pid} -o lstart
top -p `pidof ordx-server-checkself`
top -p {pid,pid}
ls -l /proc/<PID>/exe
tail -f /proc/{pid}/fd/1
nohup ./server 2>&1 &
crontab -e
substr $(uname -s)
history | grep ipfs
vmstat 1
dd if=/dev/urandom of=random-file bs=1k  count=1
lsb_release -a



certbot renew > /root/log/cron-certbot.log 2>&1
certbot renew --dry-run > /root/log/cron-certbot.log 2>&1
certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini -d ordx.space -d *.ordx.space -i nginx
certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini -d *.ordx.space -i nginx
sudo certbot delete --cert-name ordx.space
sudo certbot certificates
sudo certbot delete --cert-name api.ordx.space

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
git fetch
git fetch --all
git remote -v
git reset --hard HEAD
git reset --hard 449da4b21ecbd17c991a5523e9235371bc977277^
git log -n 1 --pretty=format:%H
git log -n 1 --pretty=format:%H
git config --global user.email "softwarecheng@126.com"
git config --global user.name "jackychen"

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

# golang
export GOOS=linux
export GOARCH=amd64
go build 

# install linux
sudo su
passwd
sudo nano /etc/ssh/sshd_config
PermitRootLogin yes
sudo systemctl reload sshd

ip addr show | grep inet | awk '{ print $2; }' \
ip addr show | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'\
diff config.json config1.json
apt-get install jq
jq config.json
jq empty your_file.json >/dev/null || jq -n 'inputs | [path(..)|tostring] | unique | .[]' ./config.json
sysctl -w net.core.rmem_max=2500000
ps -aux | grep
ps -ef | grep
tar -czvf ldb ldb.gz
tar -czvf  ldb.gz ldb_data
apt-get install sshpass
source ~/.zshrc
chmod +x ./install.sh
sudo systemctl enable ipfs
sudo systemctl start ipfs
service ipfs status

ipfs ipfs pin ls --type recursive QmeiFkJgYhvH2oPe9EpiQ6maUzHJkVMs8R7sDyFjTuLij6
ipfs pin ls --type recursive QmeiFkJgYhvH2oPe9EpiQ6maUzHJkVMs8R7sDyFjTuLij6
ipfs cat QmeiFkJgYhvH2oPe9EpiQ6maUzHJkVMs8R7sDyFjTuLij6
ipfs cat 12D3KooWC49xPG3wryaCvYVo4Nc1vRcMcMv4BskcRxE6arDP77f8  --cid-version 1
ipfs add --pin=false ./QmXjWqTfzPZtvcq6dY3XFtukzSqt63tQ6wvxbebKr5dzrC
ipfs object links QmYwUTHmdDzHKFY9o68W7VrPqcCzr72RVdnNpHYw5yBrtU
ipfs block get QmaxC5QYd6iaugwm6knbvY7BB3uUbiXJ1h1s5XR1XrVMmB
ipfs add ./random-file
ipfs routing findprovs QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs dht provide QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs routing findprovs QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs cid format -v 1 -b base32 QmZsRP7e6o1EaQsNYVMsviPEphmDviNU4gT6fk4NwMcT9p
ipfs pin remote add --service=nftstorage --name=test  QmdGryWJdj2pDYKNJh59cQJjaQ3Eddn8sfCVoCXS4Y639Y
ipfs pin remote ls --service=nftstorage
ipfs pin remote service rm ntfstorage4
ipfs add random-file --cid-version 1
ipfs pin remote ls --service=nftstorage4
ipfs get QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs swarm addrs listen
ipfs swarm peering ls
ipfs stats repo
ipfs swarm peers
ipfs swarm peers --identify
ipfs pubsub peers
ipfs p2p stream ls
ipfs refs local
ipfs stats bitswap
ipfs stats dht | grep QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs stats provide
ipfs repo stat
ipfs swarm connect QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ
ipfs swarm connect /ip4/104.131.131.82/tcp/4001/p2p/QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://103.103.245.177:5001", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
ipfs repo gc



sudo add-apt-repository ppa:deadsnakes/ppa
ssh-keygen -t rsa -b 4096 -C "dev@tinyverse.space"
git submodule update --init
sysctl fs.file-max
sudo vi /etc/sysctl.conf
ulimit -Hn
ulimit -Sn 400000
sudo vi /etc/security/limits.conf
sudo tar czf /backup.tar.gz --exclude=/backup.tar.gz
find . -name 'Bitcoin-FullNodeData-March-16th-2024.7z.*' -exec shasum -a 256 {} \;
find /data/ordxData/testnet/basic /data/ordxData/testnet/ordx -mindepth 1 -delete
shasum -a 256 ./Bitcoin-FullNodeData-March-16th-2024.7z.002
du -ah --max-depth=1 /data2
ip -6 addr show
lsof -n | awk '{print $1, $2}' | grep -v '^COMMAND PID' | sort | uniq -c | sort -nr | head -n 1
autossh -M 20000 -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -nN -R 8002:127.0.0.1:22 root@103.103.245.177

根据进程名终止进程:
终止名为myapp的所有进程: pkill myapp
终止包含nginx关键字的所有进程: pkill -f nginx
根据用户名终止进程:
终止特定用户（例如john）的所有进程: pkill -u john
根据命令行参数终止进程:
终止带有特定命令行参数的进程: pkill -f "python script.py"
根据进程组终止进程:
终止特定进程组的所有进程: pkill -g 1234
交互式询问终止进程:
交互式地询问是否终止进程: pkill -i process_name
根据信号终止进程:
使用不同的信号终止进程（默认是SIGTERM）: pkill -9 process_name（使用SIGKILL信号）
根据进程启动的时间终止进程:
终止在最近5分钟内启动的所有进程: pkill -U john -n -m 5m

scp -P 2222 your_file.txt username@remote_host:/remote/directory
systemctl list-units --type=service --state=running

sudo iftop -i eth0 -f "port 443"
sudo nethogs eth0
sudo nethogs eth0 -d 5
sudo nethogs -t | grep sshd
sudo nethogs -t | grep nginx
ab -n 1000 -c 100 https://apiprd.ordx.space/mainnet/health
ab -n 1000 -c 100 https://apiprd.ordx.space/mainnet/status


lsblk
mdadm --stop /dev/md126
mdadm --stop /dev/md127
mdadm --remove /dev/md126和mdadm --remove /dev/md127
mdadm --zero-superblock /dev/sda

timedatectl
timedatectl list-timezones
timedatectl set-timezone Asia/Hong_Kong

# sshd
X11Forwarding no
Ciphers aes128-ctr,aes192-ctr,aes256-ctr
KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
PermitUserEnvironment no
ClientAliveInterval 300
ClientAliveCountMax 3
MaxStartups 20:30:100
MaxSessions 50