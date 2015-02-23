#!/bin/bash

export NODES=${IBSIM_NODES-4}
if [ "X${NETLIST_FILE}" == "X" ];then
    export NETLIST_FILE=/opt/ibsim/${NODES}nodes.nlst
fi
if [ "X${SIM_HOST}" == "X" ];then
    export SIM_HOST=$(egrep "^(Hc|C)a" ${NETLIST_FILE} |sort|head -n1|awk '{print $3}'|sed -e 's/"//g')
fi

/usr/bin/ibsim -s ${NETLIST_FILE}
