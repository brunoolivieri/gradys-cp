# gradys-cp

Configurations of the SBC of GrADyS companion computers

v0.2

mainly using Repo QUADPI

pymavlink installed and running

Mavlink-router - excellent change!

Logs on ~/flights-logs

---

pi@uav21:~ $ cat /etc/mavlink-router/main.conf

[General]
Log=/home/pi/flights-logs
MavlinkDialect=ardupilotmega

[UartEndpoint to_fc]
Device = /dev/serial0
Baud = 115200

[UdpEndpoint to_14550_external]
Mode = eavesdropping
Address = 0.0.0.0
Port = 14550
PortLock = 0

[UdpEndpoint to_scripts_1]
Mode = Normal
Address = 0.0.0.0
Port = 17171
PortLock = 0

[UdpEndpoint to_scripts_2]
Mode = Normal
Address = 0.0.0.0
Port = 17172
PortLock = 0

[UdpEndpoint to_ground_station]
Mode = Normal
Address = 192.168.0.147
Port = 55555
PortLock = 0


---

network with an external dipol antenna:

pi@uav21:~ $ cat /etc/network/interfaces

#source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback

iface wlan0 inet manual

auto wlan1
iface wlan1 inet static
address 192.168.1.21
netmask 255.255.255.0
gateway 192.168.1.1
wireless-channel 4
wireless-essid uavnet
wireless-mode ad-hoc

---



pi@uav21:~ $ free -h
              total        used        free      shared  buff/cache   available
Mem:          3.7Gi        47Mi       3.6Gi       8.0Mi       128Mi       3.6Gi
Swap:          99Mi          0B        99Mi


pi@uav21:~ $ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        29G  4.2G   24G  15% /
devtmpfs        1.8G     0  1.8G   0% /dev
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           1.9G  8.5M  1.9G   1% /run
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/mmcblk0p1  253M   48M  205M  19% /boot
tmpfs           383M     0  383M   0% /run/user/1000



---






GroundStation:

GrADyS-GS

rpi-gateway:  192.168.0.100 on internet network and 192.168.1.1 on ad-hoc network


pi@groundstation:~ $ cat rpi-gateway.sh

_#!/bin/bash

_# Enable IPv4 and IPv6 forwarding (feature):
sysctl net.ipv4.ip_forward=1
sysctl net.ipv6.conf.default.forwarding=1
sysctl net.ipv6.conf.all.forwarding=1

_# Set up NAT:
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

_# THIS REQUIRES KERNEL HEADERS INSTALLED (build-essentials is a nice to have)
_# sudo apt-get update
_# sudo apt install raspberrypi-kernel-headers build-essentials



pi@groundstation:~ $ cat /etc/network/interfaces

auto lo
iface lo inet loopback

auto eth0
allow-hotplug eth0
iface eth0 inet static
address 192.168.0.100
netmask 255.255.255.0
gateway 192.168.0.1

iface wlan0 inet manual

auto wlan1
iface wlan1 inet static
address 192.168.1.1
netmask 255.255.255.0
wireless-channel 4
wireless-essid uavnet
wireless-mode ad-hoc
