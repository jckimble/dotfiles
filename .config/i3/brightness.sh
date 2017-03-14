#!/bin/bash
device=/sys/class/backlight/radeon_bl0/brightness
echo $(($(cat $device)$1)) | sudo tee $device

