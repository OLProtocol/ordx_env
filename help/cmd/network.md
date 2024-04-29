```shell
# ip
ip -6 addr show
ip addr show | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

# set ip
ip addr show
vi /etc/netplan/00-installer-config.yaml
network:
  ethernets:
    {ens160}:
      addresses:
      - 192.168.1.102/24
      nameservers:
        addresses:
        - 202.96.134.133
        - 114.114.114.114
        - 8.8.8.8
        search: []
      routes:
      - to: default
        via: 192.168.1.1
  version: 2
sudo netplan apply

# lsof
lsof -i :5000
# netstat
sudo netstat -tuln
sudo netstat -tulnp | grep :{port}
# netstat
netstat -ano | findstr :22
netstat -ano | grep 22
netstat -ano | grep :22
# nc 
nc -z 192.168.1.102 5432
echo "Hello, World!" | nc 103.103.245.177 1234
nc -l -p 1234
# nmap
nmap -p 21300 103.103.245.177
nmap -p- 103.103.245.177
# telnet
telnet 192.168.1.100 38443
# iftop
sudo iftop -i eth0 -f "port 443"
# nethogs
sudo nethogs eth0
sudo nethogs eth0 -d 5
sudo nethogs -t | grep sshd
sudo nethogs -t | grep nginx
# clash
vi ~/github/clash-for-linux/.env
~/github/clash-for-linux/start.sh
proxy_on
proxy_off
```