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
