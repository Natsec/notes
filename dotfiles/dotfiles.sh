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
get /etc/tmux.conf
get /~/.bash_aliases && source ~/.bash_aliases
get /~/.config/autostart/picom.desktop
get /~/.config/xfce4/terminal/terminalrc

# --------------------
# Paquets
# --------------------
sudo apt update
sudo apt install htop tmux tree ncdu neofetch && clear && neofetch
