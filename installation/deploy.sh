#!/bin/bash

# git clone
# cd /var/www
# git clone  https://github.com/arc6828/cache-exp
cd /var/www/cache-exp
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate

# nginx
cd /var/www/cache-exp
cp installation/cache-exp.nginx /etc/nginx/sites-available/cache-exp
sudo ln -s /etc/nginx/sites-available/cache-exp /etc/nginx/sites-enabled/cache-exp
sudo nginx -t
sudo service nginx restart

