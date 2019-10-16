brewinstall python3
brewinstall pipenv

# pip
[[ ! -d ~/.pip ]] && mkdir ~/.pip
symlink "$PWD"/thread/python/pip.conf ~/.pip/pip.conf