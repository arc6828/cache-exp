#!/bin/bash

# update
sudo apt update

# composer
sudo apt install -y php-cli unzip php-curl
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=$(curl -sS https://composer.github.io/installer.sig)
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# redis
sudo apt install -y redis-server

# Database
mysql -e "CREATE DATABASE cacheDB;"
mysql -e "CREATE USER cacheuser@localhost IDENTIFIED BY '123456789';"
mysql -e "GRANT ALL PRIVILEGES ON cacheDB.* TO 'cacheuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# PHP Extension
php --version
sudo apt install -y php8.2-fpm php8.2-mysql php-mbstring php-xml php-bcmath

# wrk
sudo apt install -y wrk
