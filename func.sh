# print green output
info() {
  echo $'\e[1;32m'"$@"$'\e[0m'
}

# print yellow output
warn() {
  echo $'\e[1;33m'"$@"$'\e[0m'
}

# print red output
error() {
  echo $'\e[1;31m'"$@"$'\e[0m'
}

# install the brew if not installed yet
brewinstall() {
  echo "==> install $1"
  if ! brew info "$1" 1>/dev/null 2>&1; then
    brew install "$1"
  else
    warn "already installed"
  fi
}

# backup old non-symbolic file
backup() {
  if [ -f "$1" -a ! -h "$1" ]; then
    echo "==> backup $1"
    cp -vp "$1" "$1-$TIMESTAMP.org"
    # record the backup logs
    echo "$1-$TIMESTAMP.org" >> $INSTALL_HOME/package/custom/backup.log
  fi
}

# symlink conf file
linkconf() {
  backup "$2"
  if [ -f "$1" ]; then
    echo "==> link $1"
    ln -Fsv "$1" "$2"
  else
    error "$1 does not exists"
  fi
}
