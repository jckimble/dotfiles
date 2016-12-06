#!/bin/bash
if [ `ps aux | grep pianobar | wc -l` -gt 3 ];then
	killall pianobar
else
	if [ ! -p "~/.config/pianobar/ctl" ]; then
		mkfifo ~/.config/pianobar/ctl
	fi;
	nohup `which pianobar` 1>/dev/null 2>&1 &
fi;
