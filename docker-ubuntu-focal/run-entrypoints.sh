#!/bin/bash

function exec_entrypoint()
{
	echo
	echo "---> Executing entrypoint [$1]"
	"$1"
}

export -f exec_entrypoint

find /entrypoint.d -type f -exec bash -c "exec_entrypoint \"{}\"" \;

$*
