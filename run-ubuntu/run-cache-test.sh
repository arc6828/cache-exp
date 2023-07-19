#!/bin/bash

# initial state
# content=$(wget http://localhost:8000/api/cache/flush/all -q -O -)
# echo "flush all cache drivers"

# sleep 10

# service nginx restart
# service mysql restart
# service redis restart
# echo "restart servers"

# sleep 10
# measure state
for d in 100; do
    for size in 200; do
        echo "cache size : / ${cache_size}"
        curl "http://localhost:8000/api/cache/file/${size}KB/${cache_size}/${d}" >/var/www/cache-exp/performance/cache-latency/file-${cache_size}.txt
        echo "1. run file successfully"
        curl "http://localhost:8000/api/cache/database/${size}KB/${cache_size}/${d}" >/var/www/cache-exp/performance/cache-latency/mysql-${cache_size}.txt
        echo "2. run mysql successfully"
        curl "http://localhost:8000/api/cache/redis/${size}KB/${cache_size}/${d}" >/var/www/cache-exp/performance/cache-latency/redis-${cache_size}.txt
        echo "3. run redis successfully"
    done
done
