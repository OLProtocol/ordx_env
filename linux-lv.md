sudo partprobe
lsblk
sudo df -h
sudo pvdisplay
sudo vgdisplay
sudo lvdisplay
sudo pvs
sudo vgs
sudo pvs
sudo pvscan

mount | grep /dev/mapper/ubuntu--vg-ubuntu--lv
fdisk /dev/sdb
 -n ... w
sudo pvcreate /dev/sdb1 /dev/sdc1
sudo vgcreate data-vg /dev/sdb1 /dev/sdc1
sudo vgreduce --removemissing /dev/sdb1
sudo vgextend data-vg /dev/sdb1


sudo lvcreate -l 100%FREE -n data-lv1 data-vg
sudo lvcreate -n data-lv1 -L 50G data-vg

sudo mkfs.ext4 /dev/data-vg/data-lv1
sudo lvextend -l +100%FREE /dev/data-vg/data-lv1
resize2fs

sudo mkdir /data1
sudo mount /dev/data-vg/data-lv1 /data1
sudo mount /dev/mapper/data-vg-data-lv1 /data

/etc/fstab
# /dev/data-vg/data-lv1 /data ext4 defaults 0 0

lvremove /dev/data-vg/data-lv1
vgremove data-vg
pvremove /dev/sdb1