# dotfile

My setup of Mac OS development environment.


## How-to

Install all packages

```sh
$ git clone https://github.com/kkninjae/dotfile.git ~/.dotfile

$ cd ~/.dotfile

$ ./needle.sh install
```


Install a specified package

```sh
$ ./needle.sh install [package]
```


Show package information

```sh
$ ./needle.sh info [package]
```


Show supported packages

```sh
$ ./needle.sh ls
```


## Customization

Any file with suffix `rc.sh` in `custom` directory will be loaded into zsh when
starting any zsh process.
