###### QNIBng image
FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN yum install -y bind-utils

ADD qnib /opt/qnib
WORKDIR /opt/qnib/fedora/19/x86_64
RUN yum install -y ./qnib-libibmad-1.3.10-20140102.1.x86_64.rpm ./qnib-libibumad-1.3.8-20140102.1.x86_64.rpm
RUN yum install -y ./qnib-infiniband-diags-1.6.2-20140103.1.x86_64.rpm ./qnib-opensm-3.3.15-20140114.1.x86_64.rpm
RUN yum install -y opensm-libs
# config
ADD usr/etc/opensm/opensm.conf /usr/etc/opensm/opensm.conf
ADD etc/supervisord.d/opensm.ini /etc/supervisord.d/opensm.ini

# statsd
RUN yum install -y ./qnib-statsd-0.7.0-20140104.3.x86_64.rpm
ADD etc/statsd/config.js.example /etc/statsd/config.js.example
ADD etc/supervisord.d/statsd.ini /etc/supervisord.d/statsd.ini
ADD root/bin/start_statsd.sh /root/bin/start_statsd.sh

CMD /bin/supervisord -c /etc/supervisord.conf

