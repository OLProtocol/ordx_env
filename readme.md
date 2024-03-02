# client
## install Bitcoin Core (MacOS app with UI): Bitcoin-Qt (option)
```shell
wget https://bitcoin.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-apple-darwin.dmg
open ./bitcoin-25.0-x86_64-apple-darwin.dmg
```
## "Open too "too many open files"
### system
cat /proc/sys/fs/file-max
vi /etc/sysctl.conf
# fs.file-max = 400000
sysctl fs.file-max
sysctl -p

# service
# [Service]
# Type=forking
# LimitNOFILE=400000

### user
vi /etc/security/limits.conf
root            hard    nofile          4000000
root            soft    nofile          4000000
vi /lib/systemd/system/postgresql@.service

### session
ulimit -n
ulimit -Hn
ulimit -Sn 400000

## install python3
```shell
brew install python3
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

```shell
# apt install python3.9.2
sudo apt update
sudo apt install python3.9
sudo apt install python3.9-distutils python3.9-venv python3.9-dev python3.9-distutils
sudo update-alternatives --remove-all python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
sudo update-alternatives --list python3
sudo update-alternatives --display python3
sudo update-alternatives --config python3
python3 --version
# pyenv
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc

mv /usr/bin/python2 python2_bak && mv /usr/bin/python3 python3_bak && mv /usr/bin/python python_bak
pyenv install 3.9.2
pyenv local 3.9.2
pyenv global 3.9.2
pyenv versions
python3 get-pip.py


```

## install Sparrow
weg https://github.com/sparrowwallet/sparrow/releases/download/1.8.1/Sparrow-1.8.1-x86_64.dmg
open ./Sparrow-1.8.1-x86_64.dmg

# URL: 192.168.1.106 User/Pass: jacky/123456
open /Applications/Sparrow.app --args -n regtest

## install bitcoin: bitcoind bitcoin-cli bitcoin-tx bitcoin-util bitcoin-wallet 
```shell
brew install bitcoin
brew install redis-cli
# linux
wget -O bitcoin.tar.gz https://bitcoin.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-linux-gnu.tar.gz
tar -xzvf bitcoin.tar.gz -C /usr/local/bin --strip-components 2  bitcoin-25.0/bin/{bitcoin-cli,bitcoind}
```

## redis-cli
```shell
brew install redis-cli
```

## redis-client app: redis desktop client
wget https://github.com/redis/redis/archive/7.2.3.tar.gz
open 7.2.3.tar.gz

## install postgresql in macos
```shell
brew install postgrest
```

## remove postgresql10 in ubuntu18
## https://www.commandprompt.com/education/how-to-uninstall-postgresql-from-ubuntu/
```shell
sudo apt remove postgresql postgresql-contrib
sudo apt autoremove
dpkg -l |grep postgres
sudo apt-get –purge remove postgresql postgresql-10 postgresql-client-common postgresql-common postgresql-contrib
dpkg -l | grep postgres
```

## install postgresql10 in ubuntu18

```shell
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service
sudo systemctl status "postgresql*"
vi /etc/postgresql/12/main/postgresql.conf
listen_addresses = '*'
vi /etc/postgresql/12/main/pg_hba.conf
host    all             all             0.0.0.0/0            md5
sudo -u postgres psql #sudo -i -u postgres
ALTER USER postgres with password 'tinyverse';
\q
vi /etc/postgresql/12/main/pg_hba.conf
local   all             postgres                             password
sudo systemctl restart postgresql.service
psql -h 192.168.1.102 -U postgres -W

vi /etc/postgresql/12/main/postgresql.conf
data_directory = '/data/postgresql/12/main'
sudo chown -R postgres:postgres /data/postgresql/
sudo chmod -R 0750 /data/postgresql/
systemctl restart postgresql

# query db size
SELECT pg_database.datname AS database_name, pg_size_pretty(pg_database_size(pg_database.datname)) AS database_size FROM pg_database;
# backup and restore
pg_dump -U postgres -d ord2_mainnet -f ./sql/ord2_mainnet.sql --create
pg_dump -U postgres -d ord2_testnet -f ./sql/ord2_testnet.sql --create
pg_dump -U postgres -d postgres_metaprotocol_main -f ./sql/postgres_metaprotocol_main.sql --create
pg_dump -U postgres -d postgres_metaprotocol_testnet -f ./sql/postgres_metaprotocol_testnet.sql --create
rsync -avvv --checksum --update root@192.168.1.106:/root/sql ./
psql -U postgres -c "CREATE DATABASE ord2_mainnet WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d ord2_mainnet -f ./sql/ord2_mainnet.sql -W
psql -U postgres -c "CREATE DATABASE ord2_testnet WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d ord2_testnet -f ./sql/ord2_testnet.sql -W
psql -U postgres -c "CREATE DATABASE postgres_metaprotocol_main WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d postgres_metaprotocol_main -f ./sql/postgres_metaprotocol_main.sql
psql -U postgres -c "CREATE DATABASE postgres_metaprotocol_testnet WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8'"
psql -U postgres -d postgres_metaprotocol_testnet -f ./sql/postgres_metaprotocol_testnet.sql

