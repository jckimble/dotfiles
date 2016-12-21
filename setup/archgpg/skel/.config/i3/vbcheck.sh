#!/bin/bash
#Check if in virtualbox
if [ `pacman -Qtq | grep virtualbox-guest-utils | wc -l` -eq 1 ]; then
	VBoxClient-all
fi;
