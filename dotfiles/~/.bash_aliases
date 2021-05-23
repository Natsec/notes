alias ls='ls --color=auto --file-type'
alias ll='ls -hAlt'

alias grep='grep --color'
alias diff='diff --color'
alias tree='tree -FC'
alias nano='nano -Pl'
alias ncdu='ncdu --si'

alias maj='clear; apt update && apt upgrade'
alias vmshare='vmhgfs-fuse .host:partage ./share'

# prompt cyberpunk
export PS1="\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]\H\[$(tput setaf 4)\]:\w \\$ \[$(tput sgr0)\]"
# couleur de fond noire pour les Other Writable directory quand on fait ls
export LS_COLORS="${LS_COLORS}:ow=34;40"
