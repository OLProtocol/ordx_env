```shell
sudo systemctl restart my-service
sudo systemctl daemon-reload
sudo systemctl stop tmuxinator-ordx.service
sudo systemctl disable tmuxinator-ordx.service
sudo rm /etc/systemd/system/tmuxinator-ordx.service
sudo systemctl daemon-reload
systemctl status tmuxinator-ordx.service
systemctl list-units --type=target --all


vi /lib/systemd/system/supervisord.service
vi /etc/systemd/system/tmuxinator-ordx.service

[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
EnvironmentFile=/etc/my-service.env
ExecStart=${HOME_DIR}/bin/my-service
ExecStop=/usr/bin/supervisorctl $OPTIONS shutdown
ExecReload=/usr/bin/supervisorctl -c /etc/supervisor/supervisord.conf $OPTIONS reload
WorkingDirectory=${HOME_DIR}
User=username
KillMode=process
Restart=on-failure
RestartSec=50s

[Install]
WantedBy=multi-user.target

```