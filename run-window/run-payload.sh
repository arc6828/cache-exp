#!/bin/bash
# for i in 10 30 60; do
content=$(wget http://$(hostname).local/cache-exp/public/api/cache/flush/all -q -O -)
echo "flush all cache drivers"
for i in 60; do
    for size in 20 200 2000; do
        echo "${i}s / ${size}KB"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/file/${size}KB" >performance/payload/file-${i}s-${size}KB.txt
        echo "1. run file successfully"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/mysql/${size}KB" >performance/payload/mysql-${i}s-${size}KB.txt
        echo "2. run mysql successfully"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/redis/${size}KB" >performance/payload/redis-${i}s-${size}KB.txt
        echo "3. run redis successfully"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/none/${size}KB" >performance/payload/nocache-${i}s-${size}KB.txt
        echo "4. run nocache successfully"
    done
done
