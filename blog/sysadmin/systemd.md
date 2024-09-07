# SystemD

## Usefull commands

### Find all the errors:

```
systemctl list-units --failed
```
or
```
systemctl list-units --state failed
```

### Logs for a service

```
journalctl -u x.service
```
Kernel
```
journalctl -k
```
Live
```
journalctl -f
```

### Debug a service

```
journalctl --catalog --pager-end --unit=x.service
```

## Credential management

1. Check HW capabilities
```
systemd-creds has-tpm2
```

if library is not available:
```
sudo apt install tpm2-abrmd
```

You should see somthing like:
```
pierre@horn:~/src/pierreaubert.github.io$ sudo systemd-creds has-tpm2
yes
+firmware
+driver
+system
+subsystem
+libraries
```

2. Store secret

For service xyz, as root:
```
mkdir /etc/systemd/system/xyz.service.d
systemd-ask-password -n | ( echo "[Service]" && systemd-creds encrypt --name=password -p - - ) > /etc/systemd/system/xyz.service.d/50-password.conf
```
since the configuration file is in the default location, it is picked up automatically. You can now edit the config
```
sudo systemctl edit xyz.config
```
and remove the following lines:
```
Environment *
EnvironmentFile *
```


and the usual
```
systemctl daemon-reload
systemctl restart xyz.service
```
