
# [Blog](/) / SysAdmin / mdadm

## create volumes

Find the disks:
```
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
```

Do we already have raid volumes?
```
cat /proc/mdstat
```

If yes unmount and stop:
```
umount /dev/md0
mdadm --stop /dev/md0
```

Cleanup the headers for each disk:

```
mdadm --zero-superblock /dev/sda
mdadm --zero-superblock /dev/sdb
```

or maybe 
```
wipefs -a /dev/sda
wipefs -a /dev/sdb
```

and/or maybe
```
zpool labelclear /dev/sda
zpool labelclear /dev/sdb
```




Create a raid volume:
```
mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sda /dev/sdb
```
Levels are the classical ones: 0 stripes, 1 mirror, 5 etc

Then
```
mkfs.ext4 -F /dev/md0
mount /dev/md0 /mnt/md0
```

And store the results:
```
mdadm --detail --scan | tee -a /etc/mdadm/mdadm.conf
update-initramfs -u
echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | tee -a /etc/fstab
```

## repair volumes

Example to start with 3 disks over 4 and then add the missing one
``` 
mdadm --verbose --assemble --force  /dev/md0
mdadm --manage /dev/md0 --add /dev/nvme6n1
```


