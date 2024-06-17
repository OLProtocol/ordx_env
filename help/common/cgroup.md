# 限制特定设备的磁盘写入速率
<!-- blkio.throttle.read_bps_device：限制读速率（每秒字节数）。
blkio.throttle.write_bps_device：限制写速率（每秒字节数）。
blkio.throttle.read_iops_device：限制读操作的IOPS（每秒输入/输出操作数）。
blkio.throttle.write_iops_device：限制写操作的IOPS。 -->
## 查找MAJ:MIN这一列来确定设备号
lsblk 
mkdir /sys/fs/cgroup/<your-cgroup-name>
## 使用io.max文件设置特定设备的写入速率限制。假设你的设备主设备号是8，次设备号是16，并且你想要限制写入速率为每秒1MB（1048576字节）
echo "8:16 wbps=10485760" > /sys/fs/cgroup/<your-cgroup-name>/io.max
echo "253:1 rbps=1048576 wbps=1048576" > /sys/fs/cgroup/mygroup1/io.max
echo <PID> > /sys/fs/cgroup/<your-cgroup-name>/cgroup.procs

# 检查cgroup v2是否挂载和启用
mount | grep cgroup2

# 设置cpu.max文件中的两个值：quota和period。quota是进程组在给定的period时间内可以消耗的CPU时间的最大量，以微秒为单位。如果你设置quota为period的一半，那么理论上，这个cgroup就能使用最多50%的单个CPU核心的时间。 例如，如果你设置period为100ms（100000us），然后设置quota为50ms（50000us），那么这个cgroup中的进程最多只能使用50%的单个CPU核心的时间
echo "50000 100000" > /sys/fs/cgroup/<your-cgroup-name>/cpu.max

# 设置CPU限制： cgroup v2使用“CPU权重”（而不是百分比）来分配CPU时间。默认权重为100，范围是1到10000。设置较高的权重给予进程更多的CPU时间。 例如，要将CPU权重设置为相对较低的值（比如50%的默认值），你可以这样做：
echo 50 > /sys/fs/cgroup/<your-cgroup-name>/cpu.weight

#
cgcreate -g memory:/mygroup
cgdelete -g <controller>:<cgroup-name>
mkdir /sys/fs/cgroup/<your-cgroup-name>
echo <memory-limit-in-bytes> > /sys/fs/cgroup/<your-cgroup-name>/memory.max

# 将<PID>替换为你的进程ID，<LIMIT>替换为你想要设置的内存限制大小（以字节为单位）
prlimit --pid 1234 --as=500000000
renice 10 -p <PID>
cpulimit -p <PID> -l 50

#
ps -p 1234 -o etime=
kill -SIGSTOP <PID>
kill -SIGCONT <PID>
ps -e -o pid,state,cmd | grep ' T '

#
pidstat -dl -p <PID> 1