#!/bin/bash

source $LIB

echo
info "==>" "config shell"

# create working files
files=(
  "monkey.md"
  "todo.md"
)

for file in ${files[@]}; do
  target_file="$INSTALL_HOME/custom/$file"
  if [ ! -f "$target_file" ]; then
    echo "==>" "create $file"
    touch "$target_file"
  fi
done
