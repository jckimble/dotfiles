#!/bin/bash
FLAVOR=$1
if [ "$FLAVOR" == "golang" -o "$FLAVOR" == "latest" ]; then
yay -Syu --noconfirm golang
fi

if [ "$FLAVOR" == "node" -o "$FLAVOR" == "latest" ]; then
yay -Syu --noconfirm nodejs npm
fi

sudo rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*
