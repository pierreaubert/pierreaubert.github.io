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
