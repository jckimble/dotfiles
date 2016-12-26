#!/bin/bash
HOSTNAME=$1
pacman -Sy reflector --noconfirm
reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel imagemagick pamixer pulseaudio-alsa pulseaudio-bluetooth ccid bluez bluez-libs bluez-utils bluez-firmware networkmanager networkmanager-openvpn efibootmgr terminus-font alsa-utils scrot xautolock openssh ttf-dejavu linux-headers slim i3 xorg firefox git tmux xclip x11vnc keybase pass gvim grub conky feh pianobar compton eog macchanger mplayer puppet redshift termite weechat wget virtualbox-guest-utils dkms
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
arch-chroot /mnt locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf
arch-chroot /mnt ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc --utc
arch-chroot /mnt sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
arch-chroot /mnt grub-install /dev/sda
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt efibootmgr /dev/sda -p 1 -c -L "Arch Linux" -l /vmlinuz-linux -u "root=/dev/sda2 rw initrd=/initramfs-linux.img" 
arch-chroot /mnt systemctl enable slim
arch-chroot /mnt systemctl enable NetworkManager
arch-chroot /mnt systemctl enable bluetooth
arch-chroot /mnt systemctl enable pcscd
echo "default_driver=pulse" > /mnt/etc/libao.conf
arch-chroot /mnt sed -i 's/#default_user/default_user/' /etc/slim.conf
echo $HOSTNAME > /mnt/etc/hostname
