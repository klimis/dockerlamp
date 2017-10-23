FROM redis:4.0.2

# build as follows:
# docker build --no-cache=true -t mylamp/redis -f build/redis/Dockerfile .

# CHANGELOG
# 3.2-0.2     - Release Date      : 08-06-2017
#                                  1. removed AOF persistense

COPY redis/redis.conf /usr/local/etc/redis/redis.conf
EXPOSE 6379
RUN mkdir /var/lib/redis
RUN chmod -R 777 /var/lib/redis
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
