ping www.uol.com.br
route -n
sudo dhclient eth0 -v
sudo route add -net 0.0.0.0 gw 192.168.0.1 netmask 0.0.0.0 dev eth0
sudo route del -net 0.0.0.0 gw 192.168.1.1 netmask 0.0.0.0 dev eth0
route -n
ping www.uol.com.br
