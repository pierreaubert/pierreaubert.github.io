# Update to ubuntu-24.04 on Horn

No fancy ansible this time, and there are too many differences to port from 20.04 and worst from 16.04.

```
sudo apt update
sudo apt -y upgrade
```

## zfs

```
sudo apt install zfsutils-linux
sudo mkdir /data
sudo mkdir /data/backup
sudo mkdir /data/media
sudo chown pierre:pierre /data/backup/
sudo chown pierre:pierre /data/media/
sudo zpool import -f backup
sudo zpool import -f media
sudo zpool import -f home
sudo zpool upgrade
```
and check it is clean:
```
zpool status
```

Check ownership
```
sudo chown -R pierre:pierre /home/pierre
```

## blkid for reference
```
/dev/sdf1: LABEL="backup" UUID="16861585561829228413" UUID_SUB="14268880325184798257" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-a7e0df049fc33b6e" PARTUUID="7e34f609-b8ae-8a48-9e81-27987a126331"
/dev/nvme0n1p3: UUID="VbzgFJ-1NM7-a0w7-y8mR-0uA6-A7rC-V5ubt7" TYPE="LVM2_member" PARTUUID="48f09e8f-0dab-4136-a4a0-3b7a498fcd0a"
/dev/nvme0n1p1: UUID="4EBA-9FBC" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="72e9fd0c-3986-41db-a703-a10045540a54"
/dev/nvme0n1p2: UUID="88999d89-1fe3-416a-b887-d968faaf58ae" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="81993e5f-34d3-4175-888b-8e09567437e1"
/dev/sdd1: LABEL="backup" UUID="16861585561829228413" UUID_SUB="12784991472969228394" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-01390afaa88f7b1b" PARTUUID="e7f0e5ed-ebef-7649-bf78-6b1cccb3f4a8"
/dev/nvme3n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="2775579916465248762" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-9e0156073e74746c" PARTUUID="2261a569-9850-be43-9c26-0a48f26f94af"
/dev/sdb1: LABEL="backup" UUID="16861585561829228413" UUID_SUB="2049209993412583254" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-c104d6967aedbb3d" PARTUUID="61f8a3ba-89c8-c244-8e87-8f74f6c2846b"
/dev/nvme2n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="10890893935377290690" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-365ce9c1898f08ca" PARTUUID="ef4b8ed3-7ebc-5243-8d5b-c42061543357"
/dev/sdg1: UUID="e75f3131-eb50-466c-b9be-968abb6288ce" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="fe27bf1f-7798-49d7-8e0e-0df56ee00531"
/dev/mapper/ubuntu--vg-ubuntu--lv: UUID="06539371-fd37-484f-aa17-35ed296b94d5" BLOCK_SIZE="4096" TYPE="ext4"
/dev/sde1: LABEL="media" UUID="6698701172904774082" UUID_SUB="944967298150546476" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-cf950ad3bca4bb35" PARTUUID="11a284af-8e3d-fc4f-8d28-80f06c5f444b"
/dev/nvme1n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="9022286288246295022" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-dacf78fc4407c6bc" PARTUUID="b4f7fe78-49b6-5144-b736-b0701c29ff56"
/dev/sda1: LABEL="media" UUID="6698701172904774082" UUID_SUB="13991830074999727157" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-1d6e96439b6484e6" PARTUUID="9df54282-6b75-8344-96d4-ebcd3d3b7267"
/dev/nvme4n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="12502172161754636498" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-37b9001abf011e4e" PARTUUID="9fc74640-dd28-a448-8845-1237caa57dc2"
/dev/loop1: BLOCK_SIZE="131072" TYPE="squashfs"
/dev/loop2: BLOCK_SIZE="131072" TYPE="squashfs"
/dev/loop0: BLOCK_SIZE="131072" TYPE="squashfs"
```

Mount the other disks:
```
sudo mount /dev/disk/by-uuid/e75f3131-eb50-466c-b9be-968abb6288ce /data/macTimeMachine/
```


## snap

```
snap install emacs --classic
```

## backup recovery

```
sudo apt install duplicity
```

## drivers

NVME
```
sudo apt install -y nvme-cli
```
Nvidia 
```
VERSION=550
sudo apt install -y linux-headers-$(uname -r)
sudo apt install -y nvidia-driver-${VERSION}
sudo apt install nvidia-dkms-${VERSION}
```
if dkms doesn not charge automatically:
```
candidates=$(ls -d /usr/src/nvidia-$VERSION.*)
numbers=$(basename $candidates)
sudo dkms install -m ${numbers/-/\/}
```

Sensors
```
sudo modprobe -v drivetemp
sudo apt install -y lm-sensors
sudo sensors-detect 
```

IPMI
```
sudo apt install ipmitool
```
and the setup is described [here](../hardware/asus_wrx80.md)


## add some essentials
```
sudo apt install -y vim jed
```

## network

Edit /etc/netplan/50-cloud-init.yaml 
```
network:
    ethernets:
        enp36s0f0:
            addresses:
            - 192.168.1.36/24
            nameservers:
                addresses:
                - 192.168.1.1
                search:
                - local
            routes:
            -   to: default
                via: 192.168.1.2
        enp36s0f1:
            addresses:
            - 192.168.1.37/24
            nameservers:
                addresses:
                - 192.168.1.1
                search:
                - local
    version: 2
```
and then prep it:
```
sudo netplan apply
```
and check that it works
```
networkctl status
ip a | grep 192
```

## dev basics

```
sudo apt install -y git
sudo apt install -y python3-pip python3.12-venv
sudo apt install -y golang-go
```
Note that npm, nvm, cargo, rustup are already in $HOME


## monitoring

Note that prometheus, grafana, mimir etc are running on the spin machine.
```
sudo apt install prometheus-node-exporter prometheus-blackbox-exporter prometheus-ipmi-exporter
```
In order to monitor the nvidia GPUs: look into this project. Currently running on the admin machines and not on horn.
```
cd ~/src
git clone https://github.com/utkuozdemir/nvidia_gpu_exporter.git
cd nvidia_gpu_exporter/cmd/nvidia_gpu_exporter
go build
sudo cp nvidia_gpu_exporter /usr/sbin/
cd ../../../systemd
sudo cp nvidia_gpu_exporter.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now nvidia_gpu_exporter
sudo systemctl status nvidia_gpu_exporter
```

Check that the dashboard is green in Grafana.







