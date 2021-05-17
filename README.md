# Spinorama

You are *probably* looking after the: [spinorama](https://pierreaubert.github.io/spinorama/) gallery.

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
[code](https://github.com/pierreaubert/spinorama). Most of the
speakers data are from
[audiosciencereview.com](https://www.audiosciencereview.com/forum/index.php?forums/speaker-reviews-measurements-and-discussion.54/) aka *ASR*, [Princeton 3d3a
Lab](https://www.princeton.edu/3D3A/) and some vendors.

# AutoEQ project

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
  





