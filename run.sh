#!/bin/bash
FILES=".bashrc .conkyrc .gitconfig .tmux.conf .tmux.sh .tmux-blue.tmuxtheme .vimrc .xinitrc"
DIRS=".gnupg .config .m2 .password-store .weechat"
for file in $FILES; do
	ln -f $file ../$file
done
for dir in $DIRS; do
	ln -sf $dir ../$dir
done
