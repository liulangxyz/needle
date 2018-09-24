#!/bin/bash

set -e

echo "NAME"
echo "    $SCRIPT_NAME - install and configure binaries"
echo
echo "SYNOPSIS"
echo "    $SCRIPT_NAME [command]"
echo
echo "COMMAND"
echo "    install [package]"
echo "              install and configure specified package"
echo "            --all"
echo "              install and configure all packages"
echo "    ls      list all packages it supports"
echo "    inspect [package]"
echo "              show the information related to the package"
echo "    help    show help"
exit 1
