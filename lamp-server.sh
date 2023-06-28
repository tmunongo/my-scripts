#!/bin/bash

# Update packages
apt-get update
apt-get upgrade -y

# Install Zsh and Oh My Zsh
apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set Zsh as the default shell
chsh -s $(which zsh)

# Install Apache, PHP, and other dependencies
sudo apt-get install apt-transport-https curl
sudo mkdir -p /etc/apt/keyrings
sudo curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'

sudo apt-get update

# Linux kernel headers and dev tools
sudo apt-get install linux-headers-$(uname -r) build-essential dkms

sudo apt-get install mariadb-server
apt-get install -y git apache2 php8.0 libapache2-mod-php8.0 nodejs npm yarn phpunit golang

# Install NVM (Node Version Manager)
curl -o- curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install PHPMyAdmin
apt-get install -y phpmyadmin

# Install additional PHP  versions (PHP 5 and PHP 7)
add-apt-repository -y ppa:ondrej/php
apt update
apt install php5.6 php7.4

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Configure Apache for PHPMyAdmin
echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

# Restart services
service apache2 restart
service mysql restart

# Additional provisioning steps (if needed)
# ...

