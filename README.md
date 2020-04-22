# Needle

Needle is a tiny tool to manage dotfiles and binary installations for me.

## Installation

Remotely

```sh
# install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/setup.sh)"
# uninstall
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/setup.sh)" --uninstall
```


Locally

```sh
$ git clone https://github.com/kkninjae/needle.git ~/.needle
$ cd ~/.needle
$ bash setup.sh
```


## Customization

A shell compatible file with suffix `.plugin.sh` in `custom` directory will be loaded into your shell environment.
A good use case of using customization is to load the shell configurations you don't want to save them in git.
