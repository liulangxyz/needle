#!/bin/bash

set -e

source $NEEDLE_HOME/lib/color.sh
source $NEEDLE_HOME/lib/package.sh

install() {
  check_package "$1"
  local script="$NEEDLE_HOME/package/$1/install.sh"
  if [ -f "$script" ]; then
    /bin/sh "$script"
  else
    error "install.sh of package $1 not found"
    exit 1
  fi
}

check_precondition
if [ "$1" = '--all' ]; then
  for pkg_path in $NEEDLE_HOME/package/*; do
    install "${pkg_path//*\/}"
  done
else
  install "$1"
fi
