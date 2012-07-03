#!/bin/bash

#if [ -z "$HPHP_HOME" ]
#then
	export CMAKE_PREFIX_PATH=~/dev
	export HPHP_HOME=~/dev/hiphop-php
	export HPHP_LIB=~/dev/hiphop-php/bin
	export MAKEOPTS=-j4
	export MAKEOPTS="-j4"
#fi

if [ "$1" == "continue" ]
then
	cd hphp
	cmake .
	exit
fi

#if [ ! -e "hphp.files.list" ]
#then
	echo "ocP: Finding files to compile..."
	find . -name "*.php" -not -name errorlog.php -not -name phpstub.php -not -name caches_wincache.php -not -name caches_xcache.php -not -name caches_eaccelerator.php -not -name install.php -not -name minikernel.php -not -name phpbb3.php -not -name tempcode.php -not -name tempcode_compiler.php -not -name mysqli.php -not -name access.php -not -name sqlite.php -not -name mysql_dbx.php -not -name postgresql.php -not -name oracle.php -not -name sqlserver.php -not -name ibm.php | egrep -v '/_tests' | egrep -v '/adminzone/pages/minimodules_custom/' | egrep -v '/sources/hooks/modules/admin_import/' | egrep -v '/sources/forum/' | egrep -v '/sources_custom/hooks/systems/addon_registry/' > hphp.files.list
	echo "./sources/forum/ocf.php" >> hphp.files.list
#fi

if [ -e "compile_in_ocportal_includes.php" ]
then
	php compile_in_ocportal_includes.php
fi

#if [ -e "hphp/CMakeFiles/program.dir/php" ]
#then
#	mv hphp/CMakeFiles/program.dir/php php.obj.bak
#	echo "Backed up old object files. When hphp compiling you can ctrl+c and do ..."
#	echo "rm -rf hphp/CMakeFiles/program.dir/php ; mv php.obj.bak hphp/CMakeFiles/program.dir/php ; cd hphp ; make"
#fi

echo "ocP: Compiling..."
if [ ! -e "hphp" ]
then
	mkdir hphp
fi
$HPHP_HOME/src/hphp/hphp --input-list=hphp.files.list --log=3 -v "AllDynamic=true" --output-dir=hphp --force=1 --optimize-level=2 --file-cache=hphp-static-cache --sync-dir=/tmp/hphp_sync --keep-tempdir=true
# --cluster-count=200

echo "ocP: Running..."
sudo ./hphp/program -m server -v "Server.SourceRoot=`pwd`" -v "Server.DefaultDocument=index.php" -v "Log.Level=Verbose" --config "ocp.hdf"
