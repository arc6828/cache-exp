#!/bin/bash

wrk -t1 -c1 -d5s "http://$(hostname).local/cache-exp/public/api/cache/file" > performance/file.txt
echo "1. run file successfully"
wrk -t1 -c1 -d5s "http://$(hostname).local/cache-exp/public/api/cache/mysql" > performance/mysql.txt
echo "2. run mysql successfully"
wrk -t1 -c1 -d5s "http://$(hostname).local/cache-exp/public/api/cache/redis" > performance/redis.txt
echo "3. run redis successfully"
wrk -t1 -c1 -d5s "http://$(hostname).local/cache-exp/public/api/cache/none" > performance/nocache.txt
echo "4. run nocache successfully"