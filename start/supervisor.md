## Supervisor 

# env（192.168.1.102）
prd  http://192.168.1.101:9001/
test http://192.168.1.102:9001/

# basic config
vi /etc/supervisor/supervisord.conf

# program config
vi /etc/supervisor/conf.d/ordx.ini 

# background service
systemctl restart supervisor
systemctl stop supervisor
systemctl start supervisor

# start supervisord in the frontground
supervisord -n -c /etc/supervisor/supervisord.conf

# start a program in the background
supervisorctl start ordx-server-master-testnet

# update a program config
supervisorctl update
