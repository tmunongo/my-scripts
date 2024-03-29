#!/bin/bash

# update repos
sudo dnf update -y
sudo dnf upgrade -y
# add rpm fusion
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf upgrade --refresh
# enable Flathub
sudo dnf -y install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf groupupdate core
# software installation
sudo flatpak install -y flathub com.spotify.Client Skype IntelliJ
sudo dnf -y install chromium flameshot kitty
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf -y install code
sudo dnf -y module reset nodejs
sudo dnf -y install nodejs

# docker
sudo dnf -y install dnf-plugins-core
sudo dnf -y config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# VirtualBox
sudo dnf -y install @development-tools
sudo dnf -y install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
cat <<EOF | sudo tee /etc/yum.repos.d/virtualbox.repo 
[virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
EOF
sudo dnf search virtualbox
sudo dnf -y install VirtualBox
sudo dnf install akmod-VirtualBox kernel-devel-$(uname -r)
sudo usermod -a -G vboxusers $USER
newgrp vboxusers

# skype
sudo curl -o /etc/yum.repos.d/skype-stable.repo https://repo.skype.com/rpm/stable/skype-stable.repo
sudo dnf -y install skypeforlinux

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install vagrant

sudo dnf -y install vlc neofetch ansible neovim python3-neovim deluge

# NVIDIA Drivers (open source)


# rofi power menu
git clone https://github.com/jluttine/rofi-power-menu.git
cp rofi-power-menu ~/.local/bin/rofi-power-menu

# Remove Libre Office and install WPS Office
# sudo dnf -y remove libreoffice*
# sudo dnf -y install https://linux.mirrors.es.net/wps-office/11/x86_64/wps-office-11.1.0.10740-1.x86_64.rpm

sudo dnf -y install tlp tlp-rdw

# zsh and oh my zsh
sudo dnf -y install zsh
sudo lchsh /bin/zsh $USER

if [ -x "S(command -v zsh)" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
