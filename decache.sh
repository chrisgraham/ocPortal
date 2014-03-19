#!/bin/bash

rm -f themes/*/templates_cached/*/*.tcd
rm -f themes/*/templates_cached/*/*.tcp
rm -f themes/*/templates_cached/*/*.js
rm -f themes/*/templates_cached/*/*.css
rm -f themes/*/templates_cached/*/*.gz
rm -f lang_cached/*/*.lcd
find . -name "*.gcd" -exec rm -f {} \;


if [ -e "sites" ]; then
   find . -name "*.tcd" -exec rm -f {} \;
   find . -name "*.tcp" -exec rm -f {} \;
   find . -name "*.lcd" -exec rm -f {} \;
   find sites -name "*.js" -exec rm -f {} \;
   find sites -name "*.css" -exec rm -f {} \;

	if [ -e "../decache.php" ]; then
		php ../decache.php
	fi
fi
