# Backup computers with Duplicity over FTP

## Setup FTP

on the server:
```
apt install vsftpd
```
You need to ack a bit the configuration file for systemd:

on the clients:
```
apt install lftp
```

## Add users

For each machine, here web01 as an example:

on the server
```
addgroup --gid=1010 backup-web01
addgroup --gid=1011 backup-web02
addgroup --gid=1012 backup-spin
adduser --uid=1008 --gid=1010 --home=/data/backup/web01Backup --disabled-login backup-web01
adduser --uid=1009 --gid=1011 --home=/data/backup/web02Backup --disabled-login backup-web02
adduser --uid=1010 --gid=1012 --home=/data/backup/spinBackup --disabled-login backup-spin
```
and for each user, change the pwd via the usual vault:
```
chpasswd
backup-web01:YOURSTRONGFTPPWD
ˆD
```
Setup dirs:
```
mkdir -p /data/backup/web01Backup
chmod 500 /data/backup/web01Backup
```
and for each directory you want to backup:
```
mkdir -p /data/backup/web01Backup/etc
mkdir -p /data/backup/web01Backup/home
mkdir -p /data/backup/web01Backup/scripts
chown -R backup-web01:backup-web01 /data/backup/web01Backup
```

## Setup DUPLICITY
On each client that you want to backup:
```
apt install duplicity
```
and then add a script:

```
#!/bin/sh

export PASSPHRASE=YOURSTRONGBACKUPPWD
export FTP_PASSWORD=YOURSTRONGFTPPWD
duplicity /etc ftp://backup-web01@server/etc
duplicity \
    --exclude /home/pierre/tmp \
    --exclude /home/pierre/snap \
    --exclude /home/pierre/ray \
    /home/pierre \
    ftp://backup-web01@server/home
unset PASSPHRASE
unset FTP_PASSWORD
```
note that server need to be replaced by an ip.

## Add a crontab
```
crontab -e

0 5 * * 1 cd /home/pierre && ./backup.sh
```


## Restore

```
cd /data/backup/backupMachine
mkdir restore-etc
duplicity restore file:///data/backup/backupMachine/etc ./restore-etc
```

