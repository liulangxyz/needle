# Needle

Needle is a tiny tool to manage my dotfiles.


**How-to**

Install

```sh
$ git clone git@github.com:kkninjae/needle.git ~/.needle
$ cd ~/.needle
$ bash setup.sh
```

Uninstall

```sh
$ cd ~/.needle
$ bash setup.sh --uninstall
```


**Customization**

A shell compatible file with suffix `.plugin.sh` in `custom` directory will be loaded into your shell environment.
A good use case of using customization is to load the shell configurations you don't want to save them in git.
