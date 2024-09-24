#!/bin/bash

# Usage: ./build [addictional-docker-build-args]
#

# https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-x64.tar.xz
NODEJS_PACKAGE=node-v18.16.0-linux-x64.tar.xz

exdir=$(dirname `readlink -f "$0"`)

DOWNLOADS="$exdir"/Downloads

if [ ! -e "$DOWNLOADS" ]; then
	mkdir "$DOWNLOADS"
fi

if [ ! -e "$DOWNLOADS/$NODEJS_PACKAGE" ]; then
	echo "missing $DOWNLOADS/$NODEJS_PACAKGE please download from https://nodejs.org/en/download/"
	echo "  curl -o Downloads/node-v18.16.0-linux-x64.tar.xz https://nodejs.org/dist/v18.16.0/node-v18.16.0-linux-x64.tar.xz
"
	exit 1
fi

docker build $args $* -t searchathing/ubuntu:jammy -f "$exdir"/Dockerfile "$exdir"/.