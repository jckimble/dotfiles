#!/bin/bash
CMD=docker
if command -v podman &> /dev/null
then
	CMD=podman
fi
IMAGE=${1:-latest}
if [ ! -f /tmp/dotfiles.${IMAGE}.updated ]; then
	$CMD pull registry.gitlab.com/jckimble/dotfiles:${IMAGE}
	if [ $? -eq 0 ]; then
		touch /tmp/dotfiles.${IMAGE}.updated
	fi;
fi
$CMD run --rm -it -v /home/jckimble/go/src:/home/jckimble/go/src registry.gitlab.com/jckimble/dotfiles:${IMAGE}
