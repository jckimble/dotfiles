#!/bin/bash
device=/sys/class/backlight/amdgpu_bl0/brightness
echo $(($(cat $device)$1)) | sudo tee $device

