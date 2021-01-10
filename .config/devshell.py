#!/usr/bin/python3
import subprocess
import json
import os
import time
import sys
import pathlib
from shutil import which
cmd="docker"
if which("podman") is not None:
    cmd="podman"
image="latest"
if len(sys.argv) == 2:
    image=sys.argv[1]
containerImage="registry.gitlab.com/jckimble/dotfiles:{}".format(image)

print("Using {} to start DevShell".format(cmd))

def needs_pull():
    filename="/tmp/dotfiles.{}.updated".format(image)
    if os.path.exists(filename) is False:
        return True
    modtime=os.stat(filename).st_mtime
    lasttime=(time.time()-modtime)/3600
    if lasttime > 23:
        return True
    return False

if needs_pull():
    errCode=subprocess.call([cmd,"pull",containerImage])
    if errCode == 0:
        pathlib.Path("/tmp/dotfiles.{}.updated".format(image)).touch()

startCommand=[cmd,"run","--rm","-it"]
proc = subprocess.Popen(" ".join([cmd,"image","inspect",containerImage]), stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True)
# skip first lines, until the [ which starts JSON
for line in proc.stdout:
    if line.decode().startswith('['):
        break
    else:
        continue

buffer = ""
for line in proc.stdout:
    # remove empty and "connection" lines (a comma)
    if not line.decode().strip(', \n'):
        continue
    buffer += line.decode('utf-8')
    try:
        event = json.loads(buffer)
    except json.decoder.JSONDecodeError:
        pass
    else:
        for volume in event["Config"]["Volumes"].keys():
            volumeName="dotfiles{0}".format(volume.replace("/","-"))
            errCode=subprocess.call([cmd,"volume","inspect",volumeName],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
            if errCode != 0:
                print("Creating volume for {}".format(volume))
                subprocess.call([cmd,"volume","create",volumeName],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
            startCommand.append("-v")
            startCommand.append("{0}:{1}".format(volumeName,volume))
        buffer = ""
startCommand.append(containerImage)
print("Starting container")
subprocess.call(startCommand)
