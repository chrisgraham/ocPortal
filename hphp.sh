#!/bin/bash

echo "ocP: Running..."
sudo hhvm -m server -v "Server.SourceRoot=`pwd`" -v "Server.DefaultDocument=index.php" -v "Log.Level=Verbose" --config "ocp.hdf"
