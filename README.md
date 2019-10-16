# Needle

Needle is a tiny framework to manage dotfiles and binary installations in a single place.

## How-to

TBD


## Installation

Install

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/tools/install.sh)"
```


Uninstall

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/tools/uninstall.sh)"
```


## Customization

A shell compatible file with suffix `.plugin.sh` in `custom` directory will be loaded into your shell environment. A good use case of using customization is to load the shell configurations you don't want to store them in git.
