# Installation
## install KVM and QEmu
```
sudo  apt install --no-install-recommends qemu-system libvirt-clients libvirt-daemon-system

sudo adduser $USER libvirt

sudo apt install virt-manager
```

## install vagrant

Download latest vagrant package from https://releases.hashicorp.com/vagrant

install package via ```sudo install packagename```

## install plugin:
```vagrant plugin install vagrant-libvirt```

# NFS Shared folder

Do avoid permant password request, add folling lines to ```/etc/sudoers```:

```
Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/*
Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/* /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /etc/init.d/nfs-kernel-server status
Cmnd_Alias VAGRANT_NFSD_START = /etc/init.d/nfs-kernel-server start
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
%sudo ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV,VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY
```

# Start Vagrant

- change to vagrant folder by ```cd vagrant```
- Adjust following variables in file ```Vagrantfile``` to your needs.
    - libvirt.default_prefix
    - libvirt.title
    - libvirt.storage_pool_name
- run ```vagrnat up```

## Default login data for virual machine

Username: podman

Password: podman
# Interesting links
GIT vagrant-libvirt incl. good documentation:

https://github.com/vagrant-libvirt/vagrant-libvirt

Building vagrant box:

https://unix.stackexchange.com/questions/222427/how-to-create-custom-vagrant-box-from-libvirt-kvm-instance

https://leyhline.github.io/2019/02/16/creating-a-vagrant-base-box/
