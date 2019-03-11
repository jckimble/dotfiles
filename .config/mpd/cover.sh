#!/bin/bash
mkdir -p $HOME/.cache/mpd_album
SONG=`mpc -f %file% current`
ALBUM=`mpc -f %album% current`
IMAGE=$HOME/.cache/mpd_album/$ALBUM.jpg
if [ -f "$HOME/music/download/$SONG" ]; then
if [ $ALBUM == "" ];then
return 0
fi
if [ ! -f "$IMAGE" ]; then
ffmpeg -y -i "$HOME/music/download/$SONG" "$IMAGE"
if [ ! -f "$IMAGE" ]; then
TRACK=`mpc -f %title% current`
ARTIST=`mpc -f %artist% current`
LASTFM=`wget -q -O - "http://ws.audioscrobbler.com/2.0/?method=track.getInfo&api_key=$LASTFM_APIKEY&artist=$ARTIST&track=$TRACK&format=json" | jq -r ".track.album.image[2].\"#text\""`
wget -q -O $IMAGE "$LASTFM"
return 0
fi
convert "$IMAGE" -resize 100x100 "$IMAGE"
fi
ln -sf "$IMAGE" $HOME/.cache/mpd_album/nowplaying.jpg
fi
