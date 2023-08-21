# Spinorama

You are *probably* looking after the: [spinorama](https://www.spinorama.org/) gallery.

It is a collection of loudspeakers measurements. They can
help you to make an educated decision when you want to purchase a
speaker. Price and quality are very loosely related. I do not have 
specific recommendations but I would buy for myself:

### For a bookshelves or desk speaker:
- [JBL 306P](https://pierreaubert.github.io/spinorama/JBL%20306P%20Mark%20ii/ASR/index_asr.html)
  for a cheap and good one.
- [Kali IN-8](https://pierreaubert.github.io/spinorama/Kali%20IN-8/ASR/index_asr.html)
  with some more money.
- For cost no object, I would go for [Genelec 8341](https://pierreaubert.github.io/spinorama/Genelec%208341A/ASR/index_asr.html)

### Floorstanders or large speaker:

- In the US, I would likely buy a pair of Revel.
- In Europe, I baught larger Genelec (8361).

The website is generated from this
[code](https://github.com/pierreaubert/spinorama). Most of the speakers data are from
[audiosciencereview.com](https://www.audiosciencereview.com/forum/index.php?forums/speaker-reviews-measurements-and-discussion.54/) aka *ASR*, [Princeton 3d3a
Lab](https://www.princeton.edu/3D3A/), [Erin's audio corner]()https://www.erinsaudiocorner.com/ and some vendors (JBL, Genelec, Neumann, FBT, ...).

# Reviews or data analysis

- [Alcons Audio RR12 Line array](/blog/reviews/20221113-Alcons-Audio-beamforming/index.html)
- [FBT Promaxx Serie](/blog/reviews/20221105-FBT-Promaxx/index.html)
- [JBL PRX900 Serie](/blog/reviews/20221103-JBL-PRX900/index.html)

# Shape Optimisation project (for speakers)

I used to to some shape optimisation long time ago for my PhD. This [post](https://www.audiosciencereview.com/forum/index.php?threads/simulation-overview-loudspeakers-design-via-shape-and-topology-optimization.23453/) motivated me to go back to it.

Comsol or Mathematica are too expensive for my taste esp. with a lot of cores. I decided to leverage awesome open source softwares and write an open source project to optimise horns to start with.

- (2021-07-23) More reading: how to precondition Helmhotz? also read about other optimisation (matric reduction and parametrisation)
- (2021-07-22) More reading: read the fireshape documentation and code, also had a peak at ROM.
- (2021-07-20) Same code is working in parallel. 2D is super fast on a core i9 9900K and 3D is slow but doable. Memory and memory bandwidth are an issue. It also works well on Threadripper pro, memory issues are gone.
- (2021-07-20) Did a lot of reading.
  - Code is now working to solve the state problem (Helmhotz) in 2D. I used features from my other project to generate spinorama and contour plots.
- (2021-06-05) That's me trying to remember things from the past.
  - Code is [here](https://github.com/pierreaubert/sh-op-horn).
  - I am following the tutorial from Mathematica but I implement it in Python with open source solutions (gmsh and firedrake).
  - Here is the mesh for a half horn (due to the symmetry the problem is computed in 2D and only half of it).
  - If I can solve it properly I will of course go 3D.

# AutoEQ project

- (2023-08-01) Global optimiser is working significantly better than
  the greedy optimiser. Score computations have been ported to Cython
  for performance
- (2022-12-29) Automatic way to guess smoothness of curves
- (2022-05-26) Debug target again and try to decrease preamp changes.
- (2022-05-05) Corrected the rear reflections which are incorrect in the standard
- (2021-09-06) Added a second optimisation algorithm that gives better results :)
- (2021-04-10) Investigated how to find a target (or set of targets) that maximize the score. Use ray[tune] and random grid to find automatically optimum targets. That's different than for a given target, find the optimal EQ.
- (2021-01-30) Investigated why some speakers don't eq well. Not sure about the answer yet but mostly:
  - the target is critical and the system is not smart enough to guess it correctly each time.
  - zones where the crossovers or port resonance are generating large non linearity should be ignored.
- (2021-01-17) Build a script that compute all EQs :)
  - [Results](https://github.com/pierreaubert/spinorama/tree/develop/datas/eq) are in text files called iir-autoeq.txt (compatible with Equalizer APO).
  - The script around the algorithm has a fair number of knobs to play with.
- (2021-01-13) Found a working algorithm that generates EQ as good as made by hand :)
  - Greedy algorithm
  - Use simmulated annealing at each steps
  - Optimise for flat LW and smooth PIR
  - 2 min per speaker max on 1 core
  - 14 min for all eqs on all cores
  - Now things are easy :)
- (2021-01-09) Added local optimization with a gradient to see if I can get a better optimum.
  - answer is surprising and is NO.
  - I don't understand why yet.
- (2021-01-02) Optimised Listening Window with a series of PEQ. Tried various strategies:
  1. Greedy algorithm: start with the highest **peak** and optimised for this one. Iterate.
  2. Greedy algorithm: start with the highest **area** and optimised for this one. Iterate.
  3. Optimise for L2 norm or optimised for R**2 (from linear regression on LW)
  5. Same as above with a constraint on On Axis (need to stay flat)

# Spinorama project

- (2021-04-10) added some featues
  - added links to original reviews and others if I have them
  - added horizontal and vertical views for coaxial speakers that you can return and a few others like Focal Twin6 Be.
- (2021-04-01) added some features
  - Compute directivity in degree such that it minimize the difference between -6dB and a flat line over a frequency range. That make it less random that doing it by hand and it generates significantly different results.

# Working in slices of 20 minutes

I have always been good at focusing on 1 thing for hours. Since this projects are personal and not work related, I do not have much time and when I have that's always in very short slices of time.
I devised a methodology to work like that and if it requires rigor it is working pretty well. It is very frustrating way to work but I have made progress.

TODO

# Logs

## server board Asus WRX80 (2023-08)

- Things were going well for 1 year and then a crash.
- The second U2 controller is faulty. I moved the disks to another
  controller from HP.
- ZFS make it a mess to replace the disks; use zpool labelclear before
  trying the replace.
- MVNE
  - For monitoring MVNE (temp included) use apt install nvme-cli which has a lot of features
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


## server board Asus WRX80 (2022-05-05)

- Before upgrading BIOS
 - Put the CAP file from ASUS in /boot/efi/EFI/ASUS
- After upgrading BIOS
  - U2.1 and U2.2 needs to be SATA and not PCI-E
  - 6th PCI is RAID and not 16x (that's the one with 4x NVNE)
- ZFS is amazing! Lost 2 disks today luckily under guarantee.

## mac M1 (2022-05-05)

- Roon is broken again 

## server board Asus WRX80 (2021-08-17)

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
- Issue with IPMI web interface
  - Easy case: certificate are not correct and you need to use Firefox to connect and then change them.
- Change in BIOS for reference
  - PCI_6: 16 -> 4x4 for NVME
  - U2: -> PCI -> SATA
- HP HBA controller
  - Need to put in non-raid mode ...


## macOS 11.2 fix most of my issues but not all (2021-02-10)
 The mac mini is still slow and it make it impossible to use with Reaper and a few plugins. Logic is working better but still not great.

## Seriously unhappy with my imac M1 (2020-12-26)
 My new imac crash once or twice a day, becomes unresponsive etc. That's kernel crashes. I hope Apple will fix most of them in next version of Big Sur.

## Fixing xcodebuild (2020-12-26)
 On a new mac I never remember how to install xcode and command
 line. I ended up with an errorw which
 ```
 xcode-select --install
 sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
 sudo xcodebuild -license accept
 ```
 fixed.

## Markdown development (2020-12-26)

- Discovered grip server to preview markdown files
- [Installed](https://github.com/pierreaubert/workbench/commit/4098646f268d396de9bd29331e5fb91f9a57b707#diff-d8951da430c285ff25113e010d9227b1b9a16bf9067f040072145bbe46a8c507) markdown-mode and grip-mode for Emacs

## Nice trick to cleanup a git repo and keeping only the last commit (2020-12-21)

- See this
  [article](https://stackoverflow.com/questions/9683279/make-the-current-commit-the-only-initial-commit-in-a-git-repository)
  on stackoverflow.

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

## Installing ray on Big Sur on a ARM mac mini (2020-12-21)

- Not fun
- Redis need a patch or crash at the start
- python3.8 is ok but 3.9 is not (?)
- Install ray from source did work

## Roon is no fun (2020-12-21)

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
  





