#!/bin/bash

# Enable IPv4 and IPv6 forwarding (feature):
sysctl net.ipv4.ip_forward=1
sysctl net.ipv6.conf.default.forwarding=1
sysctl net.ipv6.conf.all.forwarding=1

# Set up NAT:
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT


# THIS REQUIRES KERNEL HEADERS INSTALLED (build-essentials is a nice to have)
# sudo apt-get update
# sudo apt install raspberrypi-kernel-headers build-essentials
