# ==> [/](Blog) ==> Hardware ==> Samsung SSD

## How to update the firmware on the Samsung SSD M2 ?

1. Get the iso from Samsung possibly [here](https://www.samsung.com/semiconductor/minisite/ssd/download/tools/)
2. Extract the binary from the iso and run it. Note: you can do it live but a backup is recommended.
```
mkdir /mnt/iso
sudo mount -o loop ./Samsung_SSD_980_PRO_3B2QGXA7.iso /mnt/iso/
mkdir /tmp/fwupdate
cd /tmp/fwupdate
gzip -dc /mnt/iso/initrd | cpio -idv --no-absolute-filenames
cd root/fumagician/
sudo ./fumagician
```
