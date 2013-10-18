#!/bin/bash

apt-get install --yes \
    openvswitch-switch \
    openvswitch-datapath-lts-raring-dkms \
    neutron-plugin-openvswitch-agent

service openvswitch-switch start

ovs-vsctl add-br br-int
