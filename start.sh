#!/bin/bash
if [ ! -f /mysql-configured ]; then
/usr/bin/mysqld_safe & 
sleep 10s
MYSQL_PASSWORD=`pwgen -c -n -1 12`
echo mysql root password: $MYSQL_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
echo $MYSQL_PASSWORD > /var/www/mysql-root-pw.txt
mysqladmin -u root password $MYSQL_PASSWORD 
touch /mysql-configured
killall mysqld
	 cd /var/www/html/
     for fl in *.*; do
     mv $fl $fl.old
     sed "s/MYSQL_PASSWORD/$MYSQL_PASSWORD/g" $fl.old > $fl
     rm -f $fl.old
     done
sleep 10s
fi
supervisord -n
