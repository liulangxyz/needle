#!/bin/bash

# output info message
#
# $1: string in green in output
# $2: string in default color in output
info() {
  echo $'\e[1;32m'"$1"$'\e[0m' "${@:2}"
}

# output warning message
#
# $1: string in yellow in output
# $2: string in default color in output
warn() {
  echo $'\e[1;33m'"$1"$'\e[0m' "${@:2}"
}

# output error message
#
# $1: string in red in output
# $2: string in default color in output
error() {
  echo $'\e[1;31m'"$1"$'\e[0m' "${@:2}"
}
