```shell
### user
vi /etc/security/limits.conf
root            hard    nofile          4000000
root            soft    nofile          4000000
vi /lib/systemd/system/postgresql@.service

### session
sysctl fs.file-max
cat /proc/sys/fs/file-max
sudo vi /etc/sysctl.conf
file-max = 367886
sudo vi /etc/security/limits.conf
root                hard    nofile          367886
root                soft    nofile          367886
sysctl -p # reload
ulimit -n
ulimit -Hn
ulimit -Sn 400000
```