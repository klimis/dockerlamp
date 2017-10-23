#!/bin/bash


docker build  --tag mylamp/busybox-private --file busybox/Dockerfile .

docker build  -t mylamp/haproxy -f haproxy/Dockerfile .

docker build  -t mylamp/logrotate -f logrotate/Dockerfile .

docker build  -t mylamp/logrotate -f mysql/Dockerfile .

docker build  -t mylamp/redis -f redis/Dockerfile .

docker build --build-arg LOCAL_USER_ID=`id -u $USER` --no-cache=true  -t mylamp/web -f web/Dockerfile .