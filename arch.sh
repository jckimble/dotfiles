#!/bin/bash
PASS=$1
sh setup/partition.sh /dev/sda
sh setup/system.sh jcklaptop
sh setup/user.sh jckimble $PASS
