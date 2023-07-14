# Installation

## Infrastructure
- Use droplet market place LEMP 4GB of memory / 2vCPU
https://marketplace.digitalocean.com/apps/lemp 

## Dependency List
```bash

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
sudo apt install -y php8.2-mysql php-mbstring php-xml php-bcmath

# wrk
sudo apt install -y wrk
	
```
## Deployment

```bash
cd /var/www/cache-exp
composer install
cp .env.example .env
php artisan key:generate
sudo chown -R www-data.www-data storage

# nginx
cd /var/www/cache-exp
cp installation/cache-exp.nginx /etc/nginx/sites-available/cache-exp
sudo ln -s /etc/nginx/sites-available/cache-exp /etc/nginx/sites-enabled/cache-exp
sudo nginx -t
sudo service nginx restart

# migrate
cd /var/www/cache-exp
php artisan migrate
```

## Start Server
```bash
# cd ~/cache-exp
# php artisan serve
# service mysql restart
# service redis-server restart

# nohup php artisan serve &
# ps -ef | grep "$PWD/server.php"
# kill 24482

```

## Quick Installation
```bash
cd /var/www
git clone  https://github.com/arc6828/cache-exp
cd cache-exp
bash installation/setup-dependency.sh
bash deploy.sh
# curl http://localhost:8000/api/cache/file/20KB
# curl http://localhost:8000/api/cache/mysql/20KB
# curl http://localhost:8000/api/cache/redis/20KB
# curl http://localhost:8000/api/cache/none/20KB
```



## RUN Test
```bash
cd /var/www/cache-exp
bash run-ubuntu/run-traffic.sh
bash run-ubuntu/run-payload.sh
bash run-ubuntu/run-cache-size.sh
bash run-ubuntu/run-cache-size-10k.sh
```