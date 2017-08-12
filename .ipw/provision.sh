#!/bin/bash
##################################################
# Warning do not run unless you know exactly what
# this does, made to be ran on a clean efi system
# I am not responsible if this script kills your
# computer, wife/husband/girlfriend/boyfriend, or
# cat/dog. YOU HAVE BEEN WARNED
##################################################
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
mkfs.fat -f32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3
mkfs.ext4 /dev/sda4
mount /dev/sda2 /mnt
mkdir /mnt/boot 
mount /dev/sda1 /mnt/boot
mkswap /dev/sda3
swapon /dev/sda3
mkdir /mnt/home
mount /dev/sda4 /mnt/home
pacman -Sy reflector --noconfirm
reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel puppet efibootmgr
genfstab -pU /mnt > /mnt/etc/fstab
arch-chroot /mnt sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
arch-chroot /mnt locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf
arch-chroot /mnt ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
arch-chroot /mnt efibootmgr -d /dev/sda -y 1 -c -L "Arch Linux" -l /vmlinuz-linux -u "root=/dev/sda2 ro initrd=/initramfs-linux.img"
hwclock --systohc --utc
/bin/cat <<EOF >/mnt/etc/puppetlabs/puppet/puppet.conf
[main]
{{if .Hostname}}certname={{.Hostname}}{{end}}
server={{.Server}}
environment=production
csr_attributes=/etc/puppetlabs/puppet/csr_attributes.yaml
EOF
/bin/cat <<EOF >/mnt/etc/puppetlabs/puppet/csr_attributes.yaml
---
custom_attributes:
        1.2.840.113549.1.9.7: {{.AuthKey}}
EOF
arch-chroot /mnt puppet agent -w 60 --no-daemonize -v -o --server puppet

reboot
