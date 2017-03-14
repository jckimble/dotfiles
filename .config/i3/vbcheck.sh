#!/bin/bash
#Check if in virtualbox
if [ `pacman -Qtq | grep virtualbox-guest-utils | wc -l` -eq 1 ]; then
	VBoxClient-all
fi;
#decrypt files
FILES="${HOME}/.weechat/ssl/jckimble.pem ${HOME}/.m2/keystore ${HOME}/.m2/settings.xml"
for file in $FILES; do
	if [ ! -f ${file} ]; then
		gpg --decrypt -o ${file} ${file}.gpg
	fi;
done;
