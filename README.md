# Needle

A tool to help me setup dotfiles.


**How-to**

Install

```sh
$ git clone git@github.com:kkninjae/needle.git ~/.needle && ~/.needle/needle.sh
```

Uninstall

```sh
$ rm -rf ~/.needle
```


Load other configs into shell environment

Place any shell compatible file with suffix `.plugin.sh` in `custom` directory.
A good use case is to load customized configs but not store them in the repo.
