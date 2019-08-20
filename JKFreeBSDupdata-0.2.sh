#!/bin/sh
#jkupdate.sh 
# FreeBSD JK Upgrade Script. - CVSUP
# Powered By JackyKit. 2002 - 2003
# Version 0.1, 0.2, 0.3, 0.5, 0.9
# Email : admin@3jk.net


LOGFILE="/jk/jkUpgrade.log"
CVSLINK="ftp://freebsd.csie.nctu.edu.tw/pub/CVSup/cvsupfile-stable"
CVSFILE="cvsupfile-stable"
KERNCOF="JKBSD"
DIRSRC="/usr/src/"

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

cd $DIRSRC

#echo "Fetch CVSFILE" >> $LOGFILE
#echo  -e "\\033[1;33m"Fetch CVSFILE"\\033[0;39m"
#fetch $CVSLINK >> $LOGFILE
#if [ -x /usr/src/cvsupfile-stable ]; then

#if [ -x "/usr/src/cvsupfile-stable" ]; then
#echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"








JKINIT()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;      #BSD
   x)       echo="echo"       nnl="\c" ;;  # Sys V
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac

JKAN 'yYnN' " 是否需要繼續CVSup.. (y/n)" "N"
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




echo "CVSUP...." >> $LOGFILE
echo -e "\\033[1;33m"CVSUP...."\\033[0;39m"
cvsup $DIRSRC$CVSFILE >> $LOGFILE

echo "MAKE BuildWorld....." >> $LOGFILE    
echo -e "\\033[1;33m"MAKE BuildWorld.... "\\033[0;39m"
make buildworld

echo -e "\\033[1;33m"MAKE Build Kernel.... "\\033[0;39m"
echo "MAKE Build Kernel....." >> $LOGFILE

#make buildkernel KERNCOF=$KERNCOF

echo -e "\\033[1;33m"MAKE Install Kernel.... "\\033[0;39m"
echo "MAKE Install Kernel....." >> $LOGFILE

#make installkernel KERNCOF=$KERNCOF

echo -e "\\033[1;33m"MAKE Install World.... "\\033[0;39m"
echo "MAKE Install World....." >> $LOGFILE

#make installworld





JKINIT2()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;      #BSD
   x)       echo="echo"       nnl="\c" ;;  # Sys V
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac

JKAN 'yYnN' " 是否需要繼續Mergemaster.. (y/n)" "Y"
 if [ $answer = n ] || [ $answer = N ]
 then
        echo -e "\\033[0;37m"byebye!!"\\033[0;39m"
    exit 0
 fi
 echo
}
JKINIT2





echo -e "\\033[1;33m"Mergemaster.... "\\033[0;39m"
echo "Mergemaster....." >> $LOGFILE

#mergemaster

echo " Upgrade success" >> $LOGFILE
echo " Upgrade success"


#else echo -e "\\033[1;35m""Can't Find [$DIRSRC$CVSFILE]""\\033[0;39m"
#echo "Can't Find [$DIRSRC$CVSFILE]" >> $LOGFILE
#fi
else echo -e "\\033[1;35m""Can't Find [make]""\\033[0;39m"
echo "Can't Find [make]" >> $LOGFILE
fi
else echo -e "\\033[1;35m""Can't Find [cvsup]""\\033[0;39m"
echo "Can't Find [cvsup]" >> $LOGFILE
echo
echo -e "\\033[1;35m""Now Install [CVSup]""\\033[0;39m"
echo "Now Install [CVSup]" >> $LOGFILE
if [ -x /usr/ports/net/cvsup ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
echo "INSTALL"
cd /usr/ports/net/cvsup ;make install clean distclean
echo " CVSup install success" >> $LOGFILE
echo " CVSup install success"
./jkupdate.sh
exit 0
else echo -e "\\033[1;35m""Can't Find [CVSup Ports install packages]""\\033[0;39m"
echo "Can't Find  [CVSup Ports install packages]" >> $LOGFILE
fi
 


fi


else echo "\\033[0;35m""SORRY, only root can do that!!""\\033[0;39m"
echo "SORRY, only root can do that!!" >> $LOGFILE
fi

date >> $LOGFILE

echo
echo FreeBSD JK Upgrade Script.
echo -e "\\033[1;31m"Powered By JackyKit. 2002-2003 Version 0.1, 0.2, 0.3, 0.5, 0.9"\\033[0;39m"
echo
echo
