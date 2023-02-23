#!/bin/bash
CACHE=${HOME}/.cache
if [ -z "$GITHUB_TOKEN" ]; then
	echo "GITHUB_TOKEN must be set"
	exit 1
fi
test -f "${CACHE}/background.png" && mv ${CACHE}/background.png ${CACHE}/background.old.png
test -f "${CACHE}/background.old.png" && plasma-apply-wallpaperimage ${CACHE}/background.old.png
npx @jckimble/github-graph-background --theme random:dark --output ${CACHE}/background.png
plasma-apply-wallpaperimage ${CACHE}/background.png
test -f "${CACHE}/background.old.png" && rm ${CACHE}/background.old.png
