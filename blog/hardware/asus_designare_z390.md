# Asus Designare Z390

## Networking

Netplan config:
- eno1
- enp6s0 : name is not stable if you add a new pciexpress card
- enx00e04c89aa97: 5Bb/s adapter pluggued on the Thunderbolt port
```
network:
  ethernets:
    eno1:
      dhcp4: false
      dhcp6: true
      addresses: [192.168.1.32/24]
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
    enp6s0:
      dhcp4: false
      dhcp6: true
      addresses: [192.168.1.34/24]
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
    enx00e04c89aa97:
      dhcp4: false
      dhcp6: true
      addresses: [192.168.1.33/24]
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
  version: 2
```

## Hackinthosh

Used to be hackinstosh :)



