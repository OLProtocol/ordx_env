
# 运行pidstat命令以监控特定PID的写入速率，使用1秒的采样间隔
sudo apt install sysstat
pidstat -dl -p <PID> 1

