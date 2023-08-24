#!/bin/bash

# Update repositories
sudo zypper refresh
sudo zypper update

# Add RPM Fusion repository (if available for openSUSE)
# Replace <release> with your openSUSE release (e.g., 15.3)
sudo zypper ar -f -n rpmfusion-free http://download1.rpmfusion.org/free/opensuse/leap/<release>/rpmfusion-free-release.rpm
sudo zypper ar -f -n rpmfusion-nonfree http://download1.rpmfusion.org/nonfree/opensuse/leap/<release>/rpmfusion-nonfree-release.rpm

# Enable Flathub
sudo zypper install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install software
sudo flatpak install -y flathub com.spotify.Client
sudo zypper install -y chromium flameshot
sudo zypper addrepo -f https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper install -y code
sudo zypper install -y nodejs

# Docker
sudo zypper install -y docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# VirtualBox
sudo zypper install -y virtualbox

# Skype
sudo zypper ar -cfp 90 https://repo.skype.com/rpm/stable/skype-stable.repo
sudo zypper install -y skypeforlinux

# VLC, Neofetch, Vagrant, Ansible, Neovim
sudo zypper install -y vlc neofetch vagrant neovim python3-neovim

# TLP
sudo zypper install -y tlp tlp-rdw

# Zsh and Oh My Zsh
sudo zypper install -y zsh
sudo chsh -s /bin/zsh $USER

# Install Oh My Zsh if Zsh is available
if command -v zsh &>/dev/null; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
