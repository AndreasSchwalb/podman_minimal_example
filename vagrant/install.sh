username=podman
password=podman

apt update -y
apt upgrade -y


# add user
adduser --gecos "" --disabled-password $username
echo -e "$password\n$password" | sudo passwd $username 
usermod -aG sudo $username

#copy keyboard layout
cp /home/vagrant/configs/keyboard /etc/default/keyboard


#install podman
apt install -y podman
mkdir /home/$username/podman
cd /home/$username/podman
wget http://ftp.us.debian.org/debian/pool/main/libp/libpod/podman_3.3.1+ds2-1_amd64.deb
wget http://ftp.us.debian.org/debian/pool/main/libp/libpod/podman-docker_3.3.1+ds2-1_amd64.deb
dpkg -i podman_3.3.1+ds2-1_amd64.deb
dpkg -i podman-docker_3.3.1+ds2-1_amd64.deb

apt install -y git \
  btrfs-progs \
  git \
  golang-go \
  go-md2man \
  iptables \
  libassuan-dev \
  libbtrfs-dev \
  libc6-dev \
  libdevmapper-dev \
  libglib2.0-dev \
  libgpgme-dev \
  libgpg-error-dev \
  libprotobuf-dev \
  libprotobuf-c-dev \
  libseccomp-dev \
  libselinux1-dev \
  libsystemd-dev \
  pkg-config \
  runc \
  uidmap \
  make
  
git clone https://github.com/containers/podman/
cd podman
make BUILDTAGS="selinux seccomp"

mv /usr/bin/podman /usr/bin/podman_bak
sudo make install PREFIX=/usr
mv /usr/bin/podman /usr/bin/podman_34
mv /usr/bin/podman_bak /usr/bin/podman

#install docker-compose
apt install -y curl
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#install xfce
apt install -y xfce4 spice-vdagent qemu-guest-agent

#install basic tools
apt install -y xfce4-terminal vim mc fzf ripgrep thunar rofi aptitude firefox-esr

#config xfce
mkdir -p /home/$username/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/vagrant/configs/xfce4/xsettings.xml /home/$username/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/vagrant/configs/xfce4/xfce4-keyboard-shortcuts.xml /home/$username/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/vagrant/configs/xfce4/xfce4-panel.xml /home/$username/.config/xfce4/xfconf/xfce-perchannel-xml/
chown -R $username:$username /home/$username/.config

#add stuff for auto resize
cp /home/vagrant/configs/50-x-resize.rules /etc/udev/rules.d/
cp /home/vagrant/configs/x-resize /usr/local/bin/
chmod +x /usr/local/bin/x-resize


#install vs code
apt install -y gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt install apt-transport-https
apt update -y
apt install -y code

#install vs code extentions
sudo --user=$username code --install-extension ms-python.python

#get podman repo from github
mkdir /home/$username/Desktop 
chown $username:$username /home/$username/Desktop
cd /home/$username/Desktop
sudo -u $username git clone https://github.com/AndreasSchwalb/podman_minimal_example.git

#reboot system
/usr/sbin/reboot

