#!/bin/bash
FILES=".bashrc .conkyrc .gitconfig .tmux.conf .tmux.sh .tmux-blue.tmuxtheme .vimrc .xinitrc"
DIRS=".gnupg .config .m2 .password-store .weechat"
for file in $FILES; do
	ln /home/$USER/dotfiles/$file /home/$USER/$file
done
for dir in $DIRS; do
	ln -s /home/$USER/dotfiles/$dir /home/$USER/$dir
done
