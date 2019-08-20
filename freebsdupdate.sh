#!/bin/sh
#jkupdate.sh
# FreeBSD JK Upgrade Script.
# Powered By JackyKit. 2002
# Version 0.1C

LOGFILE="/tmp/jk.log"
CVSLINK="ftp://freebsd.csie.nctu.edu.tw/pub/CVSup/cvsupfile-stable"
CVSFILE="cvsupfile-stable"
KERNCOF="JKBSD"
DIR="/usr/src"

clear

echo
echo
echo "=========== JK LOG File ===========" > $LOGFILE
echo "Upgrade FreeBSD.........." >> $LOGFILE
echo -e "\\033[1;37m""Welcome to JK System""\\033[0;39m"
echo -e "\\033[1;37m""JK Network Solutions Services""\\033[0;39m"
echo -e "\\033[1;37m""FreeBSD Upgrade Program""\\033[0;39m"
date >> $LOGFILE
echo
echo -e "\\033[1;32m""Upgrade FreeBSD..........""\\033[0;39m"
echo -e "\\033[1;33m"Checking...."\\033[0;39m"
if [ `whoami` = "root" ] ; then

echo -n "  Checking for cvsup ..... "
if [ -x /bin/cvsup ] || [ -x /usr/bin/cvsup ] || [ -x /usr/sbin/cvsup ] || [ -x /usr/local/bin/cvsup ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"

echo -n "  Checking for make ..... "
if [ -x /bin/make ] || [ -x /usr/bin/make ] || [ -x /usr/sbin/make ] || [ -x /usr/local/bin/make ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"

cd $DIR

echo "Fetch CVSFILE" >> $LOGFILE
echo  -e "\\033[1;33m"Fetch CVSFILE"\\033[0;39m"
fetch $CVSLINK >> $LOGFILE
#if [ -x $DIR/$CVSFILE ]; then

echo "CVSUP...." >> $LOGFILE
echo -e "\\033[1;33m"CVSUP...."\\033[0;39m"
cvsup $DIR/$CVSFILE >> $LOGFILE

echo "MAKE BuildWorld....." >> $LOGFILE
echo -e "\\033[1;33m"MAKE BuildWorld.... "\\033[0;39m"
make buildworld

echo -e "\\033[1;33m"MAKE Build Kernel.... "\\033[0;39m"
echo "MAKE Build Kernel....." >> $LOGFILE
make buildkernel KERNCOF=$KERNCOF

echo -e "\\033[1;33m"MAKE Install Kernel.... "\\033[0;39m"
echo "MAKE Install Kernel....." >> $LOGFILE
make installkernel KERNCOF=$KERNCOF

echo -e "\\033[1;33m"MAKE Install World.... "\\033[0;39m"
echo "MAKE Install World....." >> $LOGFILE
make installworld

echo -e "\\033[1;33m"Mergemaster.... "\\033[0;39m"
echo "Mergemaster....." >> $LOGFILE
mergemaster

echo " Upgrade success" >> $LOGFILE
echo " Upgrade success"


#else echo -e "\\033[1;35m""Can't Find [$CVSFILE]""\\033[0;39m"
#echo "Can't Find [$CVSFILE]" >> $LOGFILE
#fi  
else echo -e "\\033[1;35m""Can't Find [make]""\\033[0;39m"   
echo "Can't Find [make]" >> $LOGFILE
fi
else echo -e "\\033[1;35m""Can't Find [cvsup]""\\033[0;39m"
echo "Can't Find [cvsup]" >> $LOGFILE
fi
else echo "\\033[0;35m""SORRY, only root can do that!!""\\033[0;39m"
echo "SORRY, only root can do that!!" >> $LOGFILE
fi

date >> $LOGFILE

echo   
echo 
echo -e "\\033[1;37m""Welcome to JK System""\\033[0;39m"
echo -e "\\033[1;37m""JK Network Solutions Services""\\033[0;39m"
echo -e "\\033[1;37m""FreeBSD Upgrade Program Version 0.1C""\\033[0;39m"
echo
echo 