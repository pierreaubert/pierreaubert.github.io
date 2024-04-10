# owc mercury elite pro
*last updated: 20240410*

It is a storage enclosure for 2 disks from OWC. I have a old model
with Firewire and USB31.

It requires the uas module to be recognize on Linux.

A few usefull command

To chceck the USB tree
```
lsusb -t
```

To get the full list
```
sudo lsusb -v | less
```

And to filter by id
```
sudo lsusb -v -d 1e91:a3a8
```

The enclosure requires *uas* module to be recognize. 
This module requires usb_storage which is blacklisted
on my distro (ubuntu 22.04).

```
sudo modprobe --ignore-install usb_storage
sudo modprobe uas
```

did load the module and then the disks were visible, and zfs
partitions could be loaded:
```
sudo zpool import backup
sudo zfs load-key backupa
sudo zfs mount backup
```
did work!
