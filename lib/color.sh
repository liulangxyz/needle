#!/bin/bash

# print green output
info() {
  echo $'\e[1;32m'"$1"$'\e[0m' "${@:2}"
}

# print yellow output
warn() {
  echo $'\e[1;33m'"$1"$'\e[0m' "${@:2}"
}

# print red output
error() {
  echo $'\e[1;31m'"$1"$'\e[0m' "${@:2}"
}
