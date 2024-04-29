vi /etc/ssh/sshd_config
#sshd
Ciphers aes128-ctr
KexAlgorithms diffie-hellman-group14-sha1
LoginGraceTime 10m
MaxAuthTries 3

AllowTcpForwarding yes
GatewayPorts yes
TCPKeepAlive yes
Compression delayed
ClientAliveInterval 300
ClientAliveCountMax 3
MaxSessions 20
MaxStartups 20:30:100
...

tail -f /var/log/auth.log

# ssh
ls ~/.ssh
ssh-copy-id root@103.103.245.177
ssh -o Ciphers=aes128-ctr -o KexAlgorithms=diffie-hellman-group14-sha1 root@103.103.245.177

