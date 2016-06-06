source $HOME/dotfiles/WORK/functions
source $HOME/dotfiles/aliases
source $HOME/dotfiles/dockerfunc
source $HOME/dotfiles/func

if ! echo ${PATH} | grep -q /opt/opensvc/etc; then
    PATH=${PATH}:/opt/opensvc/etc
fi

if ! echo ${PATH} | grep -q /opt/opensvc/bin; then
    PATH=${PATH}:/opt/opensvc/bin
fi
