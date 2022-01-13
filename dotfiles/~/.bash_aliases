alias ls='ls --color=auto --file-type'
alias ll='ls -hAlt'

alias grep='grep --color'
alias diff='diff --color'
alias tree='tree -FC'
alias nano='nano -Pl'
alias ncdu='ncdu --si'

alias f='sudo $(history -p !!)'
alias c='column -t'
alias dodo='sleep $(($RANDOM % 10 + 1)).$(($RANDOM % 5))'

alias maj='clear; sudo apt update && sudo apt upgrade'
alias vmshare='sudo mkdir -p /partage; sudo vmhgfs-fuse -o allow_other .host:partage /partage'
alias screenkey='pkill screenkey; screenkey --show-settings --ignore Return --ignore BackSpace --ignore Delete --ignore Tab &'

# prompt cyberpunk
export PS1="\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]\H\[$(tput setaf 4)\]:\W \\$ \[$(tput sgr0)\]"
# couleur de fond noire pour les Other Writable directory quand on fait ls
export LS_COLORS="${LS_COLORS}:ow=34;40"
