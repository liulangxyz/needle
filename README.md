# Needle

A tool to help me setup dotfiles.


**How-to**

Install

```sh
$ git clone git@github.com:kkninjae/needle.git ~/.needle && cd ~/.needle && sh needle.sh
```

Uninstall

```sh
$ rm -rf ~/.needle
```


Load other configs into shell environment:

A shell compatible file with suffix `.plugin.sh` in `custom` directory will be loaded into shell environment.
A good use case for this is to load customized configurations into shell environment but don't want to keep them in git.
