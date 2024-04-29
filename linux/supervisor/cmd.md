apt install supervisor
vi /etc/supervisor/supervisord.conf
vi /etc/supervisor/conf.d/ordx.ini
systemctl stop supervisor
systemctl restart supervisor

supervisord -n -c /etc/supervisor/supervisord.conf
supervisorctl start ordx-server-master-testnet
