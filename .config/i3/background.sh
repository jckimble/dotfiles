#!/bin/bash
wal -q -i ~/.config/wallpapers/
killall -SIGUSR1 conky
