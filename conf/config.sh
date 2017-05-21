#!/usr/bash


rootPath=$(pwd)
sudo rm -rf /etc/rackmonkey.conf
sudo ln -s -d $rootPath/rackmonkey.conf /etc/rackmonkey.conf

sudo rm -rf /etc/apache2/conf.d/httpd-rackmonkey.conf
sudo ln -s $rootPath/httpd-rackmonkey.conf /etc/apache2/conf.d/httpd-rackmonkey.conf

cd ../..
rootPath=$(pwd)
cd -

sudo rm -rf /var/www/rackmonkey

sudo ln -s -d $rootPath/DeviceManager /var/www/rackmonkey

cd ..
rootPath=$(pwd)

sudo chmod 755 rackmonkey.pl
cd -

sudo mkdir /var/lib/rackmonkey
sudo chown www-data:www-data /var/lib/rackmonkey

sudo rm -rf /var/lib/rackmonkey/tmpl
sudo ln -s -d $rootPath/tmpl /var/lib/rackmonkey/tmpl

# force reload apache2
sudo /etc/init.d/apache2 force-reload

cd ..
rootPath=$(pwd)
sudo chown www-data:www-data $rootPath/rackmonkey.db
