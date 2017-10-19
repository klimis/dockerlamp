#####################################################################################
# This container can crawl for logfiles and rotate them. It is a side-car container
# for containers that write logfiles and need a log rotation mechanism.
# https://github.com/blacklabelops/logrotate
#####################################################################################
#####################################################################################
# CHANGELOG
# 3.10.0     - Release Date      : 01-08-2017
#            - New               :
# 3.10.1     - Release Date      : 02-08-2017
#            - New               : notifempty
# 3.10.2     - Release Date      : 02-08-2017
#            - New               : notifempty at recursive directories
# 3.10.3     - Release Date      : 02-08-2017
#            - New               : remove delaycompress option
#####################################################################################
# build as follows:
# docker build --no-cache=true -t logrotate-3.10.0 -f logrotate/Dockerfile .
# tag : docker tag *********** 10.70.7.207:5000/tools/logrotate:3.10.3
# docker push 10.70.7.207:5000/tools/logrotate:3.10.3

FROM blacklabelops/alpine:3.5
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

# logrotate version (e.g. 3.9.1-r0)
ARG LOGROTATE_VERSION=latest
# permissions
ARG CONTAINER_UID=1000
ARG CONTAINER_GID=1000

# install dev tools
RUN export CONTAINER_USER=logrotate && \
    export CONTAINER_GROUP=logrotate && \
    addgroup -g $CONTAINER_GID logrotate && \
    adduser -u $CONTAINER_UID -G logrotate -h /usr/bin/logrotate.d -s /bin/bash -S logrotate && \
    apk add --update \
      tar \
      gzip \
      wget && \
    if  [ "${LOGROTATE_VERSION}" = "latest" ]; \
      then apk add logrotate ; \
      else apk add "logrotate=${LOGROTATE_VERSION}" ; \
    fi && \
    mkdir -p /usr/bin/logrotate.d && \
    wget --no-check-certificate -O /tmp/go-cron.tar.gz https://github.com/michaloo/go-cron/releases/download/v0.0.2/go-cron.tar.gz && \
    tar xvf /tmp/go-cron.tar.gz -C /usr/bin && \
    apk del \
      wget && \
    rm -rf /var/cache/apk/* && rm -rf /tmp/*

# environment variable for this container
ENV LOGROTATE_OLDDIR= \
    LOGROTATE_COMPRESSION= \
    LOGROTATE_INTERVAL= \
    LOGROTATE_COPIES= \
    LOGROTATE_SIZE= \
    LOGS_DIRECTORIES= \
    LOG_FILE_ENDINGS= \
    LOGROTATE_LOGFILE= \
    LOGROTATE_CRONSCHEDULE= \
    LOGROTATE_PARAMETERS= \
    LOGROTATE_STATUSFILE= \
    LOG_FILE=

COPY logrotate/docker-entrypoint.sh /usr/bin/logrotate.d/docker-entrypoint.sh
COPY logrotate/update-logrotate.sh /usr/bin/logrotate.d/update-logrotate.sh

ENTRYPOINT ["/usr/bin/logrotate.d/docker-entrypoint.sh"]
VOLUME ["/logrotate-status"]
CMD ["cron"]
