#!/bin/bash

source ./openrc

#-------------------------------------------------------------------------------

cat << EOF > /etc/neutron/neutron.conf.changes
[DEFAULT]
debug = True
verbose = True

bind_host = 0.0.0.0
bind_port = 9696

api_paste_config = api-paste.ini

rabbit_host = $RABBITMQ_HOST
rabbit_userid = $RABBITMQ_USERNAME
rabbit_password = $RABBITMQ_PASSWORD

[keystone_authtoken]
admin_tenant_name = service
admin_user = quantum
admin_password = swordfish

[database]
connection = mysql://quantum:swordfish@$MYSQL_HOST/quantum

[quotas]
quota_driver = neutron.db.quota_db.DbQuotaDriver
EOF

#-------------------------------------------------------------------------------

cat << EOF > /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini.changes
[database]
sql_connection = mysql://quantum:swordfish@$MYSQL_HOST/quantum

[ovs]
#network_vlan_ranges = physnet1
#bridge_mappings = physnet1:br-ex
tenant_network_type = gre
tunnel_id_ranges = 1:1000
enable_tunneling = True
local_ip = $HOST_IP

[securitygroup]
firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
EOF

#-------------------------------------------------------------------------------

cat << EOF > /etc/neutron/metadata_agent.ini.changes
[DEFAULT]
auth_url = http://$CONTROL_NODE:35357/v2.0
auth_region = RegionOne
admin_tenant_name = service
admin_user = quantum
admin_password = swordfish

nova_metadata_ip = $CONTROL_NODE
nova_metadata_port = 8775

metadata_proxy_shared_secret = swordfish
EOF

#-------------------------------------------------------------------------------

./merge-config.sh /etc/neutron/neutron.conf /etc/neutron/neutron.conf.changes

./merge-config.sh /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini \
    /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini.changes

./merge-config.sh /etc/neutron/metadata_agent.ini /etc/neutron/metadata_agent.ini.changes

#-------------------------------------------------------------------------------

ln -s /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini /etc/neutron/plugin.ini

./restart-os-services.sh neutron
