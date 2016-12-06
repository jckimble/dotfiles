#!/bin/bash
USER=$1
PASS=$2
arch-chroot /mnt useradd -mg users -G wheel,storage,power -s /bin/bash $USER
echo "$USER:$PASS" | arch-chroot /mnt chpasswd
cp -a . /mnt/home/$USER/dotfiles/
FILES=".bashrc .conkyrc .gitconfig .tmux.conf .tmux.sh .tmux-blue.tmuxtheme .vimrc .xinitrc"
DIRS=".gnupg/ .config/ .m2/ .password-store/ .weechat/"
for file in $FILES; do
	ln /home/$USER/dotfiles/$file /home/$USER/$file
done
for dir in $DIRS; do
	ln -s /home/$USER/dotfiles/$dir /home/$USER/$dir
done
arch-chroot /mnt chown -R $USER:users /home/$USER
arch-chroot /mnt chmod -R 700 /home/$USER
arch-chroot /mnt sed -i 's/simone/${USER}/' /etc/slim.conf
