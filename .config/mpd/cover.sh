#!/bin/bash
SONG=`mpc -f %file% current`
ffmpeg -y -i "$HOME/music/download/$SONG" /tmp/cover.jpg
