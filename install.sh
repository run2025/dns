#!/bin/bash

apt update && apt install dnsmasq wget -y

echo 'cache-size=0' > /etc/dnsmasq.conf

systemctl enable dnsmasq

systemctl restart dnsmasq

wget -O /bin/cdns https://github.com/run2025/dns/raw/refs/heads/main/cdns

chmod +x /bin/cdns

echo """[Unit]
Description=cdns
DefaultDependencies=no
After=network.target

[Service]
Type=simple
User=root
ExecStart=/bin/cdns -l "0.0.0.0" -p 80
Restart=always
RestartSec=5s
[Install]
WantedBy=default.target""" > /etc/systemd/system/cdns.service

systemctl enable cdns
systemctl restart cdns
