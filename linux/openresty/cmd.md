apt install openresty
vi /etc/openresty/nginx.conf
ls /etc/nginx/sites-enabled/
vi /usr/local/openresty/nginx/conf/sites-enabled/ord-testnet.ordx.space

...

systemctl restart openresty
tail -f /usr/local/openresty/nginx/logs/error.log
tail -f /usr/local/openresty/nginx/logs/access.log