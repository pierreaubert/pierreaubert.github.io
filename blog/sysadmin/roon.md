# [Blog](/) / SysAdmin / Roon

## 2024

Roon is started via systemdctl --user

## 2020

- Updated my roon core
- Roon restarted nicely from backup
- RoonRemote is working on various devices but not on Mac Mini M1 (doesn't see any audio device)
  - opened a [ticket](https://community.roonlabs.com/t/mac-mini-m1-doesnt-show-any-audio-device/132827/6)
- How to firewall roon on Linux from [this article](https://community.roonlabs.com/t/enabling-igmp-and-broadcast-in-firewalld-for-linux-roon-server/82544):
  - opening a few ports is not enough:
  ```
  sudo ufw allow from 192.168.1.0/24 to any port 9100:9200 proto tcp
  sudo ufw allow from 192.168.1.0/24 to any port 9003 proto udp
  sudo ufw allow from 192.168.1.0/24 to any port 1900 proto udp
  ```
  - you also need to enable broadcast and IGMP
  ```
  ### IGMP ###
  -A ufw-user-input -s 224.0.0.0/4 -j ACCEPT
  -A ufw-user-input -d 224.0.0.0/4 -j ACCEPT
  -A ufw-user-input -s 240.0.0.0/5 -j ACCEPT
  -A ufw-user-input -m pkttype --pkt-type multicast -j ACCEPT
  -A ufw-user-input -m pkttype --pkt-type broadcast -j ACCEPT
  ```




