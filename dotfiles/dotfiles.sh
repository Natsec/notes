#!/bin/bash
cd $(dirname $0)

get(){
    base="https://raw.githubusercontent.com/Natsec/notes/master/dotfiles"
    if echo $1 | grep '~' > /dev/null; then
        mkdir -p $(dirname $HOME${1:2})
        wget --no-verbose $base$1 -O $HOME${1:2}
    else
        mkdir -p $(dirname $1)
        wget --no-verbose $base$1 -O $1
    fi
    echo
}


get /etc/tmux.conf
get /~/.config/autostart/compton.desktop
get /~/.config/xfce4/terminal/terminalrc
