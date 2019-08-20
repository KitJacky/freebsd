#!/bin/sh

Ifconfig=`cat /etc/rc.conf | grep ifconfig | awk '{printf $0}'`
Defaultrouter=`cat /etc/rc.conf | grep defaultrouter | awk '{printf $0}'`
Hostname=`cat /etc/rc.conf | grep hostname | awk '{printf $0}'`
Version=`uname -a | awk -F' ' '{printf $3}'`


GM=`gmirror status | grep -c 'DEGRADED'`
if [ $GM -eq "0" ]; then
echo "gmirror check done!"
else
ERROR='GmirrorError'
fi


TO=`dmesg -a | grep -c 'TIMEOUT'`
if [ $TO -eq "0" ]; then
echo "Timeout check done!"
else
ERROR='TimeOut_HDD_Error'
fi


if [ $ERROR ]; then
ERROR=.$IP
ERROR=.`df -h`
echo $ERROR
df -h | /usr/bin/mail -s "3JK server error" jk@jk.hk
gmirror list | /usr/bin/mail -s "3JK server error" i@jk.hk
fi

