# Highpoint controllers

## SSD7749M (8x nvme pci4)

### Install

After installing the driver, you also need a
```
update-initramfs -u
```
if not the system see all disks as a JBOD.

Then follow instructions to create the raid array.

Software is
```
hptraidconf
```

and web one is on
```
http://192.168.1.36:7402/
```

### Troubleshoot

```
lspci -tvv
```
should show you the disk below the controller and not above it.


## 6438TS (8x SATA or SAS)


