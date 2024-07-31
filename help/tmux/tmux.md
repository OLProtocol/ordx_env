```shell
# client
ssh -t ip tmux -CC new -Asordx
ssh -t ip tmux new -Asordx
ssh root@192.168.10.103 -t tmux new -Asordx
# server
sudo apt install tmux
tmux new -Asordx
tmux detach
tmux ls
tmux rename-session -t btc-env ordx
tmux kill-window -t monitor
tmux kill-session -t main

# source install
sudo apt update && sudo apt install libncurses5-dev libevent-dev build-essential
sudo apt remove tmux
git clone git@github.com:tmux/tmux.git
cd tmux && git checkout 3.3
./configure && make && sudo make install
```