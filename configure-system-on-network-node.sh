#!/bin/bash

cat << EOF >> /etc/sysctl.conf


net.ipv4.ip_forward = 1
net.ipv4.conf.all.forwarding = 1
EOF

/etc/init.d/networking restart

sysctl -e -p /etc/sysctl.conf