# mount 200g to /data
mkdir -p /data/postgresql/postgresql1/12/main
cp -r /var/lib/postgresql/12/main to /data/postgresql/postgresql1/12/main
sudo chown -R postgres /data/postgresql
sudo chmod -R 0700 /data/postgresql/postgresql1/
vi /etc/postgresql/12/main/postgresql.conf
# data_directory = '/data/postgresql/postgresql1/12/main'
sudo systemctl restart postgresql.service
```

## virtual box for add space
## add vitual disk in virtual box
```shell
sudo fdisk -l
fdisk /dev/sdb #n,p,1
sudo mkfs.ext4 /dev/sdb
sudo mkdir /data
sudo mount -t ext4 /dev/sdb /data
df -h
vim /etc/fstab # add: /dev/sdb /data ext4 errors=remount-ro 0 1
reboot
```

## install redis
sudo apt install redis redis-client


## virtual box
```shell
sudo apt-get install virtualbox-guest-utils
```


## log bitcoind
```shell
tail -f /media/sf_bitcoin/testnet3/debug.log
tail -f /media/sf_bitcoin/main/debug.log
```

## remote channel for deml
## https://medium.com/botfuel/how-to-expose-a-local-development-server-to-the-internet-c31532d741cc
```shell
# server
ulimit -n 65535
vi /etc/ssh/sshd_config
AllowTcpForwarding yes
GatewayPorts yes
MaxSessions 10000
MaxStartups 100:30:100
sudo service ssh restart
# client
ssh -nN -R remotePort:localIp:localPort user@remoteIp
sudo apt install autossh
apt install autossh
autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -nN -R remotePort:localIp:localPort user@remoteIp
autossh -M 0 -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -fN -R remotePort:localIp:localPort user@remoteIp
# forward remote ssh login
autossh -M 20010 -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -CN -R 8020:root@192.168.1.102:22 root@103.103.245.177
ssh -J root@103.103.245.177:8020 root@192.168.1.102
# test
while true;do curl http://x.x.x.x:x/{path/} -H 'Accept: application/json' ;sleep 10;done
```

```shell
# electrs
# /data/btcnet_env/electors/target/release/electrs -vvvv --db-dir /data/electorsData --daemon-dir ./bitcoin/testnet -network testnet --cors "*"

# /data/btcnet_env/electors/target/release/electrs -vvvv --utxos-limit 5000 --electrum-txs-limit 5000 --db-dir /data/electorsData --daemon-rpc-addr "192.168.1.100:38443" --http-addr 0.0.0.0:3002 --network testnet --cors "*"

/data/btcnet_env/electors/target/release/electrs -vvvv --cookie jacky:123456 --db-dir /data/electorsData --daemon-dir /media/sf_bitcoin/ --daemon-rpc-addr "192.168.1.100:38443" --network testnet --cors "*" --utxos-limit 5000 --electrum-txs-limit 5000 --electrum-rpc-addr "0.0.0.0:60001" --http-addr "0.0.0.0:3002" --log-filters = "INFO"
```

# tmux
```shell
apt remove tmux
sudo apt update && sudo apt install libncurses5-dev libevent-dev build-essential
git clone git@github.com:tmux/tmux.git
cd tmux && git checkout 3.3
./configure && make && sudo make install
```

# rvm && ruby3.0 && gem && tmuxinator
```shell
curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm -v
rvm list
rvm use default --default 
gem -v
gem install tmuxinator
```

## autossh 
apt install autossh

# golang
curl -sSL https://git.io/g-install | sh -s

# monitor ssh
```shell
#!/bin/bash

set -x
while true; do
    if ! pgrep -f "autossh -M 20010" >/dev/null; then
        echo "Starting new process..."
        COMMAND_TO_MONITOR=`autossh -M 20010 -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -CN -R 8020:192.168.1.101:22 root@103.103.245.177`
    else
        echo "autossh -M 20010 is already running with PID: $(pgrep -f "autossh -M 20010")"
    fi
    sleep 1
done

# client for family
ssh -J root@103.103.245.177:8020 root@192.168.1.117
ssh -J root@103.103.245.177:8020 root@192.168.1.102
ssh -J root@103.103.245.177:8020 root@192.168.1.101
```

# reduce disk space for linux
sudo parted /dev/sdb
print
resizepart 1 yes 100%

sudo lsblk
sudo resize2fs /dev/sdb
df -h

# reduce disk space for linux lvm
df -lh
sudo lvreduce -L 100G /dev/ubuntu-vg/ubuntu-lv
sudo vgdisplay
sudo lvdisplay
es2sck -f /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv