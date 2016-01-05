###### QNIBng image
FROM qnib/terminal

RUN yum install -y libibmad  libibumad
RUN yum install -y infiniband-diags 
RUN yum install -y opensm-libs

RUN echo "20150223.2";yum clean all
RUN yum install -y statsd 
#RUN yum install -y opensm-qnibng qnib-ibsim

# config
ADD etc/opensm/opensm.conf /etc/opensm/opensm.conf

# ibsim
ADD etc/supervisord.d/ibsim.ini /etc/supervisord.d/ibsim.ini
ADD opt/qnib/bin/start_ibsim.sh /opt/qnib/bin/

# opensim (should wait)
ADD etc/supervisord.d/opensm.ini /etc/supervisord.d/opensm.ini
ADD opt/qnib/bin/start_opensm.sh /opt/qnib/bin/

#RUN yum install -y gcc python-devel libibverbs-devel

ADD etc/consul.d/*.json /etc/consul.d/

RUN yum install -y python-pip
RUN pip install neo4jrestclient
RUN pip install PyYAML envoy
ENV LD_PRELOAD /usr/lib64/umad2sim/libumad2sim.so
