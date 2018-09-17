#!/bin/bash
WIDTH=${1}
MEDIUM=140
SONG=`mpc current`
if [ ! -z "$SONG" ]; then
	echo -n "#[fg=colour24,bg=colour233,nobold]#[fg=colour232,bg=colour24,bold]$SONG #[fg=colour235,bg=colour24,nobold]"
else
	echo -n "#[fg=colour235,bg=colour233,nobold]"
fi;
echo -n "#[fg=colour240,bg=colour235] $(date +'%H:%M:%S') #[fg=colour240,bg=colour235,nobold]#[fg=colour233,bg=colour240] $(date +'%d-%b-%y') #[fg=colour24,bg=colour240,nobold]#[fg=colour232,bg=colour24,bold] #(grep POWER_SUPPLY_CAPACITY= /sys/class/power_supply/BAT1/uevent | cut -d= -f2)% "
