#!/bin/bash

set -e

TARGET_DIR=~/.needle

if [ -d "$TARGET_DIR" ]; then
  echo "Looks needle is already installed."
  echo "Backup $TARGET_DIR to somewhere else if you want to re-install."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "Error: git not found"
  exit 1
fi

echo "==> install needle to $TARGET_DIR"
git clone https://github.com/kkninjae/needle.git "$TARGET_DIR"

echo "==> create needle bin to /usr/local/bin/needle"
ln -sF "$TARGET_DIR/needle.sh" /usr/local/bin/needle

echo "==> install all packages"
needle install --all
