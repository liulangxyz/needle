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

# log to a specified file or global log file if not specified
#
# $1: message
# $2: file
log() {
  local log="$INSTALL_HOME/log/install.log"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $log
}

# install the brew if not installed yet
#
# $1: brew
brewinstall() {
  info "==>" "install $1"
  if ! brew list "$1" 1>/dev/null 2>&1; then
    brew install "$1"
    log "brew install: $1"
  else
    warn "already installed"
  fi
}

# backup old non-symbolic file
#
# $1: file you want to backup
backup() {
  local backup_file="$1-$TIMESTAMP.org"

  # delete symbolink file first
  if [ -h "$1" ]; then
    rm -rf "$1"
  fi

  if [ -f "$1" ]; then
    info "==>" "backup ${1//*\/}"
    cp -p "$1" "$backup_file"
    log "backup: $1 -> $backup_file"
    rm -rf "$1"
  fi
}

# symlink conf file
#
# $1: source file
# $2: link
linkconf() {
  backup "$2"
  if [ -f "$1" ]; then
    info "==>" "symlink ${1//*\/}"
    ln -Fs "$1" "$2"
    log "symlink: $1 -> $2"
  else
    error "$1 does not exists"
  fi
}
