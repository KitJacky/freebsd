#!/bin/sh
# jkupdate.sh  / JKFreeBSDupdata-1.2_18052006.sh
# FreeBSD JK Upgrade Script. - CVSUP
# Powered By JackyKit. 2002 - 2003 - 2005 - 2006
# Version 0.1, 0.2, 0.3, 0.5, 0.9 , 1.0 (2003), 1.1, 1.2 (18-05-2006)
# Email : jackykit@gmail.com

#新增 freebsd 4.x , 5.x , 6.x,  7.x 選擇功能

#### kernel configuration.
# cd /usr/src/sys/i386/conf  
# Config "GENERIC" (Generic kernel configuration file) and Copy to JKBSD.
#


clear
if [ -x /bin/pwd ]; then
        JKNOW=`/bin/pwd`"/"
else
        JKNOW=`pwd`"/"
fi

FileA="JKFreeBSDupdata-1.3_14052008.sh"
FileB="jkupdate.sh"
NOWDATE=`date "+%Y %m%d%H%M"`
LOGFILE=$JKNOW"jkUpgrade.log"
PORTSFILE="ports-supfile"
KERNCOF="JKBSD"
DIRSRC="/usr/src/"


# Generic Checker
jkfreebsdup() { 
clear

if [ -x $FileA ]; then
echo -e "\\033[0;37m"[FreeBSD JK Upgrade Script  $FileA  FOUND]"\\033[0;39m"
mv $FileA $FileB
./$FileB
else echo -e "\\033[1;35m""Can't Find [ $FileA ]""\\033[0;39m"
echo "Can't Find [ $FileA ]" >> $LOGFILE
	if [ -x $FileB ]; then
		echo -e "\\033[0;37m"[$FileB FOUND]"\\033[0;39m"
	else
		echo "Can't Find [ $FileB ]" >> $LOGFILE
		echo -e "\\033[1;32m""Sorry, the Script Error!""\\033[0;39m"
		echo " [ Sorry, the Script Error! ]" >> $LOGFILE
		exit 0
	fi
fi


	

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

   if [ -x /usr/sbin/pkg_add ]  || [ -x /usr/bin/pkg_add ] || [ -x /usr/sbin/pkg_add ] || [ -x /usr/local/bin/pkg_add ]; then
     echo -e "\\033[0;37m" pkg_add [FOUND], now PKG_ADD install "\\033[0;39m"
     `whereis pkg_add | awk '{print $2}'` -r cvsup-without-gui
     else
      echo "Can't Find [pkg_add] or cvsup-without-gui" >> $LOGFILE
  	  echo
   fi 
   
   if [ -x /bin/cvsup ] || [ -x /usr/bin/cvsup ] || [ -x /usr/sbin/cvsup ] || [ -x /usr/local/bin/cvsup ]; then
    echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
		echo -n "  Checking for make ..... "
   else echo -e "\\033[1;35m""Can't Find [cvsup], now port install""\\033[0;39m"
    
	    if [ -x /usr/ports/net/cvsup-without-gui ]; then
	     echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
	     echo "INSTALL"
	     cd /usr/ports/net/cvsup-without-gui ;make install clean distclean
	     echo " CVSup install success" >> $LOGFILE
	     echo " CVSup install success"
	     ./$FileB
	     exit 0;
	    else echo -e "\\033[1;35m""Can't Find [CVSup Ports install packages]""\\033[0;39m"
	      echo "Can't Find  [CVSup Ports install packages]" >> $LOGFILE
	      exit 0
    fi
	fi
fi



if [ -x /bin/make ] || [ -x /usr/bin/make ] || [ -x /usr/sbin/make ] || [ -x /usr/local/bin/make ]; then
echo -e "\\033[0;37m"[FOUND]"\\033[0;39m"
cd $DIRSRC 
else echo -e "\\03[1;35m""Can't Find [make]""\\033[0;39m"
echo "Can't Find [make]" >> $LOGFILE
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
fetch http://jackykit.com/JKScript/FreeBSD/cvsup/$CVSFILE  >> $LOGFILE
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
}



##### Kernel Cvsup
jkSysCvsup()
{
	
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



	
echo -e "\\033[1;36m" Now, CVSUP your new kernel Source : ] "\\033[0;39m"
echo
echo "CVSUP...." >> $LOGFILE
echo -e "\\033[1;33m" CVSUP....[need 10~15 minutes] "\\033[0;39m"
echo -e "\\033[1;35m" Log and Record on $LOGFILE "\\033[0;39m"
cvsup $DIRSRC$CVSFILE >> $LOGFILE

echo
echo "   Check the log, Sure no problem TYPE $FileB {kconfig 4|5|6}"
echo


}


