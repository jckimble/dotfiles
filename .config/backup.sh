#!/bin/bash
restic backup --exclude='.*' --exclude='!.nobackup' --exclude='go' --exclude-if-present='.nobackup' --exclude-if-present='.git' -r rclone:GDrive:Backup ${HOME} -p ${HOME}/.resticpass -q
restic forget --prune -p ${HOME}/.resticpass -q -r rclone:GDrive:Backup --keep-daily 7 --keep-weekly 5 --keep-monthly 3 --keep-yearly 1
restic check -p ${HOME}/.resticpass -q -r rclone:GDrive:Backup
