#!/bin/bash
cd $(dirname $0)

get(){
    base="https://raw.githubusercontent.com/Natsec/notes/master/dotfiles"
    if echo $1 | grep '~' > /dev/null; then
        mkdir -p $(dirname $HOME${1:2})
        wget --no-verbose $base$1 -O $HOME${1:2}
    else
        sudo mkdir -p $(dirname $1)
        sudo wget --no-verbose $base$1 -O $1
    fi
    echo
}

# --------------------
# Dotfiles
# --------------------
get /~/.bash_aliases && source ~/.bash_aliases
get /~/.config/xfce4/terminal/terminalrc
get /etc/tmux.conf

# --------------------
# Paquets
# --------------------
sudo apt install tmux htop tree ncdu
