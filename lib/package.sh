#!/bin/bash

source "$NEEDLE_HOME/lib/color.sh"

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
function check_package() {
  if [ -z "$1" ]; then
    error "Empty package name"
    exit 1
  fi

  if [ ! -d "$NEEDLE_HOME/package/$1" ]; then
    error "Package $1 does not exist"
    exit 1
  fi
}
