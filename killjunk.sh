#!/bin/bash

rm -rf _tests install.php install.sql install_ok _config.php.template

exec<data_custom/addon_files.txt
while read line
do
	if [[ ${line:0:4} = "# # " ]]
	then
		if [[ $line = "themes/default/templates_custom/MAIL.tpl" ]]
		then
			echo
		else
			rm -rf ${line:4}
		fi
	fi
done

# Other languages
find . -name "AR" -exec rm -rf {} \; 2> /dev/null
find . -name "BG" -exec rm -rf {} \; 2> /dev/null
find . -name "CS" -exec rm -rf {} \; 2> /dev/null
find . -name "DA" -exec rm -rf {} \; 2> /dev/null
find . -name "DE" -exec rm -rf {} \; 2> /dev/null
find . -name "EL" -exec rm -rf {} \; 2> /dev/null
find . -name "ES" -exec rm -rf {} \; 2> /dev/null
find . -name "FI" -exec rm -rf {} \; 2> /dev/null
find . -name "FR" -exec rm -rf {} \; 2> /dev/null
find . -name "HI" -exec rm -rf {} \; 2> /dev/null
find . -name "HR" -exec rm -rf {} \; 2> /dev/null
find . -name "IT" -exec rm -rf {} \; 2> /dev/null
find . -name "JA" -exec rm -rf {} \; 2> /dev/null
find . -name "KO" -exec rm -rf {} \; 2> /dev/null
find . -name "NL" -exec rm -rf {} \; 2> /dev/null
find . -name "PL" -exec rm -rf {} \; 2> /dev/null
find . -name "PT" -exec rm -rf {} \; 2> /dev/null
find . -name "RO" -exec rm -rf {} \; 2> /dev/null
find . -name "RU" -exec rm -rf {} \; 2> /dev/null
find . -name "SV" -exec rm -rf {} \; 2> /dev/null
find . -name "ZH-CN" -exec rm -rf {} \; 2> /dev/null
find . -name "ZH-TW" -exec rm -rf {} \; 2> /dev/null

# Addon stuff
rm -rf data_custom/publish_addons_as_downloads.php
rm -rf sources_custom/dump_addons.php
rm -rf data_custom/addon_files.txt
rm -rf data_custom/addon_screenshots
rm -rf data_custom/addons-sheet.csv
rm -rf data_custom/build_addons.php

# empty dirs
rm -rf ocworld data_custom/causes data_custom/jabber-logs data_custom/lolcats data_custom/lolcats/thumbs data_custom/modules/ocworld sources_custom/php-crossword sources_custom/programe/aiml sources_custom/programe sources_custom/geshi sources_custom/getid3 uploads/ocgifts_addon uploads/ocworld diseases_addon
