#!/bin/bash
set +e
fdisk $1 << EOF
n
p
1

+8G
t
c
n
p
2


t
2
83
w
EOF
mkfs.msdos -F 32 ${1}1
mkfs.ext2 ${1}2
mount ${1}2 /mnt
pacman -Sy reflector --noconfirm
reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel ccid networkmanager terminus-font scrot xautolock openssh ttf-dejavu linux-headers slim i3 xorg firefox git tmux xclip keybase gvim grub conky feh compton redshift termite wget haveged jpegoptim nemo xloadimage msmtp virtualbox-guest-utils dkms
echo "session    required   pam_mkhomedir.so skel=/etc/skel umask=0077" >> /mnt/etc/pam.d/system-login
mount -t tmpfs tmpfs /mnt/home
genfstab -U -p /mnt >> /mnt/etc/fstab
echo "tmpfs /home tmpfs noatime 0 0" >> /mnt/etc/fstab
arch-chroot /mnt sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
arch-chroot /mnt locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf
arch-chroot /mnt ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc --utc
arch-chroot /mnt sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
arch-chroot /mnt grub-install $1
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt systemctl enable slim
arch-chroot /mnt systemctl enable NetworkManager
arch-chroot /mnt systemctl enable pcscd
arch-chroot /mnt systemctl enable haveged
arch-chroot /mnt sed -i 's/#default_user/default_user/' /etc/slim.conf
echo archgpg > /mnt/etc/hostname
arch-chroot /mnt useradd -mg users -G wheel,storage,power -s /bin/bash archgpg
echo "archgpg:archgpg" | arch-chroot /mnt chpasswd
cp -a ./skel /mnt/etc
cp ./aur.sh /mnt/aur.sh
arch-chroot /mnt sudo -u archgpg sh aur.sh
rm /mnt/aur.sh
arch-chroot /mnt sed -i "s/simone/archgpg/" /etc/slim.conf
arch-chroot /mnt sed -i 's/^#\(auto_login\s\+\)no/\1yes/' /etc/slim.conf
