# client
## install Bitcoin Core (MacOS app with UI), as Bitcoin-Qt
```shell
wget https://bitcoin.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-apple-darwin.dmg
open ./bitcoin-25.0-x86_64-apple-darwin.dmg
```

## bitcoin: bitcoind bitcoin-cli bitcoin-tx bitcoin-util bitcoin-wallet 
```shell
brew install bitcoin
brew install redis-cli
```

## redis-cli
```shell
brew install redis-cli
```

## redis-client app: redis desktop client
wget https://github.com/redis/redis/archive/7.2.3.tar.gz
open 7.2.3.tar.gz

```shell
brew install postgrest
```


# server
## bitcoind for regtest
```shell
wget \
  -O bitcoin.tar.gz \
  https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-x86_64-linux-gnu.tar.gz

tar \
  -xzvf bitcoin.tar.gz \
  -C /usr/local/bin \
  --strip-components 2 \
  bitcoin-$version/bin/{bitcoin-cli,bitcoind}

bitcoind -conf=/etc/bitcoin/bitcoin.conf  



```
## install postgresql
```shell
sudo apt install postgresql
sudo -i -u postgres
```

## install redis
sudo apt install redis redis-client