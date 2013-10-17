#!/bin/bash

./configure-system.sh

./install-compute-on-compute-node.sh

./configure-compute-on-computer-node.sh

./install-neutron-on-compute-node.sh

./configure-neutron-on-compute-node.sh