jkKernel ()
{
echo
echo -n "  Checking for editor pico ..... "
if [ -x /bin/pico ] || [ -x /usr/bin/pico ] || [ -x /usr/sbin/pico ] || [ -x /usr/local/bin/pico ]; then
echo -e "\\033[0;37m" [FOUND] "\\033[0;39m"
EDITOR="pico"
else echo -e "\\03[1;35m""Can't Find [pico] use [ee] editor""\\033[0;39m"
echo "Can't Find [pico] use ee editor" >> $LOGFILE
EDITOR="ee"
exit 0
fi



echo -e "\\033[1;36m" Auto backup original file to GENERIC_$NOWDATE and Generic kernel configuration"\\033[0;39m"
cp /usr/src/sys/i386/conf/GENERIC /usr/src/sys/i386/conf/GENERIC_$NOWDATE
$EDITOR /usr/src/sys/i386/conf/GENERIC

echo -e "\\033[1;36m" GENERIC copy to $KERNCOF "\\033[0;39m"
cp /usr/src/sys/i386/conf/GENERIC /usr/src/sys/i386/conf/$KERNCOF  >> $LOGFILE

echo "   config $KERNCOF........" >> $LOGFILE
echo -e "\\033[1;33m"CONFIG $KERNCOF...."\\033[0;39m"
cd /usr/src/sys/i386/conf >> $LOGFILE
config ./$KERNCOF >> $LOGFILE
cd /usr/src/sys/i386/compile/$KERNCOF >> $LOGFILE
echo -e "\\033[1;33m"MAKE depend 1...."\\033[0;39m"
echo "   make depend 1.........." >> $LOGFILE
make cleandepend ; make depend >> $LOGFILE
echo -e "\\033[1;33m"MAKE 2...."\\033[0;39m"
echo "   make 2........." >> $LOGFILE
make >> $LOGFILE
echo -e "\\033[1;33m"MAKE INSTALL 3.END...."\\033[0;39m"
echo "   make install 3.END........" >> $LOGFILE
make install >> $LOGFILE

echo
echo "   Check the Log, Sure no problem. "
echo 
}

jkbuild ()
{
JKINIT3()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;
   x)       echo="echo"       nnl="\c" ;;
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac
JKAN3 'yYnN' "Sure no problem? then next ..... (y/n)" "N"
 if [ $answer = n ] || [ $answer = N ]
 then
        echo -e "\\033[0;37m"byebye!!"\\033[0;39m"
    exit 0
 fi
 echo
}
JKAN3()
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

cd $DIRSRC
echo -e "\\033[1;36m"Now, you have over and above 30 ~ 60 minutes to coffee time. : ] "\\033[0;39m"
echo

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


JKINIT4()
{
case "`echo 'x\c'`" in
   'x\c')   echo="echo -n"    nnl= ;;
   x)       echo="echo"       nnl="\c" ;;
   *)       echo "$0 quitting:  Can't set up echo." ; exit 1 ;;
esac
JKAN4 'yYnN' "Sure no problem? next run Mergemaster?..... (y/n)" "N"
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

echo -e "\\033[1;33m"Mergemaster.... [need 1~5 minutes]"\\033[0;39m"
echo "Mergemaster....." >> $LOGFILE
mergemaster
echo " Upgrade success" >> $LOGFILE
echo " Upgrade success"
date >> $LOGFILE
echo
echo FreeBSD JK Upgrade Script.
echo -e "\\033[1;31m"Powered By JackyKit. 2002-2005 Version 0.1, 0.2, 0.3, 0.5, 0.9"\\033[0;39m"
echo
echo
}








## PORT UP
jkportsup ()
{
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
fetch http://jackykit.com/JKScript/FreeBSD/cvsup/$PORTSFILE  >> $LOGFILE
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




# Case
case "$1" in

ports)
jkfreebsdup
jkportsup
	;;
	
cvssrc)
CVSFILE="cvsupfile$2_0-stable"
CVSLINK="http://jackykit.com/JKScript/FreeBSD/cvsup/cvsupfile$2_0-stable"
jkfreebsdup
jkSysCvsup
	;;

kernel)
CVSFILE="cvsupfile$2_0-stable"
CVSLINK="http://jackykit.com/JKScript/FreeBSD/cvsup/cvsupfile$2_0-stable"
jkfreebsdup
jkKernel
	;;
		
build)
CVSFILE="cvsupfile$2_0-stable"
CVSLINK="http://jackykit.com/JKScript/FreeBSD/cvsup/cvsupfile$2_0-stable"
jkfreebsdup
jkbuild
	;;
*)


clear
echo
echo -e "\\033[1;37m""Welcome to JK System""\\033[0;39m"
echo -e "\\033[1;37m""JK Network Solutions Services""\\033[0;39m"  
echo -e "\\033[1;37m""FreeBSD Upgrade Program""\\033[0;39m"
       echo ""
       echo -e "\\033[1;37m"" DESCRIPTION : ""\\033[0;39m"
       echo "[ports] is cvsup PORTS tree Upgrade only"
       echo "[cvssrc] cvsup your Sources for everything "
       echo "[kconfig] Config and install your Kernel"
       echo "[build] is build system."
       echo "  {4|5|6} your freebsd version."
       echo
       echo -e "\\033[1;37m" $"Usage: $0""\\033[0;39m"
       echo "        { ports | cvssrc {4|5|6|7} | kernel {4|5|6|7} | build {4|5|6|7} }"
       echo ""
	;;
esac
echo -e "\\033[1;33m"FreeBSD JK Upgrade Script."\\033[0;39m"
echo -e "\\033[1;31m"Powered By JackyKit. 2002-2008 Version 0.1, 0.2, 0.3, 0.5, 0.9, 1.0{2003}, 1.1, 1.2{2006}, 1.3{14-05-2008}"\\033[0;39m"
echo -e "\\033[1;32m"jackykit@gmail.com"\\033[0;39m"
echo -e "\\033[1;32m"      ^_^     "\\033[0;39m"
echo
echo
