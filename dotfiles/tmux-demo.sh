# name of session
session="Demo"

# kill session if exist
tmux kill-session -t $session
# create new session and stay detached
tmux new-session -s $session -d -x - -y -

window="Monitor"
tmux rename-window -t $session:1 $window
# split first pane horizontal, then second pane vertical
tmux split-window -t $session:$window.1 -h
tmux split-window -t $session:$window.2 -v -l 80%
tmux send-keys -t $session:$window.1 "htop" C-m
tmux send-keys -t $session:$window.2 "while sleep 1; do clear; ip -br a | column -t; done" C-m
tmux send-keys -t $session:$window.3 "ping ping.me" C-m

window="Main"
# create new named window
tmux new-window -t $session -n $window
tmux split-window -t $session:$window.1 -h

# attach to session
tmux attach-session -t $session:2.2
