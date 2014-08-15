###### QNIBng image
FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN yum install -y bind-utils vim nc

RUN yum install -y libibmad  libibumad
RUN yum install -y infiniband-diags 
RUN yum install -y opensm-libs
# config
ADD usr/etc/opensm/opensm.conf /usr/etc/opensm/opensm.conf
ADD etc/supervisord.d/opensm.ini /etc/supervisord.d/opensm.ini

# statsd
ADD etc/yum.repos.d/qnib.repo /etc/yum.repos.d/qnib.repo
RUN echo "20140815.9";yum clean all;yum install -y qnib-statsd

CMD /bin/supervisord -c /etc/supervisord.conf

