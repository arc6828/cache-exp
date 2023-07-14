#!/bin/bash
# for i in 10 30 60; do

content=$(wget http://localhost:8000/api/cache/flush/all -q -O -)
echo "flush all cache drivers"

service nginx restart
service mysql restart
service redis restart
echo "restart servers"

for i in 60; do
    for size in 20 200 2000; do
        echo "warming up : ${size}KB"
        content=$(wget http://localhost:8000/api/cache/file/${size}KB -q -O -)
        content=$(wget http://localhost:8000/api/cache/mysql/${size}KB -q -O -)
        content=$(wget http://localhost:8000/api/cache/redis/${size}KB -q -O -)
        content=$(wget http://localhost:8000/api/cache/none/${size}KB -q -O -)
        echo "warming up finished"
        
        echo "${i}s / ${size}KB"
        wrk -t1 -c1 -d${i}s "http://localhost:8000/api/cache/file/${size}KB" > /var/www/cache-exp/performance/payload/file-${i}s-${size}KB.txt
        echo "1. run file successfully"
        wrk -t1 -c1 -d${i}s "http://localhost:8000/api/cache/mysql/${size}KB" > /var/www/cache-exp/performance/payload/mysql-${i}s-${size}KB.txt
        echo "2. run mysql successfully"
        wrk -t1 -c1 -d${i}s "http://localhost:8000/api/cache/redis/${size}KB" > /var/www/cache-exp/performance/payload/redis-${i}s-${size}KB.txt
        echo "3. run redis successfully"
        wrk -t1 -c1 -d${i}s "http://localhost:8000/api/cache/none/${size}KB" > /var/www/cache-exp/performance/payload/nocache-${i}s-${size}KB.txt
        echo "4. run nocache successfully"
    done
done
