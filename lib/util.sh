#!/bin/bash

source "$NEEDLE_HOME/lib/color.sh"

# log
#
# $1: message
log() {
  local log="$NEEDLE_HOME/log/install.log"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $log
}

# install the brew if not installed yet
#
# $1: brew
brewinstall() {
  info "==>" "brew install $1"
  if ! brew list "$1" 1>/dev/null 2>&1; then
    brew install "$1"
    log "brew install: $1"
  else
    warn "already installed"
  fi
}

# backup file
#
# $1: file you want to backup
backup() {
  local backup_file="$1-$TIMESTAMP.org"
  if [ -f "$1" ]; then
    mv "$1" "$backup_file"
    log "backup: $1 -> $backup_file"
  fi
}

# symlink file
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
