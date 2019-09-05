#!/bin/bash

set -e

CURR_DIR="$PWD"
TARGET_DIR=~/.needle

if [ -d "$TARGET_DIR" ]; then
  echo "Looks needle is already installed."
  echo "Backup $TARGET_DIR to somewhere else first and then re-execute."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "Error: git not found"
  exit 1
fi

git clone https://github.com/kkninjae/needle.git "$TARGET_DIR"
cd "$TARGET_DIR"
# have to execute under needle directory since configs rely on this relative file path
sh ./needle.sh
cd "$CURR_DIR"