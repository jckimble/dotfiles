#!/bin/bash -e
FILES=".bashrc .conkyrc .gitconfig .tmux.conf .vimrc .xinitrc"
DIRS=".gnupg .config .m2 .password-store .weechat"
for file in $FILES; do
	ln -sf dotfiles/$file
done
for dir in $DIRS; do
	ln -sf dotfiles/$dir
done
