#!/bin/bash

# Update repositories
sudo zypper refresh
sudo zypper update -y

# Add RPM Fusion repository (if available for openSUSE)
# Replace <release> with your openSUSE release (e.g., 15.3)
sudo zypper ar -f -n rpmfusion-free http://download1.rpmfusion.org/free/opensuse/leap/<release>/rpmfusion-free-release.rpm
sudo zypper ar -f -n rpmfusion-nonfree http://download1.rpmfusion.org/nonfree/opensuse/leap/<release>/rpmfusion-nonfree-release.rpm

# Skype
sudo zypper addrepo https://repo.skype.com/rpm/stable/skype-stable.repo
sudo zypper update -y
sudo zypper install -y skypeforlinux

# Enable Flathub
sudo zypper install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo zypper install -y chromium flameshot flameshot-fish-completion flameshot-zsh-completion
# VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper install -y code nodejs vagrant

# Docker
zypper install -y docker
systemctl start docker
usermod -aG docker $USER

# VirtualBox
sudo zypper install -y virtualbox

# VLC, Neofetch, Vagrant, Ansible, Deluge, Neovim
sudo zypper install -y vlc deluge neofetch vagrant neovim python3-neovim

# TLP
sudo zypper install -y tlp tlp-rdw

# Install software
sudo flatpak install -y flathub com.spotify.Client md.obsidian.Obsidian Postman Jetbrains.IntelliJ-IDEA-Community com.skype.Client

# Zsh and Oh My Zsh
sudo zypper install -y zsh
sudo chsh -s /bin/zsh $USER

# Install Oh My Zsh if Zsh is available
if command -v zsh &>/dev/null; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
