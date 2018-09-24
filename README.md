# Needle

A convenient tool to help setup different development tools on MacOS.


## How-to

Install

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/tools/install.sh)"
```


Uninstall

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kkninjae/needle/master/tools/uninstall.sh)"
```


Usage of needle

```sh
# inspect a package
$ needle inspect [package]

# list all supported packages
$ needle ls

# show help
$ needle help
```


## Customization

Any file with suffix `rc.sh` in `custom` directory will be loaded into zsh.
