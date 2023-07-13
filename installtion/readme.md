# Installation

## Infrastructure
- Use droplet market place LEMP 4GB of memory / 2vCPU
https://marketplace.digitalocean.com/apps/lemp 

## Dependency List
- wrk
```bash
sudo apt install wrk
```

- composer
```bash
sudo apt -y install php-cli unzip php-curl
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

```
- for redis server
```bash
sudo apt update
sudo apt -y install redis-server
# sudo systemctl restart redis.service
# sudo systemctl status redis
```

- for mysql database server
```bash


# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then
	# echo "Enter database name!"
	# read dbname
    
	# echo "Creating new MySQL database..."
	# mysql -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
	mysql -e "CREATE DATABASE cacheDB;"
    # mysql -e "SET GLOBAL max_allowed_packet=3M;"
	# echo "Database successfully created!"
	
	# echo "Enter database user!"
	# read username
    
	# echo "Enter the PASSWORD for database user!"
	# echo "Note: password will be hidden when typing"
	# read -s userpass
    
	# echo "Creating new user..."
	mysql -e "CREATE USER cacheuser@localhost IDENTIFIED BY '123456789';"
	# echo "User successfully created!"

	# echo "Granting ALL privileges on ${dbname} to ${username}!"
	mysql -e "GRANT ALL PRIVILEGES ON cacheDB.* TO 'cacheuser'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"
	# echo "You're good now :)"
	# exit
	
```
- for project code

```bash
sudo apt update
php --version
sudo apt install php8.2-mysql
sudo apt install php-mbstring php-xml php-bcmath
cd ~
git clone  https://github.com/arc6828/cache-exp
cd cache-exp
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
```

## Start Server
```bash
cd ~/cache-exp
php artisan serve
service mysql restart
service redis-server restart

nohup php artisan serve &
ps -ef | grep "$PWD/server.php"
kill 24482

```

## RUN Test
```bash
cd ~/cache-exp
bash run-ubuntu/run-traffic.sh
bash run-ubuntu/run-payload.sh
bash run-ubuntu/run-cache-size.sh
bash run-ubuntu/run-cache-size-10k.sh
```