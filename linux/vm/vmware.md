
## Reduce disk space for vmware esxi thin vmdisk mode (ref)
# 1 Ubuntu 20.04 desktop cd boots independently into the desktop
    1.1 vmware esxi sever background, point the cd media in the specified virtual machine configuration to ubuntu-20.04.6-desktop-amd64.iso, and check Connect when powering on
    1.2 vmware fusion client(10.1.6 for mac) connect vmware esxi server to find specified virtual machine -> setup -> advance -> firmware pattern -> UEFI
    1.3 vmware esxi sever background, Start the virtual machine and open the console -> Ubuntu -> Try Ubuntu -> Terminal 

# 2 If use lvm
```shell
sudo cfdisk
sudo vgdisplay
sudo lvdisplay
sudo mount /dev/ubuntu-vg/ubuntu-lv /mnt
df -lh
sudo umount /mnt
sudo e2fsck -f /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv 15G
sudo lvreduce -L 15G /dev/ubuntu-vg/ubuntu-lv
```

# 3 Reduce size with Gparted
    3.1 Gparted Resize 15G and apply
    3.2 shutdown 
    3.3 vmware fusion client(10.1.6 for mac) connect vmware esxi server to find specified virtual machine -> setup -> advance -> firmware pattern -> Traditional BIOS

# 4 Zero out all unused space within the virtual linux
```shell
sudo dd if=/dev/zero bs=1048576 of=/zero ; sync ;
sudo rm -rf /zero
shutdown now
```

# 5 To reclaim disk space(need ssh login vmware esxi server)
```shell
vmkfstools -K /vmfs/volumes/datastore2/btc_node_001/ubuntu20-web3-001.vmdk
ls -alh /vmfs/volumes/datastore2/btc_node_001
# 50GB
vi /vmfs/volumes/datastore2/btc_node_001/ubuntu20-web3-001.vmdk
# Extent description
RW 104857600 VMFS "buntu20-web3-001-flat.vmdk" 
ddb.geometry.cylinders = "6527"
```

# 6 unregister vm && register vm

# 7 Safely stop a Copy datastore file task in vmware exsi server
```shell
/etc/init.d/hostd restart
```

# 8 VMware-converter-en-6.6.0-23265344.exe