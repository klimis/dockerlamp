FROM redis:3.2

# docker build  -t redis -f redis/Dockerfile .

# CHANGELOG
# 3.2-0.2     - Release Date      : 08-06-2017
#                                  1. removed AOF persistense

COPY redis/redis.conf /usr/local/etc/redis/redis.conf
EXPOSE 6379
RUN mkdir /var/lib/redis
RUN chmod -R 777 /var/lib/redis
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
