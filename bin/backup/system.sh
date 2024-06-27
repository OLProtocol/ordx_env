#!/bin/bash
# set -x
set -e

# backup linux
# https://askubuntu.com/questions/7809/how-to-back-up-my-entire-system
sudo tar cvpzf /data2/system-backup.tar.gz \
    --exclude=/run \
    --exclude=/dev \
    --exclude=/mnt \
    --exclude=/proc \
    --exclude=/sys \
    --exclude=/tmp \
    --exclude=/media \
    --exclude=/cdrom \
    --exclude=/data1 \
    --exclude=/data2 \
    --exclude=/data \
    --exclude=/lost+found \
    /
tar xvpfz /data2/system-backup.tar.gz -C /
