#!/bin/sh
export HPHP_HOME=~/dev/hiphop-php
export HPHP_LIB=~/dev/hiphop-php/bin
sudo hphp/program -m server  -v "Server.SourceRoot=`pwd`" -v Server.DefaultDocument=index.php --config ./ocp.hdf
# -v Log.Level=Verbose -v Log.Header=on
