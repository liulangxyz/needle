#!/bin/bash

set -e

source "$NEEDLE_HOME/lib/color.sh"
source "$NEEDLE_HOME/lib/package.sh"

check_package "$1"
doc="$NEEDLE_HOME/package/$1/info.txt"
if [ -f "$doc" ]; then
  cat "$doc"
else
  error "info.txt of package $1 not be found"
  exit 1
fi
