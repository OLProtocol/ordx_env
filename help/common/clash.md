```shell
../../bin/install/clash/start.sh
netstat -tln | grep -E '9090|789.'
env | grep -E 'http_proxy|https_proxy'
source /etc/profile.d/clash.sh
proxy_on
proxy_off
../../bin/install/clash/shutdown.sh
```