#!/bin/bash

source $LIB

# create working files
files=(
  "monkey.md"
  "todo.md"
)

for file in ${files[@]}; do
  target_file="$INSTALL_HOME/custom/$file"
  if [ ! -f "$target_file" ]; then
    info "==>" "create $file"
    touch "$target_file"
  fi
done
