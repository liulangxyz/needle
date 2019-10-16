#!/bin/bash

set -e

NEEDLE=~/.needle

if [[ ! -d "$NEEDLE" ]]; then
  echo "needle is not installed"
  exit 1
fi

echo "==> delete needle from $NEEDLE"
rm -rf "$NEEDLE"