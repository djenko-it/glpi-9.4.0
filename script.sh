#!/bin/bash

rm -rf /run/httpd/* /tmp/httpd*

#You change version (example: 9.3.3, 9.4.1)
VERSION_GLPI=9.4.0

TAR=glpi-${VERSION_GLPI}.tgz

SRC_GLPI=https://github.com/glpi-project/glpi/releases/download/${VERSION_GLPI}/glpi-${VERSION_GLPI}.tgz
FOLDER_GLPI=glpi/
FOLDER_HTML=/var/www/html/

if [ -d "${FOLDER_HTML}${FOLDER_GLPI})" ];
then
	echo "Folder /var/www/html/glpi exists "
else
	wget -P ${FOLDER_HTML} ${SRC_GLPI}
  cd ${FOLDER_HTML}
	tar -xzf ${TAR}
	rm ${TAR}
  rm /etc/httpd/conf/httpd.conf
  cp /opt/httpd.conf /etc/httpd/conf/
  cp /opt/glpi.conf /etc/httpd/conf.d/
  chown apache:apache /etc/httpd/conf/httpd.conf
fi

chown -R apache:apache ${FOLDER_HTML}${FOLDER_GLPI}

exec /usr/sbin/apachectl -DFOREGROUND
