```shell
# curl
curl -H "Accept: application/json" https://apitest.ordx.space/testnet/bestheight
curl -X POST -d '{"utxos":"umc8wucmk599j3aklgaqw54zfq"}'  http://192.168.10.102:8007/testnet-go/testnet/
# ab
ab -n 1000 -c 100 https://apiprd.ordx.space/mainnet/health
ab -n 1000 -c 100 https://apiprd.ordx.space/mainnet/status
# certbot
sudo certbot renew > /root/log/cron-certbot.log 2>&1
sudo certbot renew --dry-run > /root/log/cron-certbot.log 2>&1
sudo certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini -d ordx.space -d *.ordx.space -i nginx
sudo certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini -d *.ordx.space -i nginx
sudo certbot delete --cert-name ordx.space
sudo certbot certificates
sudo certbot delete --cert-name api.ordx.space

```