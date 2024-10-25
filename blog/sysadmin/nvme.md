# [Blog](/) / SysAdmin / NVME

## block size

```
nvme id-ns -H /dev/nvme0n1
```
may yield something like:

```
LBA Format  0 : Metadata Size: 0   bytes - Data Size: 512 bytes - Relative Performance: 0x2 Good  (in use)
LBA Format  1 : Metadata Size: 0   bytes - Data Size: 4096 bytes - Relative Performance: 0x1 Better
```

which means the disk support 2 block sizes.
If so, you can change it with:
```
nvme format --lbaf=1 /dev/nvme0n1
```
note: this will format the disk.

## nvme over tcp


