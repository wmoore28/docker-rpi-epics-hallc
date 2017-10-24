#!/bin/bash

echo "Checking for updates to apps..."
cd /home/epics/apps
git pull origin master
if [ $? != 0 ]
then
    make
fi

if [ $# -gt 0 ]; then
    ioc=$1
    port=$2
    cd iocBoot/$ioc
    echo "Starting $ioc on port $port..."
    procServ -f -P $port -L /logs/$ioc.log --logstamp ./st.cmd
else
    echo "No ioc specified. Example: docker run -e ioc=iocmicroEspilon -e port=20000 -d wmoore28/rpi-epics-hallc"
fi
