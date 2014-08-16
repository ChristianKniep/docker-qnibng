###### QNIBng image
FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN yum install -y bind-utils vim nc

RUN yum install -y libibmad  libibumad
RUN yum install -y infiniband-diags 
RUN yum install -y opensm-libs

ADD etc/yum.repos.d/qnib.repo /etc/yum.repos.d/qnib.repo
RUN echo "20140816.2";yum clean all;yum install -y qnib-statsd
RUN yum install -y opensm-qnibng
RUN yum install -y qnib-ibsim

# config
ADD etc/opensm/opensm.conf /etc/opensm/opensm.conf

# ibsim
ADD etc/supervisord.d/ibsim.ini /etc/supervisord.d/ibsim.ini
ADD root/bin/start_ibsim.sh /root/bin/

# opensim (should wait)
ADD etc/supervisord.d/opensm.ini /etc/supervisord.d/opensm.ini
ADD root/bin/start_opensm.sh /root/bin/

CMD /bin/supervisord -c /etc/supervisord.conf

