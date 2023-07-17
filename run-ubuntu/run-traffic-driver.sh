#!/bin/bash
# for i in 10 30 60; do
content=$(wget http://localhost:8000/api/cache/flush/all -q -O -)
echo "flush all cache drivers"

# while getopts u:a:f: flag
while getopts e: flag
do
    case "${flag}" in
        e) cache=${OPTARG};;
        # a) age=${OPTARG};;
        # f) fullname=${OPTARG};;
    esac
done
echo "Cache: $cache";

sleep 10

service nginx restart
service mysql restart
service redis restart
echo "restart servers"

sleep 10

for d in 60; do
    # for size in 20 200 2000; do
    for size in 20; do
        echo "warming up : ${size}KB"
        content=$(wget http://localhost:8000/api/cache/${cache}/${size}KB -q -O -)
        # content=$(wget http://localhost:8000/api/cache/mysql/${size}KB -q -O -)
        # content=$(wget http://localhost:8000/api/cache/redis/${size}KB -q -O -)
        # content=$(wget http://localhost:8000/api/cache/none/${size}KB -q -O -)
        echo "warming up finished"
        for t in 1; do
            # for c in 100 200 300 400; do
            for c in 1; do
                echo "${d}s / ${size}KB / ${c} users / ${t} threads"
                wrk -t${t} -c${c} -d${d}s "http://localhost:8000/api/cache/${cache}/${size}KB" >/var/www/cache-exp/performance/traffic/${cache}-${size}KB-${c}users.txt
                echo "1. run file successfully"

                # sleep 10
                # wrk -t${t} -c${c} -d${d}s "http://localhost:8000/api/cache/mysql/${size}KB" >/var/www/cache-exp/performance/traffic/mysql-${size}KB-${c}users.txt
                # echo "2. run mysql successfully"

                # sleep 10
                # wrk -t${t} -c${c} -d${d}s "http://localhost:8000/api/cache/redis/${size}KB" >/var/www/cache-exp/performance/traffic/redis-${size}KB-${c}users.txt
                # echo "3. run redis successfully"

                # sleep 10
                # wrk -t${t} -c${c} -d${d}s "http://localhost:8000/api/cache/none/${size}KB" > /var/www/cache-exp/performance/traffic/nocache-${size}KB-${c}users.txt
                # echo "4. run nocache successfully"
            done
        done
    done
done
