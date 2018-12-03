#!/bin/bash
image=$(shuf -n1 -e ~/.config/wallpapers/*)
$HOME/go/bin/colorize "$image"
/usr/bin/feh -z -p --no-fehbg --bg-fill "$image"
killall -SIGUSR1 conky
