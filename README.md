# Needle

Needle is a tiny tool to manage dotfiles and binary installations for me.

## How to use

Install

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/setup.sh)"
```


Uninstall

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/setup.sh)" --uninstall
```


Add following line to `zshrc` or `bashrc` to load utilities in [needle.sh](needle.sh)

```sh
[ -f ~/.needle/needle.sh ] && source ~/.needle/needle.sh
```


## Customization

A shell compatible file with suffix `.plugin.sh` in `custom` directory will be loaded into your shell environment.
A good use case of using customization is to load the shell configurations you don't want to store them in git.
