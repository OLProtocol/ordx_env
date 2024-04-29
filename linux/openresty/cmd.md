apt install openresty
vi /etc/openresty/nginx.conf
...

systemctl restart openresty
tail -f /usr/local/openresty/nginx/logs/error.log
tail -f /usr/local/openresty/nginx/logs/access.log