#!/bin/bash

apt-get install --yes \
    linux-headers-$(uname -r) \
    openvswitch-switch \
    openvswitch-datapath-lts-raring-dkms \
    neutron-plugin-openvswitch-agent

service openvswitch-switch restart
service openvswitch-force-reload-kmod start

ovs-vsctl add-br br-int
