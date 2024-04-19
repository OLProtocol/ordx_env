apt install openresty
systemctl restart openresty
tail -f /usr/local/openresty/nginx/logs/access.log
tail -f /usr/local/openresty/nginx/logs/error.log