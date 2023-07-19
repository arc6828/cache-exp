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
for d in 1000; do
    for size in 2 20 200 2000; do
        echo "size : ${size} / amount : ${d}"
        curl "http://localhost:8000/api/cache/test/file/${size}KB/${d}" >/var/www/cache-exp/performance/cache-latency/file-${size}KB.json
        echo "1. run file successfully"
        curl "http://localhost:8000/api/cache/test/database/${size}KB/${d}" >/var/www/cache-exp/performance/cache-latency/mysql-${size}.json
        echo "2. run mysql successfully"
        curl "http://localhost:8000/api/cache/test/redis/${size}KB/${d}" >/var/www/cache-exp/performance/cache-latency/redis-${size}.json
        echo "3. run redis successfully"
    done
done
