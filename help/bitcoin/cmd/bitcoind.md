# main
bitcoind -rpcworkqueue=512 -rpcthreads=128 -chain=main \
-conf=/data/bitcoinData/bitcoin.conf -datadir=/data/bitcoinData/main
tail -f -n 30 /data/bitcoinData/main/debug.log

# testnet
bitcoind -rpcworkqueue=512 -rpcthreads=128 -chain=test \
-conf=/data/bitcoinData/bitcoin.conf -datadir=/data/bitcoinData
tail -f -n 30 /data/bitcoinData/testnet3/debug.log


# mac
diskutil list
du -h -d 1 ../db/testnet-ord
pbcopy < ~/.ssh/id_rsa.pub
sudo brew services info bitcoin
sudo brew services stop bitcoin
sudo rm -rf  /Library/Application\ Support/Bitcoin
