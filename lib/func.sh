#!/bin/bash

# log
log() {
  LOG="$INSTALL_HOME/log/install.log"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG
}

# install the brew if not installed yet
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
backup() {
  FILE=$1
  BACKUP_FILE="$1-$TIMESTAMP.org"

  # delete symbolink file first
  if [ -h "$FILE" ]; then
    rm -rf "$FILE"
  fi

  if [ -f "$FILE" ]; then
    info "==>" "backup $FILE"
    cp -p "$FILE" "$BACKUP_FILE"
    log "backup: $FILE -> $BACKUP_FILE"
    rm -rf "$FILE"
  fi
}

# symlink conf file
linkconf() {
  SOURCE="$1"
  TARGET="$2"
  backup "$TARGET"
  if [ -f "$SOURCE" ]; then
    info "==>" "symlink ${SOURCE/*\/}"
    ln -Fs "$SOURCE" "$TARGET"
    log "symlink: $SOURCE -> $TARGET"
  else
    error "$SOURCE does not exists"
  fi
}
