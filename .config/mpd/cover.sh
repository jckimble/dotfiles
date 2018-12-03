#!/bin/bash
mkdir -p $HOME/.cache/mpd_album
SONG=`mpc -f %file% current`
ALBUM=`mpc -f %album% current`
IMAGE=$HOME/.cache/mpd_album/$ALBUM.jpg
if [ -f "$HOME/music/download/$SONG" ]; then
if [ ! -f "$IMAGE" ]; then
ffmpeg -y -i "$HOME/music/download/$SONG" "$IMAGE"
convert "$IMAGE" -resize 100x100 "$IMAGE"
fi
ln -sf "$IMAGE" $HOME/.cache/mpd_album/nowplaying.jpg
fi
