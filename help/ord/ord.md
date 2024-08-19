```shell
ord0.16.0 --chain mainnet --bitcoin-rpc-url 192.168.10.103:8332 --data-dir /data2/ord-data/0.16.0/main --bitcoin-rpc-username jacky --bitcoin-rpc-password _RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 --first-inscription-height 767430 --index-sats --minify server --http --http-port 82

ord0.16.0 --chain testnet --bitcoin-rpc-url 192.168.10.103:18332 --data-dir /data2/ord-data/0.16.0 --bitcoin-rpc-username jacky --bitcoin-rpc-password 123456 --first-inscription-height 2413343 --index-sats --minify server --http --http-port 80

# ord 0.19.0 testnet4
target/release/ord --chain mainnet --bitcoin-rpc-url 192.168.10.102:8332 --data-dir /data2/ord-data/0.19.1-testnet4/mainnet --bitcoin-rpc-username jacky --bitcoin-rpc-password _RZekaGRgKQJSIOYi6vq0_CkJtjoCootamy81J2cDn0 --first-inscription-height 767430 --index-addresses --index-runes --index-sats --index-spent-sats --index-transactions server --http --http-port 83

target/release/ord --chain testnet4 --bitcoin-rpc-url 192.168.10.102:28332 --data-dir /data2/ord-data/0.19.1-testnet4 --bitcoin-rpc-username jacky --bitcoin-rpc-password 123456 --first-inscription-height 27228 --index-addresses --index-runes --index-sats --index-spent-sats --index-transactions server --http --http-port 84

```

