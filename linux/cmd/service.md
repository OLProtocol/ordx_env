```shell
# service
service --status-all
systemctl list-units --type=service
systemctl list-units --type=service --state=running
sudo rm -r /var/lib/systemd
systemctl disable ipfs
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl remove

```