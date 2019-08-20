#!/bin/sh
#jkupdate.sh 
# FreeBSD JK Upgrade Script. - CVSUP
# Powered By JackyKit. 2002 - 2003
# Version 0.1, 0.2, 0.3, 0.5, 0.9 , 1.0 (09-05-2003)
# Email : admin@3jk.com

#新增 freebsd 4.x 及 5.0 選擇功能



clear
if [ -x /bin/pwd ]; then
        JKNOW=`/bin/pwd`"/"
else
        JKNOW=`pwd`"/"
fi   
LOGFILE=$JKNOW"jkUpgrade.log"
PORTSFILE="ports-supfile"
KERNCOF="JKBSD"
DIRSRC="/usr/src/"
jkfreebsdup() { 
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
id | grep "uid=0(" >/dev/null
if [ $? != "0" ]; then
  uname -a | grep -i CYGWIN >/dev/null
  if [ $? != "0" ]; then
    echo  -e "\\033[0;35m""[Sorry, The JK install script must be run as ROOT]""\\033[0;39m";
    echo " [Sorry, The JK install script must be run as ROOT]" >> $LOGFILE
    echo "";
    exit 0;
  fi
fi
echo -n "  Checking for cvsup ..... "
if [ -x /bin/cvsup ] || [ -x /usr/bin/cvsup ] || [ -x /usr/sbin/cvsup ] || [ -x /usr/local/bin/cvsup ]; then
 echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
 echo -n "  Checking for make ..... "
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
     exit 0;
    else echo -e "\\033[1;35m""Can't Find [CVSup Ports install packages]""\\033[0;39m"
      echo "Can't Find  [CVSup Ports install packages]" >> $LOGFILE
      exit 0
    fi
fi
if [ -x /bin/make ] || [ -x /usr/bin/make ] || [ -x /usr/sbin/make ] || [ -x /usr/local/bin/make ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
cd $DIRSRC 
else echo -e "\\03[1;35m""Can't Find [make]""\\033[0;39m"
echo "Can't Find [make]" >> $LOGFILE3
exit 0
fi
echo -n "  Install script location ..... "
echo -e "\\033[0;37m"[$JKNOW]"\\033[0;39m"
echo -n "  USRdir location ..... "
echo -e "\\033[0;37m"[$DIRSRC]"\\033[0;39m"
echo -n "  Checking for cvsup ..... "
if [ -x ./$CVSFILE ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
else echo -e "\\033[1;35m""Can't Find [$DIRSRC$CVSFILE]""\\033[0;39m"
echo " Can't Find [$DIRSRC$CVSFILE]" >> $LOGFILE
echo "     Now Copy $CVSFILE to $DIRSRC$CVSFILE..";
cp $JKNOW$CVSFILE $DIRSRC$CVSFILE >/dev/null
echo -n "     ReChecking for cvsup ..... "
if [ -x ./$CVSFILE ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
else echo; echo -e "\\033[1;35m""     Can't Find [$DIRSRC$CVSFILE], ""\\033[0;39m"
echo "Can't Find [$DIRSRC$CVSFILE] " >> $LOGFILE
echo "  Now Download the $CVSFILE ..... "
echo "Now Download the $CVSFILE..... " >> $LOGFILE
fetch http://jkzone.net/download/file/$CVSFILE  >> $LOGFILE
chmod 755 $CVSFILE >/dev/null 2>&1 >> $LOGFILE
cp $CVSFILE $JKNOW >/dev/null 2>&1 >> $LOGFILE
echo -n "     ReChecking for cvsup ..... "
echo -n "     ReChecking for cvsup ..... " >> $LOGFILE
if [ -x ./$CVSFILE ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
else echo; echo -e "\\033[1;35m""     Can't Find [$DIRSRC$CVSFILE], ""\\033[0;39m"
echo -e "\\033[1;35m""     Pls MANUAL copy the $CVSFILE in $DIRSRC!""\\033[0;39m"
echo "Sorry , Can't Find [$DIRSRC$CVSFILE] , Pls MANUAL copy the $CVSFILE in $DIRSRC! " >> $LOGFILE
exit 0;
fi
 fi
fi
JKINIT()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;
   x)       echo="echo"       nnl="\c" ;;
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac
JKAN 'yYnN' "Sure Running the JK Freebsd Upgrade Script ..... (y/n)" "N"
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
echo -e "\\033[1;36m"Now, you have About 30 minutes to coffee time. : ] "\\033[0;39m"
echo
echo "CVSUP...." >> $LOGFILE
echo -e "\\033[1;33m"CVSUP....[need 10~15 minutes]"\\033[0;39m"
echo -e "\\033[1;35m"Log and Record on $LOGFILE "\\033[0;39m"
cvsup $DIRSRC$CVSFILE >> $LOGFILE
echo "MAKE BuildWorld....." >> $LOGFILE    
echo -e "\\033[1;33m"MAKE BuildWorld....[need 5~10 minutes]"\\033[0;39m"
make buildworld >> $LOGFILE
echo -e "\\033[1;33m"MAKE Build Kernel...."\\033[0;39m"
echo "MAKE Build Kernel....." >> $LOGFILE
make buildkernel KERNCOF=$KERNCOF >> $LOGFILE
echo -e "\\033[1;33m"MAKE Install Kernel.... [need 3 minutes]"\\033[0;39m"
echo "MAKE Install Kernel....." >> $LOGFILE
make installkernel KERNCOF=$KERNCOF
echo -e "\\033[1;33m"MAKE Install World.... [need 3~5 minutes]"\\033[0;39m"
echo "MAKE Install World....." >> $LOGFILE
make installworld
echo -e "\\033[1;33m"Mergemaster.... [need 1~5 minutes]"\\033[0;39m"
echo "Mergemaster....." >> $LOGFILE
mergemaster  >> $LOGFILE
echo " Upgrade success" >> $LOGFILE
echo " Upgrade success"
date >> $LOGFILE
echo
echo FreeBSD JK Upgrade Script.
echo -e "\\033[1;31m"Powered By JackyKit. 2002-2003 Version 0.1, 0.2, 0.3, 0.5, 0.9"\\033[0;39m"
echo
echo
JKINIT2()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;
   x)       echo="echo"       nnl="\c" ;;
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac
JKAN2 'yYnN' "Sure Upgrade Ports Tree ..... (y/n)" "N"
 if [ $answer = n ] || [ $answer = N ]
 then
        echo -e "\\033[0;37m"byebye!!"\\033[0;39m"
    exit 0
 fi
 echo
}
JKAN2()
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
JKINIT2
echo -n "  Checking for $PORTSFILE ..... "
if [ -x ./$PORTSFILE ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
else echo -e "\\033[1;35m""Can't Find [$DIRSRC$PORTSFILE]""\\033[0;39m"
echo " Can't Find [$DIRSRC$PORTSFILE]" >> $LOGFILE
echo "     Now Copy $PORTSFILE to $DIRSRC$PORTSFILE..";
cp $JKNOW$PORTSFILE $DIRSRC$PORTSFILE >/dev/null
echo -n "     ReChecking for ports-supfile ..... "
if [ -x ./$PORTSFILE ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
else echo; echo -e "\\033[1;35m""     Can't Find [$DIRSRC$PORTSFILE], ""\\033[0;39m"
echo "Can't Find [$DIRSRC$PORTSFILE] " >> $LOGFILE
echo "  Now Download the $PORTSFILE ..... "
echo "Now Download the $PORTSFILE..... " >> $LOGFILE
fetch http://jkzone.net/download/file/$PORTSFILE  >> $LOGFILE
chmod 755 $PORTSFILE >/dev/null 2>&1 >> $LOGFILE
echo -n "     ReChecking for $PORTSFILE ..... "
echo -n "     ReChecking for $PORTSFILE ..... " >> $LOGFILE
if [ -x ./$PORTSFILE ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
else echo; echo -e "\\033[1;35m""     Can't Find [$DIRSRC$PORTSFILE], ""\\033[0;39m"
echo -e "\\033[1;35m""     Pls MANUAL copy the $PORTSFILE in $DIRSRC!""\\033[0;39m"
echo "Sorry , Can't Find [$DIRSRC$PORTSFILE] , Pls MANUAL copy the $PORTSFILE in $DIRSRC! " >> $LOGFILE
exit 0;
fi
fi
fi
echo -e "\\033[1;36m"Now, you have About 10 minutes to coffee time. : ] "\\033[0;39m"
echo
echo "Upgrade Ports Tree ...." >> $LOGFILE
echo -e "\\033[1;33m"Upgrade PORTS TREE....[need 5~10 minutes]"\\033[0;39m"
cvsup -g -z -L 1 ports-supfile
echo " Upgrade Ports Tree success" >> $LOGFILE
echo " Upgrade Ports Tree success"
date >> $LOGFILE
echo
}
case "$1" in
4.x)
CVSFILE="cvsupfile-stable"
CVSLINK="http://jkzone.net/download/file/cvsupfile-stable"
jkfreebsdup
	;;
5.0)
CVSFILE="cvsupfile5_0-stable"
CVSLINK="http://jkzone.net/download/file/cvsupfile5_0-stable"
jkfreebsdup
	;;
*)
clear
echo
echo -e "\\033[1;37m""Welcome to JK System""\\033[0;39m"
echo -e "\\033[1;37m""JK Network Solutions Services""\\033[0;39m"  
echo -e "\\033[1;37m""FreeBSD Upgrade Program""\\033[0;39m"
       echo ""
       echo "What your freebsd version?"
       echo $"Usage: $0 {4.x|5.0}"
       echo ""
	;;
esac
echo FreeBSD JK Upgrade Script.
echo -e "\\033[1;31m"Powered By JackyKit. 2002-2003 Version 0.1, 0.2, 0.3, 0.5, 0.9, 1.0"\\033[0;39m"
echo -e "\\033[1;31m"- 09-05-2003"\\033[0;39m"
echo
echo
