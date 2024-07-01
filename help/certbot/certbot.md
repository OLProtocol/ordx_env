# https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal&tab=wildcard

vi ~/.secrets/certbot/cloudflare.ini
# Cloudflare API token used by Certbot
dns_cloudflare_api_token = sr-iIZsbdtE4VB00xqv9wdmlHqth4bVdMMsTDtNU

certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini -d *.ordx.space -i nginx

sudo certbot renew --dry-run

crontab -e
0 23 25 * * certbot renew > /root/log/cron-certbot.log 2>&1
