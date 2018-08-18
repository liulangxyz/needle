source $INSTALL_HOME/func.sh

brewinstall python3

PIP_CONF=~/.pip/pip.conf
mkdir -p ~/.pip
backup $PIP_CONF
linkconf $INSTALL_HOME/package/python/pip.conf $PIP_CONF
