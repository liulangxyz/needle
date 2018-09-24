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

git clone https://github.com/kkninjae/needle.git "$TARGET_DIR"
/bin/bash "$TARGET_DIR/needle.sh install"
