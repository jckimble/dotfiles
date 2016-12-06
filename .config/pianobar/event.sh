#!/usr/bin/env bash

# create variables
while read L; do
    k="`echo "$L" | cut -d '=' -f 1`"
    v="`echo "$L" | cut -d '=' -f 2`"
    export "$k=$v"
done < <(grep -e '^\(title\|artist\|album\|stationName\|songStationName\|pRet\|pRetStr\|wRet\|wRetStr\|songDuration\|songPlayed\|rating\|coverArt\|stationCount\|station[0-9]*\)=' /dev/stdin) # don't overwrite $1...

case "$1" in
    songstart)
		echo -e "$songDuration" > ~/.config/pianobar/songDuration
		echo -e "$songPlayed" > ~/.config/pianobar/songPlayed
		echo -e "$album" > ~/.config/pianobar/album
		echo -e "$artist" > ~/.config/pianobar/artist
		echo -e "$title" > ~/.config/pianobar/title
		curl $coverArt --output ~/.config/pianobar/coverArt
	;;
esac

