#!/bin/bash

set -e

SCRIPT="$0"

if [ -h "$SCRIPT" ]; then
  SCRIPT=$(readlink "$SCRIPT")
fi

if [ "${SCRIPT:0:2}" = './' ]; then
  SCRIPT="${SCRIPT:2}"
  SCRIPT="$(pwd)/${SCRIPT}"
fi

if [ "${SCRIPT:0:1}" != '/' ]; then
  SCRIPT="$(pwd)/$SCRIPT"
fi

export SCRIPT_NAME="${SCRIPT//*\/}"
export NEEDLE_HOME="${SCRIPT%\/*}"
export TIMESTAMP=$(date '+%Y%m%d%H%M%S')
export LIB=$NEEDLE_HOME/lib/import.sh

case "$1" in
  install )
    /bin/sh "$NEEDLE_HOME/cli/install.sh" "$2"
    ;;
  inspect )
    /bin/sh "$NEEDLE_HOME/cli/inspect.sh" "$2"
    ;;
  ls )
    /bin/sh "$NEEDLE_HOME/cli/ls.sh"
    ;;
  * )
    /bin/sh "$NEEDLE_HOME/cli/help.sh"
    ;;
esac
