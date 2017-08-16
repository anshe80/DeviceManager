#!/usr/bash

sudo apt-get install sqlite3
sudo apt-get install libdbi-perl
sudo apt-get install libdbd-sqlite3-perl
sudo apt-get install libhtml-template-perl
sudo apt-get install libhtml-parser-perl
# 解决找不到CGI问题
sudo apt-get install libcgi-session-perl

rootPath=$(pwd)
sudo rm -rf /etc/rackmonkey.conf
sudo ln -s -d $rootPath/rackmonkey.conf /etc/rackmonkey.conf

#sudo rm -rf /etc/apache2/conf.d/httpd-rackmonkey.conf
#sudo ln -s $rootPath/httpd-rackmonkey.conf /etc/apache2/conf.d/httpd-rackmonkey.conf
sudo rm -rf /etc/apache2/sites-enabled/httpd-rackmonkey.conf
sudo ln -s $rootPath/httpd-rackmonkey.conf /etc/apache2/sites-enabled/httpd-rackmonkey.conf

cd ..
rootPath=$(pwd)
#cd -

sudo rm -rf /var/www/rackmonkey

sudo ln -s -d $rootPath/src /var/www/rackmonkey

#cd ..
#rootPath=$(pwd)

sudo chmod 755 src/rackmonkey.pl
#cd -

sudo mkdir /var/lib/rackmonkey
sudo chown www-data:www-data /var/lib/rackmonkey

sudo rm -rf /var/lib/rackmonkey/tmpl
sudo ln -s -d $rootPath/tmpl /var/lib/rackmonkey/tmpl

# force reload apache2
sudo /etc/init.d/apache2 force-reload

#cd ..
#rootPath=$(pwd) 

sqlite3 ./rackmonkey.db < sql/schema/schema.sqlite.sql
sqlite3 ./rackmonkey.db < sql/data/default_data.sql
sqlite3 ./rackmonkey.db < sql/data/sample_data.sql
sudo ln -s -d $rootPath/rackmonkey.db /var/lib/rackmonkey/rackmonkey.db
sudo chown www-data:www-data /var/lib/rackmonkey/rackmonkey.db

sudo ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/.

echo "********** Follows are creating symbolic **********"
ls /var/lib/rackmonkey
ls /var/www/
ls /etc/apache2/conf.d/httpd-rackmonkey.conf
ls /etc/rackmonkey.conf


