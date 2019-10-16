#!/bin/bash

########################################
# utils
########################################
# $1: message
info() {
  echo $'\e[1;32m'"[NEEDLE]"$'\e[0m' $*
}

# $!: binary
exists() {
  command -v "$1" 1>/dev/null 2>&1
}

# $1: brew
brewinstall() {
  info "brew install $1"
  brew install "$1"
}

# $1: source
# $2: target
symlink() {
  info "symlink $2"
  ln -fsv "$1" "$2"
}

########################################
# init
########################################
# install developer command line tools if not
if ! exists xcode-select || [[ -z $(xcode-select -p) ]]; then
  info "install xcode command line tools"
  xcode-select --install
fi

# install homebrew if not
if ! exists brew; then
  info "install homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


########################################
# basic stuff
########################################
info "update brews"
brew update

info "upgrade existed brews"
brew upgrade

brewinstall cmake
brewinstall fzf
brewinstall fd
brewinstall ag
brewinstall httpie
brewinstall youtube-dl


########################################
# sewing
########################################
for sew in $(find ./thread -name "sew.sh" -type f -print | sort); do
  source "$sew"
done