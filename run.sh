#!/bin/bash

if [[ -e /firstrun ]]; then

echo "not first run so skipping initialization"

else 

echo "setting the default installer info for magento"
sed -i "s/<host>localhost/<host>db/g" /var/www/html/app/etc/config.xml
sed -i "s/<username\/>/<username>user<\/username>/" /var/www/html/app/etc/config.xml
sed -i "s/<password\/>/<password>password<\/password>/g" /var/www/html/app/etc/config.xml

touch /firstrun

fi
exec supervisord -n
