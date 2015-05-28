FROM ubuntu:trusty
MAINTAINER Jackie <jyan@netstarter.com>

# Install packages
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libapache2-mod-php5
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-curl
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-mcrypt
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pwgen 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php-apc
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-gd
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nano


COPY magento/ /var/www/html/
ADD local.xml /var/www/html/app/etc/

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

RUN chmod 755 /*.sh

# Change File Permission
RUN chmod 777 -R  /var/www/html/media/ 
RUN chmod 777 -R  /var/www/html/var/
RUN chmod 777  /var/www/html/app/etc/

# Config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN php5enmod mcrypt
RUN a2enmod rewrite

# Environment variables to configure PHP
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

RUN service apache2 restart

# Add volumes the application.
VOLUME ["/var/www/html"]

EXPOSE 80

CMD ["/run.sh"]

