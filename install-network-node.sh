#!/bin/bash

source ./openrc

./configure-system.sh

./configure-system-at-network-node.sh

./install-neutron-at-network-node.sh

./configure-neutron-at-network-node.sh
