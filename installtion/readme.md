# Installation

## Infrastructure
- Use droplet market place LEMP 4GB of memory / 2vCPU
https://marketplace.digitalocean.com/apps/lemp 

## Dependency List
- for redis server
```bash
sudo apt update
sudo apt install redis-server
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
	mysql -e "CREATE DATABASE laravel;"
    # mysql -e "SET GLOBAL max_allowed_packet=3M;"
	# echo "Database successfully created!"
	
	# echo "Enter database user!"
	# read username
    
	# echo "Enter the PASSWORD for database user!"
	# echo "Note: password will be hidden when typing"
	# read -s userpass
    
	# echo "Creating new user..."
	# mysql -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
	# echo "User successfully created!"

	# echo "Granting ALL privileges on ${dbname} to ${username}!"
	# mysql -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
	# mysql -e "FLUSH PRIVILEGES;"
	# echo "You're good now :)"
	# exit
	
```
- for project code

```bash
sudo apt update
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
```

## RUN Test
```bash
cd ~/cache-exp/run-ubuntu
bash run-traffic.sh
bash run-payload.sh
bash run-cache-size.sh
bash run-cache-size-10k.sh
```