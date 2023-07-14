#!/bin/bash
# for i in 10 30 60; do
content=$(wget http://localhost:8000/api/cache/flush/all -q -O -)
echo "flush all cache drivers"
for i in 60; do
    for size in 20 2000; do
        echo "warming up : ${size}KB"
        content=$(wget http://localhost:8000/api/cache/file/${size}KB -q -O -)
        content=$(wget http://localhost:8000/api/cache/mysql/${size}KB -q -O -)
        content=$(wget http://localhost:8000/api/cache/redis/${size}KB -q -O -)
        content=$(wget http://localhost:8000/api/cache/none/${size}KB -q -O -)
        echo "warming up finished"
        for t in 1; do
            for c in 1 2 4 8 16 32 64; do
                echo "${i}s / ${size}KB / ${c} users / ${t} threads"
                wrk -t${t} -c${c} -d${i}s "http://localhost:8000/api/cache/file/${size}KB" > /var/www/cache-exp/performance/traffic/file-${size}KB-${c}users.txt
                echo "1. run file successfully"
                wrk -t${t} -c${c} -d${i}s "http://localhost:8000/api/cache/mysql/${size}KB" > /var/www/cache-exp/performance/traffic/mysql-${size}KB-${c}users.txt
                echo "2. run mysql successfully"
                wrk -t${t} -c${c} -d${i}s "http://localhost:8000/api/cache/redis/${size}KB" > /var/www/cache-exp/performance/traffic/redis-${size}KB-${c}users.txt
                echo "3. run redis successfully"
                wrk -t${t} -c${c} -d${i}s "http://localhost:8000/api/cache/none/${size}KB" > /var/www/cache-exp/performance/traffic/nocache-${size}KB-${c}users.txt
                echo "4. run nocache successfully"
            done
        done
    done
done
