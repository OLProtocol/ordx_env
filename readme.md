
```shell
## install
bin/install/daemon.sh
bin/install/autossh.sh
bin/install/bitcond.sh
bin/install/golang.sh
bin/install/mole.sh
bin/install/rust.sh
bin/install/ord.sh
bin/install/tmux.sh
bin/install/tmuxinator.sh
bin/install/supervisor.sh

## config
# tmux
cp ../cmd/tmux/tmux.conf ~/.tmux.conf
cp -r ../cmd/tmux/.tmux ~/.tmux

# tmuxinator
cp -r ../cmd/tmuxinator/.config/tmuxinator/ordx.yml ~/.config/tmuxinator/ordx.yml
vi ~/.config/tmuxinator/ordx.yml

# supervisord
cp ../cmd/supervisor/conf/supervisord.conf /etc/supervisor/supervisord.conf
vi /etc/supervisor/supervisord.conf
cp ../cmd/supervisor/conf/ordx.ini /etc/supervisor/conf.d/ordx.ini
vi /etc/supervisor/conf.d/ordx.ini

# ordx
cp ./etc/ordx /etc/ordx

## program
# install maintain script
cp -r ../../bin/daemon ~/
cp -r ../../bin/ordx-data-maintain ~/

## install ordx
mkdir -p /data/github 
cd /data/github && git clone https://github.com/OLProtocol/ordx.git && cd ordx
export GOOS=linux
export GOARCH=amd64
export CGO_ENABLED=0
go build -o /usr/local/bin/ordx-server
cp root@192.168.1.103:/data2/ordxData-backup /data/

## data
# bitcoin data
mkdir -p /data/bitcoinData/main /data/bitcoinData/testnet3
scp root@192.168.1.103:/data2/bitcoin-backup/bitcoin.conf /data/bitcoinData/
scp -r root@192.168.1.103:/data2/bitcoin-backup/main/20240321/ /data/bitcoinData/main/
scp -r root@192.168.1.103:/data2/bitcoin-backup/testnet3/20240321/ /data/bitcoinData/testnet3/

# ord data
mkdir -p /data/ord-data
scp -r root@192.168.1.103:/data2/ord-data-backup/main /data/ord-data/
scp -r root@192.168.1.103:/data2/ord-data-backup/testnet3 /data/ord-data/

# ordx data
mkdir -p /data/ordx-data
scp -r root@192.168.1.103:/data2/ordx-data-backup /data/
~/bin/ordx-data-maintain/b2r.sh -m recover -c testnet -i all -d /data/ordx-data -b /data/ordx-data-backup -o latest
~/bin/ordx-data-maintain/b2r.sh -m recover -c mainnet -i all -d /data/ordx-data -b /data/ordx-data-backup -o latest
```