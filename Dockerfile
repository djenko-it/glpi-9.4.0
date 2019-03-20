FROM centos:latest

MAINTAINER djenko-it <djenko-it@protonmail.com>

RUN yum install -y httpd
RUN yum install -y epel-release
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php72
RUN yum update -y
RUN yum install -y php
RUN yum install -y php-mysql
RUN yum install -y php-ldap
RUN yum install -y php-xmlrpc
RUN yum install -y php-imap
RUN yum install -y curl
RUN yum install -y php-curl
RUN yum install -y php-gd
RUN yum install -y php-mbstring
RUN yum install -y php-xml
RUN yum install -y php-pecl-apcu
RUN yum install -y php-pear-CAS
RUN yum install -y php-opcache
RUN yum install -y wget
RUN yum clean all -y

EXPOSE 80
EXPOSE 443

ADD script.sh /script.sh
ADD httpd.conf /opt
ADD glpi.conf /opt
RUN chmod -v +x /script.sh

CMD ["/script.sh"]
