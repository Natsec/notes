alias ls='ls --color --file-type'
alias ll='ls -hAlt'

alias tree='tree -FC'
alias nano='nano -Pl'
alias ncdu='ncdu --si'
alias grep='grep --color'
alias diff='diff --color'

alias maj='clear; apt update && apt upgrade'
alias vmshare='vmhgfs-fuse .host:partage ./share'

# prompt cyberpunk
export PS1="\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]\H\[$(tput setaf 4)\]: \W \\$ \[$(tput sgr0)\]"
