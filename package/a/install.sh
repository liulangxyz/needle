#!/bin/bash

source $LIB

# create working files
files=(
  "monkey.md"
  "todo.md"
)

for file in ${files[@]}; do
  target_file="$NEEDLE_HOME/custom/$file"
  if [ ! -f "$target_file" ]; then
    info "==>" "create $file"
    touch "$target_file"
  fi
done

# essentials
brewinstall cmake
brewinstall fzf
brewinstall fd
brewinstall ag
brewinstall pt
brewinstall youtube-dl
brewinstall httpie
