#####################################################################################
# SQL container Dockerfile.
#####################################################################################
#####################################################################################
# CHANGELOG
# 5.7-0.2       - Release Date      : 02-03-2017
#               - New               :
#                                       1.  Added mysql-client
#               - Fixed             :
# 5.7-0.3       - Release Date      : 06-03-2017
#               - New               :
#                                       1.  Increased max_connections to 151
# 5.7-0.4       - Release Date      : 07-06-2017
#               - New               :
#                                       1.  Increased max_connections to 250
#                                       2.  Increased innodb_buffer_pool_size from 250M to 1500M
#                                       3.  Set innodb_log_buffer_size to 10M
#                                       3.  Set innodb_log_file_size to 200M

########
# build as follows:
# docker build --no-cache=true -t mylamp/logrotate -f build/mysql/Dockerfile .

FROM mysql:5.7
ADD mysql/mysql-docker.cnf /etc/mysql/conf.d/z99-docker.cnf
CMD ["mysqld"]