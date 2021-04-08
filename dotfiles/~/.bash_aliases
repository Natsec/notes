alias ll='ls -hAlt'

alias tree='tree -FC'
alias nano='nano -Pl'
alias ncdu='ncdu --si'

alias vmshare='vmhgfs-fuse .host:partage ./share'
alias maj='clear; apt update && apt upgrade'

# prompt cyberpunk
export PS1="\[$(tput setaf 5)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 5)\]\h\[$(tput setaf 4)\]: \W \\$ \[$(tput sgr0)\]"
