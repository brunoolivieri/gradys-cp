# gradys-cp

Configurations of the SBC of GrADyS companion computers

v0.5

---

RPI based on bullseye

SO updated on 26/05/2022

Rpanion server, but from the PR pf KMZ_LOG_FILE on brunoolivieri fork: 69b7a411bd478de6dfe95caf0925cea382acb092

---

Instead of mavlink-router manually, we inserted some Rpainion Outputs (which uses mavlink-router):

Destination IP:Port	Action
127.0.0.1:14540	Required for Rpanion-server
0.0.0.0:17171
0.0.0.0:17172
0.0.0.0:17173
192.168.1.100:55555
0.0.0.0:14550

---

keys in place and authorized_keys as well

---

Adhoc did not appeared with wlan1. Changed the dongle to RT5370


adhoc with rpanion is locked into wlan0 only.
