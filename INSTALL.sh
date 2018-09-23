#!/bin/bash

set -e

show_help() {
  echo "NAME"
  echo "    install.sh - install and configure binaries"
  echo
  echo "SYNOPSIS"
  echo "    ./install.sh [command]"
  echo
  echo "COMMAND"
  echo "    install [package] install and configure the package"
  echo "            if no package is specified, it will install all packages"
  echo
  echo "    ls      list all packagesi it can install and configure"
  echo
  echo "    info    [package] show the information related to the package"
  echo
  echo "    help    show help"
  exit 1
}

check_precondition() {
  # install developer command line tools
  if [ -z $(xcode-select -p) ]; then
    info "==>" "install xcode command line tools"
    xcode-select --install
  fi

  # install homebrew
  if ! command -v brew 1>/dev/null 2>&1; then
    info "==>" "install homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

# check whether a package is existed
#
# $1: package name
check_package() {
  if [ -z "$1" ]; then
    error "Error:" "empty package name"
    exit 1
  fi

  if [ ! -d "$INSTALL_HOME/package/$1" ]; then
    error "Error:" "package $1 does not exist"
    exit 1
  fi
}

# install the specified package
#
# $1: package name
install_package() {
  check_package "$1"
  local script="$INSTALL_HOME/package/$1/install.sh"
  if [ -f "$script" ]; then
    /bin/sh "$script"
  else
    error "Error:" "install.sh of package $1 could not be found"
    exit 1
  fi
}

# install all packages
install_packages() {
  for pkg_path in $INSTALL_HOME/package/*; do
    local pkg="${pkg_path//*\/}"
    install_package "$pkg"
  done
}

# list all packages
ls_packages() {
  for pkg_path in $INSTALL_HOME/package/*; do
    echo "${pkg_path//*\/}"
  done
}

# show package information
#
# $1: package name
info_package() {
  check_package "$1"
  local doc="$INSTALL_HOME/package/$1/info.txt"
  if [ -f "$doc" ]; then
    cat "$doc"
  else
    error "Error:" "info.txt of package $1 could not be found"
    exit 1
  fi
}


export SCRIPT_NAME=$0
export INSTALL_HOME=$(pwd)
export TIMESTAMP=$(date '+%Y%m%d%H%M%S')
export LIB=$INSTALL_HOME/lib/import.sh
source $LIB

# make sure install.sh is invoked in correct directory
if [ ! -f "$INSTALL_HOME/install.sh" ]; then
  echo "Please invoke install.sh from where it resides"
  exit 1
fi

if [ "$1" = "install" ]; then
  if [ -z "$2" ]; then
    check_precondition
    install_packages
  else
    check_precondition
    install_package "$2"
  fi
elif [ "$1" = "ls" ]; then
  ls_packages
elif [ "$1" = "info" ]; then
  info_package "$2"
else
  show_help
fi
