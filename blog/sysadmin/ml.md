# NVIDIA GPU

When the driver does not load properly:
```
#!/bin/sh

ubuntu-drivers devices

VERSION=550

apt install --reinstall nvidia-driver-${VERSION}
apt install linux-headers-$(uname -r)
apt --fix-broken install
apt install nvidia-dkms-${VERSION}

candidates=$(ls -d /usr/src/nvidia-$VERSION.*)
numbers=$(basename $candidates)
sudo dkms install -m ${numbers/-/\/}
```


# AMD GPU

## rocM setup

```
wget https://repo.radeon.com/amdgpu-install/6.2/ubuntu/noble/amdgpu-install_6.2.60200-1_all.deb
sudo apt install ./amdgpu-install_6.2.60200-1_all.deb
sudo apt install amdgpu-dkms rocm
```

# Software

## ollama setup

I use the snap on ubuntu

To configure the host:
```
sudo snap set ollama host=192.168.1.37
```

To configure the directory where models are stored:
```
sudo snap set ollama models=/work/ml/.ollama/
```

## continue setup



