```shell
# client
ssh -t ip tmux -CC new -Asmain
ssh -t ip tmux new -Asmain
# server
tmux detach
```