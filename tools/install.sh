#!/bin/bash

set -e

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

echo "==> install needle to $TARGET_DIR"
git clone https://github.com/kkninjae/needle.git "$TARGET_DIR"

echo "==> setup configs"
"$TARGET_DIR/needle.sh"
