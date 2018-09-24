#!/bin/bash

set -e

for pkg_path in $NEEDLE_HOME/package/*; do
  echo "${pkg_path//*\/}"
done
