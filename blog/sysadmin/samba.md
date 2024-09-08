# Samba

Create a new Samba user with the command:
```
sudo smbpasswd -a username.
```

Check with:
```
sudo pdbedit -L
```

And restart deamons as usual:
```
sudo systemctl restart samba.service
```

