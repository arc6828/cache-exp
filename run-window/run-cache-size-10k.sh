#!/bin/bash

# initial state
# content=$(wget http://$(hostname).local/cache-exp/public/api/cache/flush/all -q -O -)
# echo "flush all cache drivers"
# measure state
for i in 60; do
    for size in 200; do
        # for cache_size in 10 100 1000; do
        for cache_size in 10000; do
            echo "warming up : ${cache_size}"
            for ((c = 1001; c <= cache_size; c++)); do
                echo "${c} / ${cache_size}";
                content=$(wget http://$(hostname).local/cache-exp/public/api/cache/file/${size}KB/${c} -q -O -)
                content=$(wget http://$(hostname).local/cache-exp/public/api/cache/mysql/${size}KB/${c} -q -O -)
                content=$(wget http://$(hostname).local/cache-exp/public/api/cache/redis/${size}KB/${c} -q -O -)
            done
            echo "warming up finished"
            echo "cache size : / ${cache_size}"
            wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/file/${size}KB/${cache_size}" >performance/cache-size/file-cache_size-${cache_size}.txt
            echo "1. run file successfully"
            wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/mysql/${size}KB/${cache_size}" >performance/cache-size/mysql-cache_size-${cache_size}.txt
            echo "2. run mysql successfully"
            wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/redis/${size}KB/${cache_size}" >performance/cache-size/redis-cache_size-${cache_size}.txt
            echo "3. run redis successfully"
            # wrk -t1 -c1 -d${i}s "http://$(hostname).local/cache-exp/public/api/cache/none/${size}KB${cache_size}" >performance/cache-size/nocache-${i}s-${size}KB.txt
            # echo "4. run nocache successfully"
        done
    done
done
