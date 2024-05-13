```shell
# for disk
lsblk
sudo df -h
# for raid
mdadm --stop /dev/md126
mdadm --stop /dev/md127
mdadm --remove /dev/md126和mdadm --remove /dev/md127
mdadm --zero-superblock /dev/sda
# for lvm
sudo pvdisplay
sudo vgdisplay
sudo lvdisplay
sudo pvs
sudo vgs
sudo pvs
sudo pvscan

mount | grep /dev/mapper/ubuntu--vg-ubuntu--lv
sudo fdisk -l
sudo fdisk /dev/sdb #n,p,1,w
-n ... w
# >2TB
sudo apt install gdisk
sudo gdisk /dev/sdc
o ... w
sudo gdisk /dev/sdc
n ... w
sudo partprobe # re-read partition table
# lvm
sudo pvcreate /dev/sdc1 /dev/sdb1
sudo pvremove /dev/sdc1

sudo vgcreate vg_data1 /dev/sdc1 /dev/sdb1 
sudo vgreduce --removemissing /dev/sdb1
sudo vgextend vg_data1 /dev/sdb1
sudo vgremove vg_data1

sudo lvcreate -l 100%FREE -n lv_data1 vg_data1
sudo lvcreate -n lv_data1 -L 50G vg_data1
sudo lvremove /dev/vg_data1/lv_data1

sudo mkfs.ext4 /dev/vg_data1/lv_data1
sudo lvextend -l +100%FREE /dev/vg_data1/lv_data1
resize2fs

sudo mkdir /data
sudo mount /dev/vg_data1/lv_data1 /data
sudo mount /dev/mapper/vg_data1-lv_data1 /data

/etc/fstab # /dev/vg_data1/lv_data1 /data ext4 defaults 0 0

lvremove /dev/data-vg/data-lv1
vgremove data-vg
pvremove /dev/sdb1

# test disk speed
# test write
time dd if=/dev/zero of=/data/test bs=1M count=10240
# test read
time dd if=/data/test of=/dev/null bs=1M count=10240
```






