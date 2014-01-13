#!/bin/bash

# NB: This script is not needed if you have suexec

# Reset to good start state first
touch info.php
find . -type f -not -path "./sites/*" -not -path "./servers/*" -not -path "./_old/*" -not -path "./uploads/*" -exec chmod 644 {} \;
find . -type d -not -path "./sites/*" -not -path "./servers/*" -not -path "./_old/*" -exec chmod 755 {} \;

chmod -f a+w persistant_cache persistant_cache/* safe_mode_temp safe_mode_temp/* themes/map.ini data_custom/fields.xml data_custom/breadcrumbs.xml data_custom/modules/admin_backup data_custom/modules/chat data_custom/spelling/*.log data_custom/spelling/personal_dicts data_custom/spelling/personal_dicts/* *_cached *_cached/* themes themes/* text_custom/*.txt text_custom/EN/*.txt *_custom *_custom/* *_custom/*/* themes/*/*_custom themes/*/*_custom/* themes/*/templates_cached themes/*/theme.ini themes/*/templates_cached/* themes/*/templates_cached/*/* data_custom/errorlog.php ocp_*sitemap.xml data_custom/permissioncheckslog.php data_custom/modules/admin_stats exports/* data_custom/modules/chat/*.dat exports/*/* imports/* imports/*/* uploads/* pages/*_custom pages/*_custom/* pages/*_custom/*/* */pages/*_custom */pages/*_custom/* */pages/*_custom/*/* info.php 2>/dev/null

if [ -z "$1" ]; then
	if [ -e "sites" ]; then
		echo "On myOCP"
	else
		find uploads/* -exec chmod a+w {} \;
	fi
fi

if [ -z "$1" ]; then
	echo "ocPortal file permissions fixed"
fi

if [ $(id -u) = 0 ]; then
	echo "By the way, you are logged in as root or some weird user. Make sure the files aren't owned by root if you want to maintain via FTP. Useful command follows..."
	echo "  find . -user root -exec chown <correctuser> '{}' \;"
fi
