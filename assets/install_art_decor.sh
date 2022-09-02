#!/bin/bash
echo '*************************************************************'
echo '*            Welcome to the ART-DECOR installer!            *'
echo '*************************************************************'
echo 'This script intends to make the installation a little easier,'
echo 'although several manual steps are still included.'
echo 'This script needs to run as root and will store any files in'
echo '/root'

export TOMCAT_HOME=/var/lib/tomcat7
export CATALINA_HOME=/usr/local/tomcat
export EXIST_HOST=parasite
export ASSETS=/root/assets

cd /root


# Install & configure tomcat7, set JAVA_HOME to the Oracle version.
echo 'Configuring tomcat7.'
sed -i '/#JAVA_HOME=/a JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre' /etc/default/tomcat7
patch /etc/tomcat7/server.xml $ASSETS/server.xml.patch

echo 'Creating directories for art-decor logs'
mkdir /usr/share/tomcat7/logs
touch /usr/share/tomcat7/logs/art-decor.log
chown tomcat7 /usr/share/tomcat7/logs/art-decor.log
chmod 644 /usr/share/tomcat7/logs/art-decor.log
ln -s /usr/share/tomcat7/logs/art-decor.log /var/log/tomcat7/

echo 'Moving art-decor.war into place'
mv $ASSETS/art-decor.war $TOMCAT_HOME/webapps

# Unfortunately eXist-db requires user input during installation. Fortunately
# there's a python script (by Melle) to take care of that :-)
echo 'Running eXist-db installer'
python $ASSETS/install_existdb.py

# Create symlinks
ln -s /usr/local/exist_atp_2.2 /usr/local/exist_atp
ln -s /usr/local/exist_atp/tools/wrapper/logs/ /var/log/exist_wrapper
ln -s /usr/local/exist_atp/webapp/WEB-INF/logs /var/log/exist
ln -s /usr/local/exist_atp/tools/wrapper/bin/exist.sh /etc/init.d/exist

# Create a user, chown the installation and make sure the service is started
# by with the correct uid
adduser --system --group existdb
chown -R existdb:existdb /usr/local/exist_atp*
sed -i '/#RUN_AS_USER=/a RUN_AS_USER=existdb' /usr/local/exist_atp/tools/wrapper/bin/exist.sh

# This fails when started as root!
sudo -u existdb service exist start

echo "Uploading configuration.xml with nictiz repository to eXist-db"
curl -u admin:password --upload-file $ASSETS/configuration.xml http://localhost:8877/rest/db/apps/dashboard/

echo "Uploading xquery script to install packages via http GET"
curl -u admin:password --upload-file $ASSETS/install_exist_pkg.xquery http://localhost:8877/rest/db/system/install/

PACKAGES=(
  "ART-2.0.27.xar"
  "DECOR-core-2.0.23.xar"
  "DECOR-services-2.0.15.xar"
  "ART-DECOR-system-services-2.0.0.xar"
  "terminology-2.0.11.xar"
)

for i in "${PACKAGES[@]}"
do
    echo "Installing eXist-db package '$i'"
    /usr/local/exist_atp/bin/client.sh -u admin -P password -m /db/system/repo/ -p $ASSETS/exist-packages/$i -ouri=xmldb:exist://127.0.0.1:8877/xmlrpc
    curl -u admin:password http://localhost:8877/rest/db/system/install/install_exist_pkg.xquery?pkg=$i
done



