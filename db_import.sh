#!/bin/bash

DB_HOST=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site_host']='\(.*\)';/\1/p")
DB_USER=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site_user']='\(.*\)';/\1/p")
DB_PASS=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site_password']='\(.*\)';/\1/p")
DB_NAME=$(cat _config.php|sed -n "s/\$SITE_INFO\['db_site']='\(.*\)';/\1/p")

mysql -h${DB_HOST} -u${DB_USER} -p${DB_PASS} ${DB_NAME} < db.sql
