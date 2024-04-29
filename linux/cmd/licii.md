```shell
# licii
lncli unlock
lnd --configfile=/Users/chenwenjie/test/lnd/lnd.conf --lnddir=/Users/chenwenjie/test/lnd/data
openssl x509 -noout -text -in tls.cert | grep DNS:
lncli -lnddir=/Users/chenwenjie/test/lnd/data create
lncli -lnddir=/Users/chenwenjie/.lit/lnddata/ create
litd --configfile=~/.lit/lit.conf
lncli -lnddir=/Users/chenwenjie/.lit/lnddata/ unlock
lncli create
```