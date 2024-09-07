## How to make a bootable windows usb key (2020-12-21)

- Partition a usb key with cfdisk or similar
  - One partition EFI and another with at least 8GB fat with GPT partionning
  - mkfs.fat /dev/sdX2
  - mount /dev/sdX2 /mnt/usbkey
- Copy the ISO files to the the second partition
  - sudo mount Win*.iso /mnt/cdrom
  - One file is larger than 4GB and of course doesn't fit on FAT
  - [https://wimlib.net/downloads/](wimlib) to the rescue
  - rsync -avh --progress --exclude=sources/install.wim /mnt/cdrom /mnt/usbkey
  - wimlib-imagex split /mnt/cdrom/sources/install.wim /mnt/usbkey/sources/install.swm 3800
  - eject done
- BIOS : remove secure boot and put Other OS instead of Windows since the above is not UEFI compliant.

