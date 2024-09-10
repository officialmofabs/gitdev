#!/bin/bash
# Template bash script using given script file as source for variable values
if [ -f "$1" ]; then  source "$1" || echo "#! ERROR: Unable to read variables from script: $1!" 1>&2  &&  exit 1;  fi
(awk '/TMPL$/,/^TMPL/{print}' "$0" | grep -Eio '(^|[^\])\${?[A-Z][A-Z0-9_]*}?' | cut -c3- | tr -d '{}' | sort -u) | grep -v -w -F "$(env | cut -f1 -d= | sort)" | sed 's/^/ERROR: need tmpl var: /' | grep .  &&  exit 123  ||  true
###############################################################################
cat<<TMPL
# Config generated on $(date)
FILES="$(ls -1 | paste -sd,)"
TMPL