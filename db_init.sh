#!/bin/bash

DB_HOST=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site_host']='\(.*\)';/\1/p")
DB_USER=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site_user']='\(.*\)';/\1/p")
DB_PASS=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site_password']='\(.*\)';/\1/p")
DB_NAME=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site']='\(.*\)';/\1/p")

Q1="CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
Q2="GRANT ALL ON *.* TO '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

mysql -h${DB_HOST} -uroot -p -e "$SQL"
