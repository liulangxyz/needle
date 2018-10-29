#!/bin/bash

# output info message
#
# $1: string in green in output
# $2: string in default color in output
info() {
  echo $'\e[1;32m'"$1"$'\e[0m' "${@:2}"
}

# output warning message
#
# $1: string in yellow in output
# $2: string in default color in output
warn() {
  echo $'\e[1;33m'"$1"$'\e[0m' "${@:2}"
}

# output error message
#
# $1: string in red in output
# $2: string in default color in output
error() {
  echo $'\e[1;31m'"$1"$'\e[0m' "${@:2}"
}

# log
#
# $1: message
log() {
  local log="$NEEDLE_HOME/log/needle.log"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $log
}

# backup non-symbolic file
#
# $1: file to backup
backup() {
  if [ -f "$1" -a ! -L "$1" ]; then
    local backup_file="$1-$TIMESTAMP.bkp"
    mv "$1" "$backup_file"
    warn "backup" "${1//*\/}"
    log "backup: $1 -> $backup_file"
  else
    log "Warn:" "backup failed due to not a file or symbolic file: $1"
  fi
}

# symlink file
#
# $1: source file
# $2: link
linkconf() {
  if [ -f "$1" ]; then
    ln -Fs "$1" "$2"
    warn "symlink" "${1//*\/}"
    log "symlink: $1 -> $2"
  else
    error "Error:" "linkconf failed due to not a file: $1"
  fi
}

# install the brew if not installed yet
#
# $1: brew
brewinstall() {
  warn "brew install" "$1"
  if ! brew list "$1" 1>/dev/null 2>&1; then
    brew install "$1"
    log "brew install: $1"
  else
    echo "already installed"
  fi
}

# install node package if not installed yet
#
# $1: package
npminstall() {
  warn "npm install" "$1"
  if ! npm ls "$1" -g --depth 0 1>/dev/null 2>&1; then
    npm install -g "$1"
    log "npm install: $1"
  else
    echo "already installed"
  fi
}

# install python package if not installed yet
#
# $1: package
pipinstall() {
  warn "pip3 install" "$1"
  if ! pip3 show "$1" >/dev/null 2>&1; then
    pip3 install "$1"
    log "pip3 install: $1"
  else
    echo "already installed"
  fi
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
