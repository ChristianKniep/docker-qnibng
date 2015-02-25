#!/bin/bash

export LD_PRELOAD=/usr/lib64/umad2sim/libumad2sim.so
#export SIM_HOST=${SIM_HOST-opensm}

function wait_ibsim() {
    if [ $(ps -ef|grep -v grep|grep -c ibsim) -eq 0 ];then
        sleep 1
        wait_ibsim
    fi
}

wait_ibsim
sleep 15

/usr/local/sbin/opensm -F /etc/opensm/opensm.conf
