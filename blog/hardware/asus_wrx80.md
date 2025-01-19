# [Blog](/) / Hardware / Asus WRX80

## 2025

- more issues with the card which is slowly dying
- fans setup
  - get ip if ipmi via
  ```
  sudo ipmitool lan print
  ```
  - log in (with firefox if certificate is toasted) on `http://ip/login`
  - current mapping
    - cpu -> cooler
    - opt -> vertical fan
    - fan6 -> exhaust 
    - fan5 -> racks of fan for GPU and CPU
    - fan4 -> empty
    - fan3 -> motherboard fan (dead?)
    - fan2 -> 3x 4k (cpu cooling)
    - fan1 -> 3x 2k (disks)


## 2023

- Things were going well for 1 year and then a crash.
- The second U2 controller is faulty. I moved the disks to another
  controller from HP.
- ZFS make it a mess to replace the disks; use zpool labelclear before
  trying the replace.
- MVNE
  - For monitoring MVNE (temp included) use apt install nvme-cli which
    has a lot of features
  - Ex: nvme smart-log /dev/nvme5n1
- NVIDIA
  - Lost the driver from time to time.
  - try:
     - sudo apt install linux-headers-$(uname -r)
     - sudo apt install --reinstall nvidia-driver-535
     - sudo apt --fix-broken install
     - reboot
- SATA
  - hddtemp does not exists ...
  - use: sudo modprobe -v drivetemp
  - then sensors (from lm-sensors) works.
  - or: crazy (does a good job at id bad disks).


## 2022

- Before upgrading BIOS
 - Put the CAP file from ASUS in /boot/efi/EFI/ASUS
- After upgrading BIOS
  - U2.1 and U2.2 needs to be SATA and not PCI-E
  - 6th PCI is RAID and not 16x (that's the one with 4x NVNE)
- ZFS is amazing! Lost 2 disks today luckily under guarantee.

## 2021

- Finding a case
  - I have a BeQuiet 900 rev2 which claims to be able to host a E-ATX motherboard. That may be true but then you need to remove the hardrives ... The motherboard is 30cm x 33cm and the mini-SAS controller use another 8 cm.
  - Finding a large case is a challenge: either they are not build anymore or they are very expensive or they are not available.
  - Went for Thermaltake Core W200
- Issues with thermals (Processor is 280W, GPU is 350W ...)
  - Lots of 3k fan fixed it.
  - The SP3 cooler from Noctua is working well but it is not aligned with the natural air-flow and I will need to change it one day. The supermicro cooler should work better but is far more noisy.
  - Good that the server is in the basement.
- Issues with SATA controllers
  - It took me awhile to understand that the second sata controller is broken on this motherboard. I had to isolate disks one by one and test them 2 with 2 differents cables on 2 different controllers to be sure it was the controller.
  - I added a cheap HP HBA controller (working)
  - I also used the 2xU2 ports with a mini SAS to SATA cable (working too and much faster)
  - Over the two 4 ports sata controller, 3 are working in the first one, 1 is working on the second one.
  - I will need to send the card for an exchange and that will be a PITA.
- How to set the fan speed
  - via IPMI of course
  ```
  ipmitool -I lanplus -H 192.168.1.114 -U admin -a shell
  # noctua 15' on the cooler
  sensor thresh CPU_FAN lower 0 100 200
  sensor thresh CPU_FAN upper 1700 1800 1900
  sensor thresh CPU_OPT lower 0 100 200
  sensor thresh CPU_OPT upper 1700 1800 1900
  # noctua 3k
  sensor thresh CHA_FAN1 lower 0 100 200
  sensor thresh CHA_FAN6 lower 0 100 200
  sensor thresh CHA_FAN5 lower 0 100 200
  sensor thresh CHA_FAN1 upper 3300 3600 3900
  sensor thresh CHA_FAN6 upper 3300 3600 3900
  sensor thresh CHA_FAN5 upper 3300 3600 3900
  # top fan
  sensor thresh CHA_FAN2 lower 0 100 200
  sensor thresh CHA_FAN3 lower 0 100 200
  sensor thresh CHA_FAN2 upper 2000 2200 2400
  sensor thresh CHA_FAN3 upper 2000 2200 2400
  # disk fan
  sensor thresh CHA_FAN4 lower 0 100 200
  sensor thresh CHA_FAN4 upper 2000 2200 2400
  # soc fan (build in the motherboard)
  sensor thresh SOC_FAN lower 0 100 200
  sensor thresh SOC_FAN upper 3300 3600 3900
  # same
  sensor thresh CHIPSET_FAN lower 0 100 200
  sensor thresh CHIPSET_FAN upper 3300 3600 3900
  ```
  or if you can log on the machine:
  ```
  sudo ipmitool shell
  ```
  and the same commands
- Issue with IPMI web interface
  - Easy case: certificate are not correct and you need to use Firefox to connect and then change them.
- Change in BIOS for reference
  - PCI_5: 16 -> 4x4 for NVME
  - PCI_6: 16 -> 4x4 for NVME
  - U2: -> PCI -> SATA
- HP HBA controller
  - Need to be put in non-raid mode ...


