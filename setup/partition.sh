#!/bin/bash
set +e
fdisk $1 << EOF
n
p
1

+512M
t
83
n
p
2

+25G
t
2
83
n
p
3


t
3
83
w
EOF
mkfs.ext2 ${1}1
mkfs.ext4 ${1}2
mkfs.ext4 ${1}3
mount -o noatime,discard ${1}2 /mnt
mkdir /mnt/boot 
mount -o noatime,discard ${1}1 /mnt/boot
mkdir /mnt/home
mount -o noatime,discard ${1}3 /mnt/home
