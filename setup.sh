#!/bin/bash

set -e

command_exists() {
  command -v "$@" 1>/dev/null 2>&1
}

info() {
  echo "${GREEN}[NEEDLE]${RESET}" "$@"
}

error() {
  echo "${RED}Error:${RESET}" "$@"
}

brewinstall() {
  info "brew install $1"
  brew install "$1"
}

symlink() {
  info "symlink $2"
  ln -fsv "$1" "$2"
}

setup_color() {
  RED=$(printf '\033[31m')
	GREEN=$(printf '\033[32m')
	YELLOW=$(printf '\033[33m')
  RESET=$(printf '\033[m')
}

check_precondition() {
  if ! command_exists xcode-select || [[ -z $(xcode-select -p) ]]; then
    info "install xcode command line tools"
    xcode-select --install
  fi

  if ! command_exists brew; then
    info "install homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

setup_needle() {
  command_exists git || {
    error "git not found"
    exit 1
  }

  [[ -d "$NEEDLE" ]] && {
    info "Looks needle is already installed."
    info "To re-install needle, you need to delete ${NEEDLE} first."
    exit 1
  }

  info "Cloning Needle"
  git clone "$NEEDLE_REPO" "$NEEDLE" || {
    error "clone failed"
    exit 1
  }
}

sewing() {
  for sew in $(find "${NEEDLE}/thread" -name "sew.sh" -type f -print | sort); do
    source "$sew"
  done
}

install() {
  setup_color
  check_precondition

  if [[ -z "$SETUP_NEEDLE" ]]; then
    setup_needle
  fi

  info "update brews"
  brew update
  info "upgrade existed brews"
  brew upgrade

  # install essentails
  brewinstall cmake
  brewinstall fzf
  brewinstall fd
  brewinstall ripgrep
  brewinstall httpie
  brewinstall youtube-dl
  brewinstall direnv

  sewing
  info "Needle is all set."
}

uninstall() {
  setup_color

  if [[ ! -d "$NEEDLE" ]]; then
    error "needle is not installed"
    exit 1
  fi

  info "delete needle from $NEEDLE"
  rm -rf "$NEEDLE"
  info "deleted, see you next time."
}

main() {
  if [[ "$1" == "--uninstall" ]]; then
    uninstall
  else
    install
  fi
}

########################################
# main
########################################
export NEEDLE=~/.needle
export NEEDLE_REPO=https://github.com/kkninjae/needle.git

main "$0"
