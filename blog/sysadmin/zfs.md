# [Blog](/) / SysAdmin / ZFS

## Creating volumes

Very simple, ex with raid0 stripped across 2 disks:
```
sudo zpool create -f work1 /dev/nvme0n1 /dev/nvme1n1
```

## Optim for Postgresql

References:
- [FreeBSD best practices](https://people.freebsd.org/~seanc/postgresql/scale15x-2017-postgresql_zfs_best_practices.pdf)
- [Bun / Uptrace](https://bun.uptrace.dev/postgres/tuning-zfs-aws-ebs.html#zfs-recordsize)
- [VADOSWARE guide](https://vadosware.io/post/everything-ive-seen-on-optimizing-postgres-on-zfs-on-linux/)

### Some basics first:
```
zpool create -o autoexpand=on pg /dev/nvme1n1
zfs create pg/data -o mountpoint=/var/lib/postgresql
zfs create pg/wal-16 -o mountpoint=/var/lib/postgresql/16/main/pg_wal
chmod 0750 /var/lib/postgresql
chmod 0750 /var/lib/postgresql/16/main/pg_wal
```
### The set a config for DB
```
zfs set recordsize=16k pg
zfs set compression=zstd-3 pg
zfs set atime=off pg
zfs set xattr=sa pg
zfs set logbias=latency pg
zfs set redundant_metadata=most pg
```
### Give 1GB or more to the ARC:
```
echo 1073741824 >> /sys/module/zfs/parameters/zfs_arc_max
```
and make it permanent by editing `/etc/modprobe.d/zfs.conf`
```
options zfs zfs_arc_max=1073741824
```

### Alignment shift

First get the data from your disk
```
nvme list
```
and then adapt *ashift* to it:
```
zpool create -o ashift=9 -o autoexpand=on pg /dev/nvme1n1
```
Note that:

ashift  | Sector size
---------------------
9       | 512 bytes
10      | 1 KB
11      | 2 KB
12      | 4 KB
13      | 8 KB
14      | 16 KB

### Postgresql.conf

Set
```
full_page_writes = off
logbias=latency
```
and restart/reload PG.

Or via psql:
```
ALTER SYSTEM SET full_page_writes=off;
CHECKPOINT;
```
