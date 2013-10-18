#!/bin/bash

apt-get install --yes \
    linux-headers-$(uname -r) \
    openvswitch-datapath-lts-raring-dkms \
    neutron-plugin-openvswitch-agent \
    neutron-dhcp-agent \
    neutron-l3-agent

service openvswitch-switch restart
service openvswitch-force-reload-kmod start

ovs-vsctl add-br br-ex
ovs-vsctl add-br br-int
