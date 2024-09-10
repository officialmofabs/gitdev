#!/bin/bash                                                                     

cmdline=($1)
cmd=$(basename "${cmdline[0]}")

if [ -z "$cmd" ] ; then
    exec git-shell
elif [ -n "$cmd" -a -x ~/git-shell-commands/"$cmd" ] ; then
    ~/git-shell-commands/"$cmd" "${cmdline[@]:1}"
else
    exec git-shell -c "$1"