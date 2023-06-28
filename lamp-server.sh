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
apt-get install -y git apache2 php8.0 libapache2-mod-php8.0 mariadb-server nodejs npm yarn phpunit golang

# Install NVM (Node Version Manager)
curl -o- curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install PHPMyAdmin
apt-get install -y phpmyadmin

# Install additional PHP versions (PHP 5 and PHP 7)
apt-get install -y php5.6 php7.4

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

