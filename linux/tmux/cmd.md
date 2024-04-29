```shell
# client
ssh -t ip tmux -CC new -Asordx
ssh -t ip tmux new -Asordx
# server
tmux new -Asordx
tmux detach
tmux ls
tmux rename-session -t btc-env ordx
tmux kill-window -t monitor
tmux kill-session -t main
```