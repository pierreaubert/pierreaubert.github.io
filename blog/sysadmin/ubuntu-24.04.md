# Update to ubuntu-24.04 on Horn

No fancy ansible this time, and there are too many differences to port from 20.04 and worst from 16.04.

```
sudo apt update
sudo apt -y upgrade
```

## zfs

```
sudo apt install zfsutils-linux
sudo mkdir /data /work
sudo mkdir /data/backup
sudo mkdir /data/media
sudo chown pierre:pierre /data/backup/
sudo chown pierre:pierre /data/media/
sudo zpool import -f backup
sudo zpool import -f medisudo zpool import -f home
sudo zpool import -f work
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

## blkid for reference grouped by volume

### zfs backup raid 5
```
/dev/sdf1: LABEL="backup" UUID="16861585561829228413"  UUID_SUB="14268880325184798257" BLOCK_SIZE="4096" TYPE="zfs_member"PARTLABEL="zfs-a7e0df049fc33b6e" PARTUUID="7e34f609-b8ae-8a48-9e81-27987a126331" 
/dev/sdb1: LABEL="backup" UUID="16861585561829228413" UUID_SUB="2049209993412583254" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-c104d6967aedbb3d" PARTUUID="61f8a3ba-89c8-c244-8e87-8f74f6c2846b"
/dev/sdd1: LABEL="backup" UUID="16861585561829228413" UUID_SUB="12784991472969228394" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-01390afaa88f7b1b" PARTUUID="e7f0e5ed-ebef-7649-bf78-6b1cccb3f4a8"
```

### zfs media raid mirror
```
/dev/sde1: LABEL="media" UUID="6698701172904774082" UUID_SUB="944967298150546476" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-cf950ad3bca4bb35" PARTUUID="11a284af-8e3d-fc4f-8d28-80f06c5f444b"
/dev/sda1: LABEL="media" UUID="6698701172904774082" UUID_SUB="13991830074999727157" BLOCK_SIZE="4096" TYPE="zfs_member" PARTLABEL="zfs-1d6e96439b6484e6" PARTUUID="9df54282-6b75-8344-96d4-ebcd3d3b7267"
```

### zfs backup raid 10
```
/dev/nvme3n1p1: LABEL="work" UUID="6447172574284444008" UUID_SUB="10049175619582389020" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-093484a7ae70fd06" PARTUUID="698f250d-46de-ba49-9d62-db0cc4c26b14"
/dev/nvme6n1p1: LABEL="work" UUID="6447172574284444008" UUID_SUB="4393964242586651629" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-e74e02a3b302d1ea" PARTUUID="8f7904bd-5cce-aa47-a33a-d20c4fe39fba"
/dev/nvme5n1p1: LABEL="work" UUID="6447172574284444008" UUID_SUB="11421981052988714124" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-1eefb27a73a93d73" PARTUUID="92453157-2310-814e-9d93-943eb0441a5c"
/dev/nvme4n1p1: LABEL="work" UUID="6447172574284444008" UUID_SUB="5050779260726653372" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-b83a16f9e37adaf9" PARTUUID="3e8029de-905b-a948-b37f-171eb74c03a9"
```

### zfs home raid 10
```
/dev/nvme9n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="2775579916465248762" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-9e0156073e74746c" PARTUUID="2261a569-9850-be43-9c26-0a48f26f94af"
/dev/nvme10n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="12502172161754636498" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-37b9001abf011e4e" PARTUUID="9fc74640-dd28-a448-8845-1237caa57dc2"
/dev/nvme8n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="9022286288246295022" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-dacf78fc4407c6bc" PARTUUID="b4f7fe78-49b6-5144-b736-b0701c29ff56"
/dev/nvme7n1p1: LABEL="home" UUID="1492335504365635125" UUID_SUB="10890893935377290690" BLOCK_SIZE="512" TYPE="zfs_member" PARTLABEL="zfs-365ce9c1898f08ca" PARTUUID="ef4b8ed3-7ebc-5243-8d5b-c42061543357"
```

### other volumes
```
/dev/sdg1: UUID="e75f3131-eb50-466c-b9be-968abb6288ce" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="fe27bf1f-7798-49d7-8e0e-0df56ee00531"
/dev/nvme0n1: UUID="06374cfa-4ad9-6951-9a5b-262d000b7198" UUID_SUB="58c919ab-b9d4-14eb-12d8-83e16ad5fdeb" LABEL="horn:0" TYPE="linux_raid_member"
/dev/md127p1: UUID="D6CD-CF52" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="8f539d74-6f72-fb45-a678-0a7e41c4ce5f"
/dev/md127p2: UUID="ac0894ab-f06f-464b-8e2f-3e8b355f5812" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="92a234f6-7fa0-a04e-9a6e-f11a3447b7b2"
/dev/nvme2n1p2: UUID="88999d89-1fe3-416a-b887-d968faaf58ae" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="81993e5f-34d3-4175-888b-8e09567437e1"
/dev/nvme2n1p3: UUID="VbzgFJ-1NM7-a0w7-y8mR-0uA6-A7rC-V5ubt7" TYPE="LVM2_member" PARTUUID="48f09e8f-0dab-4136-a4a0-3b7a498fcd0a"
/dev/nvme2n1p1: UUID="4EBA-9FBC" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="72e9fd0c-3986-41db-a703-a10045540a54"
/dev/mapper/ubuntu--vg-ubuntu--lv: UUID="06539371-fd37-484f-aa17-35ed296b94d5" BLOCK_SIZE="4096" TYPE="ext4"
/dev/nvme1n1: UUID="06374cfa-4ad9-6951-9a5b-262d000b7198" UUID_SUB="4c9afb54-9e3c-3de2-b233-72759bf06fb6" LABEL="horn:0" TYPE="linux_raid_member"
```

Mount the other disks:
```
sudo mount /dev/disk/by-uuid/e75f3131-eb50-466c-b9be-968abb6288ce /data/macTimeMachine/
```


## snap

```
snap install emacs --classic
```

## drivers

NVME
```
sudo apt install -y nvme-cli
```
Currently returning only 5 disks (4 on broken pcie card, 2 out of main board)
```
nvme list

Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            S5GXNX0W542096A      Samsung SSD 980 PRO 1TB                  0x1        123.99  GB /   1.00  TB    512   B +  0 B   5B2QGXA7
/dev/nvme10n1         /dev/ng10n1           S64DNF0R533850A      Samsung SSD 980 500GB                    0x1        367.39  GB / 500.11  GB    512   B +  0 B   3B4QFXO7
/dev/nvme1n1          /dev/ng1n1            S5GXNX0W541895V      Samsung SSD 980 PRO 1TB                  0x1        123.99  GB /   1.00  TB    512   B +  0 B   5B2QGXA7
/dev/nvme2n1          /dev/ng2n1            S64DNF0R533844M      Samsung SSD 980 500GB                    0x1        229.47  GB / 500.11  GB    512   B +  0 B   3B4QFXO7
/dev/nvme3n1          /dev/ng3n1            S69ENX0W330017T      Samsung SSD 980 PRO 2TB                  0x1          1.97  TB /   2.00  TB    512   B +  0 B   5B2QGXA7
/dev/nvme4n1          /dev/ng4n1            S69ENX0W322290B      Samsung SSD 980 PRO 2TB                  0x1          1.98  TB /   2.00  TB    512   B +  0 B   5B2QGXA7
/dev/nvme5n1          /dev/ng5n1            S69ENX0W322346F      Samsung SSD 980 PRO 2TB                  0x1          1.97  TB /   2.00  TB    512   B +  0 B   5B2QGXA7
/dev/nvme6n1          /dev/ng6n1            S69ENX0W322276J      Samsung SSD 980 PRO 2TB                  0x1          1.98  TB /   2.00  TB    512   B +  0 B   5B2QGXA7
/dev/nvme7n1          /dev/ng7n1            S64DNG0R404659P      Samsung SSD 980 500GB                    0x1        379.07  GB / 500.11  GB    512   B +  0 B   3B4QFXO7
/dev/nvme8n1          /dev/ng8n1            S64DNG0R404653E      Samsung SSD 980 500GB                    0x1        379.07  GB / 500.11  GB    512   B +  0 B   3B4QFXO7
/dev/nvme9n1          /dev/ng9n1            S64DNG0R404613K      Samsung SSD 980 500GB                    0x1        366.12  GB / 500.11  GB    512   B +  0 B   3B4QFXO7
```
Note that I do not have AER errors with the ASUS card out (new one inbound).

Nvidia 4090
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
Note decision not to add the AMD and the other NVIDIA for now. Possibly more the AMD to spin.

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
sudo apt install -y git imagemagick keychain wget curl tmux mosh
sudo apt install -y npm 
sudo apt install -y python3-pip python3.12-venv
sudo apt install -y golang-go
sudo apt install -y clang
```
Note that npm, nvm, cargo, rustup are already in $HOME


## monitoring

See [here](/blog/sysadmin/monitoring.md)

## backup recovery

Nicely explained [here](backup.md)
Passwords are in the usual vault.

```
cd /data/backup/hornBackup
sudo mkdir restore
sudo duplicity restore file:///data/backup/hornBackup/etc restore/
```

## printer

```
sudo apt install cups
```

## samba

```
sudo apt install samba samba-ad-dc
```
and restore configuration from backup
```
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.maint
sudo cp /data/backup/hornBackup/restore/samba/smb.conf /etc/samba
```
Check with
```
sudo systemctl status smbd.service
```

## ftpd (via vsftpd)
```
sudo cp /data/backup/hornBackup/restore/vsftpd.conf /etc
sudo systemctl restart vsftpd.service 
```

## ubuntu pro

You can find your token on [ubuntu.com/pro](https://ubuntu.com/pro):
```
sudo pro attach <token>
```




