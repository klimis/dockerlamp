#####################################################################################
# Php - Apache container Dockerfile, creates a non root user in a Debian based container.
#####################################################################################
#####################################################################################
# CHANGELOG
# 7.1.2-0.2     - Release Date      : 02-03-2017
#               - New               :
#                                       1.  Added mysql-client
#               - Fixed             :
# 7.1.2-0.3     - Release Date      : 02-03-2017
#               - New               :
#                                       1.  Added bash history support
#               - Fixed             :
# 7.1.2-0.8     - Release Date      :   21-03-2017
#               - New               :
#                                       1.  Added bcmath extension
# 7.1.2-0.9     - Release Date      :     29-03-2017
#               - New               :
#                                       1.  Added date.timezone = Europe/Athens
# 7.1.2-0.10    - Release Date      : 19-04-2017
#               - New               :
#                                       1.  Added nodejs / npm
# 7.1.2-0.11    - Release Date      : 01-08-2017
#               - New               :
#                                       1.  Update nodejs v v8.2.0 / npm 5.3.0
# 7.1.2-0.12    - Release Date      : 01-08-2017
#               - New               :
#                                       1.  Update nodejs v v8.2.1 / npm 5.3.0
#####################################################################################
#####################################################################################
# build as follows:
# docker build --build-arg LOCAL_USER_ID=`id -u $USER` --no-cache=true  -t mylamp/web -f build/web/Dockerfile .


FROM php:7.1.2-apache

RUN apt-get update
# Install various extensions
RUN pecl install redis-3.1.1 \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable redis xdebug \
    && apt-get install -y vim \
    && apt-get install -y nano \
    && apt-get install -y git \
    && apt-get install -y mysql-client \
    && apt-get install -y libmcrypt-dev \
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo pdo_mysql mysqli mbstring sockets bcmath \
    && apt-get install -y zlib1g-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl
# Install various extensions


RUN apt-get install -y wget libssh2-1-dev libssh2-1 unzip \
    && wget https://github.com/Sean-Der/pecl-networking-ssh2/archive/php7.zip && unzip php7.zip && cd pecl-networking-ssh2-php7 && phpize && ./configure && make && make install \
    && echo extension=ssh2.so > /usr/local/etc/php/conf.d/docker-php-ext-ssh2.ini \
    && apt-get purge -y --auto-remove wget unzip

# Install GD extensions with freetype
RUN apt-get install -y  libjpeg62-turbo  libpng12-0 libfreetype6 --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN buildDeps=" \
        libfreetype6-dev \
		libjpeg-dev \
		libpng12-dev \
	"; \
	set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
	&& docker-php-ext-install gd \
	&& apt-get purge -y --auto-remove $buildDeps
# Install GD extensions with freetype


# Composer
RUN curl -sS https://getcomposer.org/installer |  php -- --install-dir=/usr/local/bin --filename=composer
# Composer
#MEMCACHED***********************************************************************************************************************
#ENV MEMCACHED_DEPS  libmemcached-dev
#RUN set -xe \
#    && apt-get install -y $MEMCACHED_DEPS \
#    && git clone -b php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
#    && docker-php-ext-configure /usr/src/php/ext/memcached \
#        --disable-memcached-sasl \
#    && docker-php-ext-install /usr/src/php/ext/memcached \
#    && rm -rf /usr/src/php/ext/memcached \
#    && apt-get purge -y $MEMCACHED_DEPS
#MEMCACHED***********************************************************************************************************************

# APACHE CONFIGS
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load \
    && echo Listen 8080 >> /etc/apache2/apache2.conf \
    && echo CustomLog /var/log/apache2/access_log combined >> /etc/apache2/apache2.conf
RUN a2enmod headers
# APACHE CONFIGS

#USER MANAGEMENT*****************************************************************************************************************
ARG LOCAL_USER_ID
# default uid if not provided
ENV LOCAL_USER_ID ${LOCAL_USER_ID:-1000}
# create igc user/group
RUN USER_ID=${LOCAL_USER_ID} \
    && useradd --shell /bin/bash -u $USER_ID -c "" -m igc

# COPY web/ssh/ /root/.ssh/
# COPY web/ssh/ /home/igc/.ssh/
# RUN chmod 400 /root/.ssh/id_rsa \
#     && chmod 600 /root/.ssh/config \
#     && chmod 400 /home/igc/.ssh/id_rsa \
#     && chmod 600 /home/igc/.ssh/config \
#     && chown -R igc:igc /home/igc/.ssh
#USER MANAGEMENT*****************************************************************************************************************

RUN  echo xdebug.remote_enable = 1 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN  echo xdebug.remote_host='${XDEBUG_REMOTE_HOST}' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY web/configuration/php7.ini /usr/local/etc/php/conf.d/php_igc.ini

RUN  set -e TERM=xterm
COPY web/configuration/.vimrc  /home/.vimrc
COPY web/configuration/.vimrc  /root/.vimrc

#NODEJS - NPM
RUN cd /tmp/ && curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs


# give permissions to igc group for www-data user
RUN usermod www-data --append --groups igc

RUN docker-php-source delete

WORKDIR /var/www