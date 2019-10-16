brewinstall python3
brewinstall pipenv

# pip
[[ ! -d ~/.pip ]] && mkdir ~/.pip
symlink "$NEEDLE"/thread/python/pip.conf ~/.pip/pip.conf