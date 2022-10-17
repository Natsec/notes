alias woman='man'
alias l='ls -Allah'

alias lt='ls -hAlt'
alias ls='ls --color=auto --file-type'

alias grep='grep --color'
alias diff='diff --color'
alias tree='tree -FC'
alias nano='nano -P'
alias ncdu='ncdu --si -e'

alias f='sudo $(history -p !!)'
alias c='column -t'
alias dodo='sleep $(($RANDOM % 10 + 1)).$(($RANDOM % 5))'

alias maj='clear; sudo apt update && sudo apt upgrade'
alias vmshare='sudo mkdir -p /partage; sudo vmhgfs-fuse -o allow_other .host:partage /partage'
alias screenkey='pkill screenkey; screenkey --show-settings --ignore Return --ignore BackSpace --ignore Delete --ignore Tab &'

# prompt cyberpunk
grep -qi kali /etc/*release
if [ "$?" == 1 ]; then
    alias b='tput setaf 4'
    alias m='tput setaf 5'
    export PS1="\[$(m)\]\u\[$(b)\]@\[$(m)\]\H\[$(b)\]:\W \\$ \[$(tput sgr0)\]"
fi

# couleur de fond noire pour les Other Writable directory quand on fait ls
export LS_COLORS="${LS_COLORS}:ow=34;40"
