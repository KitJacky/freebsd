#!/bin/sh

# JKRaid.sh  / JKFreeBSDRaid-0.1_19052006.sh
# FreeBSD JK Raid1 Script. - Gmirror
# Powered By JackyKit. 2006
# Version 0.1 (19-05-2006)
# Email : jackykit@gmail.com

# FreeBSD 5.3up



#RNAME=jk0
#ROOTDISK=/dev/ad4


RNAME=$2
DISK=$3


clear
if [ -x /bin/pwd ]; then
        JKNOW=`/bin/pwd`"/"
else
        JKNOW=`pwd`"/"
fi


NOWDATE=`date "+%Y %m%d%H%M"`
LOGFILE=$JKNOW"jkLog.log"


jkCheck() { 
clear

echo
echo
echo "=========== JK LOG File ===========" >> $LOGFILE
echo "Upgrade FreeBSD.........." >> $LOGFILE
echo -e "\\033[1;37m""Welcome to JK System""\\033[0;39m"
echo -e "\\033[1;37m""JK Network Solutions Services""\\033[0;39m"  
echo -e "\\033[1;37m""JK RAID1 Program""\\033[0;39m"
date >> $LOGFILE
echo

if [ -x /bin/gmirror ] || [ -x /sbin/gmirror ] || [ -x /usr/bin/gmirror ] || [ -x /usr/sbin/gmirror ] || [ -x /usr/local/bin/gmirror ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
echo -n "  Checking for make ..... "
else echo -e "\\033[1;35m""Can't Find [gmirror]""\\033[0;39m"
echo "Can't Find [gmirror]" >> $LOGFILE
echo
echo -e "\\033[1;35m""Pls update your freebsd to version 5.3up.""\\033[0;39m"
echo -e "\\033[0;37m"byebye!!"\\033[0;39m"
exit 0
fi


echo
echo -n "  Checking for editor  ..... "
if [ -x /bin/pico ] || [ -x /usr/bin/pico ] || [ -x /usr/sbin/pico ] || [ -x /usr/local/bin/pico ]; then
echo -e "\\033[0;37m" [pico FOUND] "\\033[0;39m"
EDITOR="pico"
else echo -e "\\03[1;35m""Can't Find [pico] use [ee] editor""\\033[0;39m"
echo "Can't Find [pico] use ee editor" >> $LOGFILE
EDITOR="ee"
exit 0
fi

}



JKmaster()
{
df -h
echo
echo -e "\\033[1;33m"your raid is ? /dev/mirror/${RNAME}s1a"\\033[0;39m"
echo -e "\\033[1;33m"your master disk is ? ${DISK}"\\033[0;39m"
echo "your raid is ? /dev/mirror/${RNAME}s1a" >> $LOGFILE
echo "your master disk is ? ${DISK}" >> $LOGFILE

	JKINIT()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;
   x)       echo="echo"       nnl="\c" ;;
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac
JKAN 'yYnN' "Sure Running the JK Freebsd Raid Script ..... (y/n)" "N"
 if [ $answer = n ] || [ $answer = N ]
 then
        echo -e "\\033[0;37m"byebye!!"\\033[0;39m"
    exit 0
 fi
 echo
}
JKAN()
{
 answer="|"
 until echo $1 | grep $answer >/dev/null
 do
    $echo "${2} [${3}]?  ${nnl}"
    read answer
    if [ "$3" != "" ] && [ "$answer" = "" ]
    then
       answer=$3
    fi
 done
}
JKINIT




if [ "${DISK}" != "" ] ; then

sysctl kern.geom.debugflags=16  >> $LOGFILE
gmirror label -v -b round-robin ${RNAME} ${DISK}  >> $LOGFILE
echo 'geom_mirror_load="YES"' >> /boot/loader.conf
echo "/boot/loader.conf CONFIG"
cat /boot/loader.conf
cp /etc/fstab /etc/fstab.old-$NOWDATE  >> $LOGFILE
echo "#/dev/mirror/${RNAME}s1a  < editor disk name to raid disk name" >> /etc/fstab
clear
$EDITOR /etc/fstab

echo
echo "OK, Pls reboot your system , and run it script slave setting."
echo

else echo
	 echo "ERROr"
fi

}





JKslave()
{
gmirror status
df -h
echo
echo -e "\\033[1;33m"your raid is ? /dev/mirror/${RNAME}s1a"\\033[0;39m"
echo -e "\\033[1;33m"your slave disk is ? ${DISK}"\\033[0;39m"
echo "your raid is ? /dev/mirror/${RNAME}s1a" >> $LOGFILE
echo "your slave disk is ? ${DISK}" >> $LOGFILE



JKINIT4()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;
   x)       echo="echo"       nnl="\c" ;;
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac
JKAN4 'yYnN' "Sure no problem? next run raid slave disk script?..... (y/n)" "N"
 if [ $answer = n ] || [ $answer = N ]
 then
        echo -e "\\033[0;37m"byebye!!"\\033[0;39m"
    exit 0
 fi
 echo
}
JKAN4()
{
 answer="|"
 until echo $1 | grep $answer >/dev/null
 do
    $echo "${2} [${3}]?  ${nnl}"
    read answer
    if [ "$3" != "" ] && [ "$answer" = "" ]
    then
       answer=$3
    fi
 done
}
JKINIT4




if [ "${DISK}" != "" ] ; then



gmirror insert ${RNAME} ${DISK}
gmirror status

else echo
	 echo "ERROr"
fi

}




case "$1" in

master)
jkCheck
JKmaster
;;

slave)
jkCheck
JKslave
;;

*)


echo
echo
echo -e "\\033[1;37m""Welcome to JK System""\\033[0;39m"
echo -e "\\033[1;37m""JK Network Solutions Services""\\033[0;39m"  
echo -e "\\033[1;37m""FreeBSD JK Raid1 Script. - Gmirror""\\033[0;39m"
echo " ------------------------------------- "
echo -e "\\033[1;37m"" DESCRIPTION : ""\\033[0;39m"
echo " 1. reboot or {shutdown now} server to Single User Mode"
echo " 2. Login Root and type { gmirror insert jk0 /dev/ad[?] } ? is your slave disk "
echo " 3. type { gmirror status or list} can see the Raid status or Info. "
echo 
echo " ------------------------------------- "
echo -e "\\033[1;37m" $"usage: {JKRAID.sh} [[master][slave]] [jk[0]] [/dev/ad[0]] , master is raid 1 for the first time ,if master no problem ""\\033[0;39m"
echo -e "\\033[1;37m" $"         run slave {JKRAID.sh} [[slave]] [jk[0]] [/dev/ad[0]] is slave disk. ""\\033[0;39m"
echo
;;
esac

echo -e "\\033[1;33m"FreeBSD JK RAID1 Script."\\033[0;39m"
echo -e "\\033[1;31m"Powered By JackyKit. "\\033[0;39m"
echo -e "\\033[1;32m"- ^_^"\\033[0;39m"

