#!/bin/bash
cd /tmp
git clone https://aur.archlinux.org/monkeysign-git.git
cd monkeysign-git
makepkg -si --noconfirm
cd /tmp
rm -rf monkeysign-git
cd /
