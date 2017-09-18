#!/bin/sh

IOCNAME=iocmicroEpsilon

cd /home/epics/apps/iocBoot/$IOCNAME
#git pull origin master
procServ -f -P 20000 -L /logs/$IOCNAME.log ./st.cmd

