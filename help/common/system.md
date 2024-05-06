```shell
# ps
ps -p {pid} -o pid,ppid,cmd
ps -aux | grep
ps -ef | grep
ps -p {pid}
ps -p {pid} -o lstart
# proc
ls -l /proc/<PID>/exe
tail -f /proc/{pid}/fd/1
# vmstat
vmstat 1
# top
top -p `pidof ordx-server-checkself`
top -p {pid,pid}
# pgrep
pgrep ordx-server
# kill
kill -2 {pid} // SIGINT ctrl-c
kill {pid} // SIGTERM  == kill -15 pid
# killall
killall ordx-server
# pkill
pkill myapp
pkill -f nginx
pkill -u john
pkill -f "python script.py"
pkill -g 1234
pkill -i process_name
pkill -9 process_name
pkill -U john -n -m 5m
pkill -e tvbot
# nohup
nohup ./server 2>&1 &

# memory panic
vim /etc/rsyslog.d/50-default.conf
 33 # Some "catch-all" log files.
 34 #
 35 #*.=debug;\
 36 #       auth,authpriv.none;\
 37 #       news.none;mail.none     -/var/log/debug
 38 #*.=info;*.=notice;*.=warn;\
 39 #       auth,authpriv.none;\
 40 #       cron,daemon.none;\
 41 #       mail,news.none          -/var/log/messages
systemctl restart rsyslog.service

grep "memory" /var/log/messages
egrep -i 'killed process' /var/log/messages
egrep -i -r "killed process" /var/log
journalctl -xb | egrep -i 'killed process'
dmesg | egrep -i -B100 'killed process'
sysctl -w net.core.rmem_max=2500000 # if need to set


```