#!/bin/bash

CARBON_IP=$(dig +short carbon)
if [ "X${CARBON_IP}" == "X" ];then
   echo "ERROR: Carbon could not be resolved"
   exit 1
fi
cat /etc/statsd/config.js.example |sed -e "s/CARBON_HOST/${CARBON_IP}/" > /etc/statsd/config.js

# start statsd
/bin/node /usr/local/statsd/stats.js /etc/statsd/config.js
