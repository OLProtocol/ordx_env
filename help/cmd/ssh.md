## https://medium.com/botfuel/how-to-expose-a-local-development-server-to-the-internet-c31532d741cc
```shell
# common tools
apt-get install sshpass

## sshd
sudo vi /etc/ssh/sshd_config
# for local network
PermitRootLogin yes
# for speed and security
X11Forwarding no
Ciphers aes128-ctr
# Ciphers aes128-ctr,aes192-ctr,aes256-ctr
KexAlgorithms diffie-hellman-group14-sha1
# KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
LoginGraceTime 10m
MaxAuthTries 3
PermitUserEnvironment no
# for jump
AllowTcpForwarding yes
GatewayPorts yes
TCPKeepAlive yes
Compression delayed
ClientAliveInterval 300
ClientAliveCountMax 3
MaxSessions 20
MaxStartups 20:30:100

sudo systemctl reload sshd

# sshd log
tail -f /var/log/auth.log
tail -f /usr/local/openresty/nginx/logs/main.log
tail -f /usr/local/openresty/nginx/logs/error.log

# ssh
ls ~/.ssh
ssh-copy-id root@103.103.245.177
ssh -o Ciphers=aes128-ctr -o KexAlgorithms=diffie-hellman-group14-sha1 root@103.103.245.177
ssh -p 10000 root@192.168.1.101
ssh-copy-id  root@103.103.245.177
ssh-copy-id -p 8020 root@103.103.245.177
ssh -J root@103.103.245.177:8020 root@192.168.1.103
ssh-keygen -t rsa -b 4096 -C "dev@tinyverse.space"
ssh-keygen -t rsa -b 4096 -C "softwarecheng@126.com"
ssh-keygen -R 192.168.1.101
ssh-keygen -R root@192.168.1.106
ssh -T git@github.com
ssh -vT git@github.com

# autossh
sudo apt install autossh
autossh -M 20010 -o 'ServerAliveInterval 10' -o 'ServerAliveCountMax 3' -o 'Ciphers aes128-ctr' -o \
'KexAlgorithms diffie-hellman-group14-sha1' -CN -R 8020:192.168.1.101:10000 root@103.103.245.177
ssh -J root@103.103.245.177:8020 root@192.168.1.102
```

