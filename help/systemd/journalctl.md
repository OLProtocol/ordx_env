```shell
sudo journalctl -u tmuxinator-ordx.service --since "2024-08-16 09:00:00" --until "2024-08-16 10:00:00" -n 50
sudo journalctl
sudo journalctl -u tmuxinator-ordx.service -f
sudo journalctl -u tmuxinator-ordx.service -p err

```
