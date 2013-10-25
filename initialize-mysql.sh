#!/bin/bash

source ./openrc

echo ''
echo 'Dropping databases ...'
echo ''

mysql -u root -p$MYSQL_PASSWORD <<EOF
DROP DATABASE nova;
DROP DATABASE cinder;
DROP DATABASE glance;
DROP DATABASE keystone;
DROP DATABASE quantum;
DROP DATABASE heat;
EOF

echo ''
echo 'Creating databases ...'
echo ''

mysql -u root -p$MYSQL_PASSWORD <<EOF
CREATE DATABASE nova;
GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE DATABASE cinder;
GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE DATABASE glance;
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
CREATE DATABASE heat;
GRANT ALL PRIVILEGES ON heat.* TO 'heat'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
FLUSH PRIVILEGES;
EOF

echo ''
echo 'Getting list of databases ...'
echo ''

mysql -u root -p$MYSQL_PASSWORD <<EOF
show databases;
EOF
