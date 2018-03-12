#!/bin/sh

service tomcat7 start

echo "Starting eXist-db"
# sudo -u existdb /usr/local/exist_atp_2.2/tools/wrapper/bin/exist.sh console
sudo -u existdb /etc/init.d/exist start

/bin/bash -i
