#!/bin/bash
for i in 10 30 60; do
    for size in 20 200 2000; do
        echo "${i}s / ${size}KB"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/file/${size}KB" >performance/file-${i}s.txt
        echo "1. run file successfully"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/mysql/${size}KB" >performance/mysql-${i}s.txt
        echo "2. run mysql successfully"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/redis/${size}KB" >performance/redis-${i}s.txt
        echo "3. run redis successfully"
        wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/none/${size}KB" >performance/nocache-${i}s.txt
        echo "4. run nocache successfully"
    done
done
