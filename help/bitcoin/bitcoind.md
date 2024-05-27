# main
bitcoind -rpcworkqueue=512 -rpcthreads=128 -chain=main \
-conf=/data/bitcoin-data/bitcoin.conf -datadir=/data/bitcoin-data/main
tail -f -n 30 /data/bitcoin-data/main/debug.log

# testnet
bitcoind -rpcworkqueue=512 -rpcthreads=128 -chain=test \
-conf=/data/bitcoin-data/bitcoin.conf -datadir=/data/bitcoin-data
tail -f -n 30 /data/bitcoin-data/testnet3/debug.log

# testnet4
bitcoind-testnet4 -rpcworkqueue=512 -rpcthreads=128 -chain=testnet4 \
-conf=/data/bitcoin-data/bitcoin.conf -datadir=/data/bitcoin-data
tail -f -n 30 /data/bitcoin-data/testnet4/debug.log

# mac
diskutil list
du -h -d 1 ../db/testnet-ord
pbcopy < ~/.ssh/id_rsa.pub
sudo brew services info bitcoin
sudo brew services stop bitcoin
sudo rm -rf  /Library/Application\ Support/Bitcoin
