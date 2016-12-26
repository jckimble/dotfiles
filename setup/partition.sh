#!/bin/bash
set +e
fdisk $1 << EOF
n
p
1

+512M
t
ef
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

+8G
t
3
82
n
p
4


t
4
83
w
EOF
mkfs.fat -F32 ${1}1
mkfs.ext4 ${1}2
mkswap ${1}3
mkfs.ext4 ${1}4
mount ${1}2 /mnt
mkdir /mnt/boot 
mount ${1}1 /mnt/boot
mkswap ${1}3
swapon ${1}3
mkdir /mnt/home
mount ${1}4 /mnt/home
