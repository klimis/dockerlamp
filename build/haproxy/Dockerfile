#####################################################################################
# Php - Apache container Dockerfile, creates a non root user in a Debian based container.
#####################################################################################
#####################################################################################
# CHANGELOG
# 1.7.1-0.2     - Release Date      : 08-03-2017
#               - New               :
#                                       1.  Added support for overriding config
# 1.7.1-0.3     - Release Date      : 27-03-2017
#               - New               :
#                                       1.  added mysql-dev in cfg
# 1.7.1-0.7     - Release Date      : 07-06-2017
#               - New               :
#                                       1.  increased maxconn to 220
#####################################################################################
# build as follows:
# docker build --no-cache=true -t mylamp/haproxy -f build/haproxy/Dockerfile .

FROM haproxy:1.7.1

ENV HAPROXY_USER haproxy
RUN groupadd --system ${HAPROXY_USER} && \
  useradd --system --gid ${HAPROXY_USER} ${HAPROXY_USER} && \
  mkdir --parents /var/lib/${HAPROXY_USER} && \
  chown -R ${HAPROXY_USER}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}

COPY haproxy/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

CMD ["haproxy", "-db", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]