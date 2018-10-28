#!/bin/bash

set -e

TARGET_DIR=~/.needle

if [ ! -d "$TARGET_DIR" ]; then
  echo "needle is not installed"
  exit 1
fi

echo "==> delete needle from $TARGET_DIR"
rm -rf "$TARGET_DIR"
